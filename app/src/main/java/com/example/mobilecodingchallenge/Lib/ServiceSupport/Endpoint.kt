package com.example.mobilecodingchallenge

import com.squareup.moshi.JsonAdapter
import com.squareup.moshi.Moshi

interface Endpoint {

    fun method(): Int //.raw RequestMethod
    fun url(): String
    fun classType(): Class<Any>
    fun adapter(moshi: Moshi): JsonAdapter<Any>? = null
    fun headers(): Map<String, String> = emptyMap()
    fun body(): String = ""
    fun bodyContentType(): String? = null

}