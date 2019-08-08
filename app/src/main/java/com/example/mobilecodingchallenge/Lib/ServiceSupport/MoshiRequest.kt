package com.example.mobilecodingchallenge

import com.android.volley.*
import com.android.volley.toolbox.HttpHeaderParser
import com.android.volley.toolbox.JsonRequest
import com.example.mobilecodingchallenge.ErrorParser.errorFromResponse
import com.squareup.moshi.Json
import com.squareup.moshi.JsonAdapter
import com.squareup.moshi.JsonClass
import com.squareup.moshi.Moshi
import com.squareup.moshi.kotlin.reflect.KotlinJsonAdapterFactory
import java.io.UnsupportedEncodingException
import java.lang.Error
import java.nio.charset.Charset

open class MoshiJsonRequest<T>(endpoint: Endpoint, listener: Response.Listener<T>,
                               errorListener: Response.ErrorListener) : JsonRequest<T>(endpoint.method(), endpoint.url(), endpoint.body(), listener, errorListener) {
    private val mListener: Response.Listener<T>
    private var mMoshi: Moshi = Moshi.Builder()
            .add(KotlinJsonAdapterFactory())
            .build()
    private val tAdapter: JsonAdapter<T>
    private val mBody: String
    private val mHeaders: Map<String, String>
    private val mContentType: String?
    private val defaultContentType = "application/json; charset=UTF-8"

    init {
        if (endpoint.adapter(mMoshi) == null) {
            tAdapter = mMoshi.adapter<T>(endpoint.classType())
        } else {
            val adapter = endpoint.adapter(mMoshi) as JsonAdapter<T>
            tAdapter = adapter
        }
        mListener = listener
        mBody = endpoint.body()
        mContentType = endpoint.bodyContentType()
        mHeaders = endpoint.headers()
    }

    override fun getBodyContentType(): String {
        if (mContentType != null) {
            return mContentType
        }
        return defaultContentType
    }

    @Throws(AuthFailureError::class)
    override fun getHeaders(): Map<String, String> {
        return mHeaders
    }

    override fun parseNetworkResponse(response: NetworkResponse): Response<T> {
        try {
            val jsonString = String(
                    response.data ?: ByteArray(0),
                    Charset.forName(HttpHeaderParser.parseCharset(response.headers)))
            val parsedObject = tAdapter.fromJson(jsonString)
            if (parsedObject == null) {
                val error = errorFromResponse(jsonString)
                if (error != null) {
                    return Response.error(error)
                } else {
                    return Response.error(VolleyError("Unrecognized Response"))
                }
            }
            return Response.success(parsedObject,
                    HttpHeaderParser.parseCacheHeaders(response))
        } catch (e: UnsupportedEncodingException) {
            return Response.error(ParseError(e))
        } catch (je: Error) {
            return Response.error(ParseError(je))
        }
    }

    override fun deliverResponse(response: T) = mListener.onResponse(response)
}

    @JsonClass(generateAdapter = true)
    data class APIErrorResponse(@Json(name = "SUCCESS") val error: GitHubError?)

    @JsonClass(generateAdapter = true)
    data class GitHubError(@Json(name = "error_code") val errorCode: String?, @Json(name = "error_message") val errorMessage: String?, @Json(name = "error_summary") val errorSummary: String?, @Json(name = "status") val status: Int?) {

        fun volleyError(): VolleyError? {
            if (errorMessage != null) else return null
            return VolleyError(errorMessage)
        }
    }

    object ErrorParser {
        private var mMoshi: Moshi = Moshi.Builder()
            .add(KotlinJsonAdapterFactory())
            .build()

        fun errorFromResponse(jsonString: String): VolleyError? {
            if (jsonString.contains("SUCCESS", true)) {
                val errorResponseAdapter = mMoshi.adapter<APIErrorResponse>(APIErrorResponse(null).javaClass)
                val errorResponse = errorResponseAdapter.fromJson(jsonString)
                return errorResponse?.error?.volleyError()
            } else {
                val errorAdapter = mMoshi.adapter<GitHubError>(GitHubError(null, null, null, null).javaClass)
                val error = errorAdapter.fromJson(jsonString)
                return error?.volleyError()
            }
        }

        fun errorMessageFrom(volleyError: VolleyError): String? {
            try {
                val jsonString = String(
                        volleyError.networkResponse?.data ?: ByteArray(0),
                        Charset.forName(HttpHeaderParser.parseCharset(volleyError.networkResponse?.headers)))
                println(jsonString)
                if (jsonString.contains("SUCCESS", true)){
                    val errorResponseAdapter = mMoshi.adapter<APIErrorResponse>(APIErrorResponse(null).javaClass)
                    val errorResponse = errorResponseAdapter.fromJson(jsonString)
                    return errorResponse?.error?.errorMessage
                } else {
                    val errorAdapter = mMoshi.adapter<GitHubError>(GitHubError(null, null, null, null).javaClass)
                    val error = errorAdapter.fromJson(jsonString)
                    return error?.errorMessage
                }
            }
            catch (e: Exception) {
                return e.localizedMessage
            }
        }
    }