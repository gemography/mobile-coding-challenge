package com.example.mobilecodingchallenge

import android.content.Context
import com.android.volley.Response
import com.android.volley.toolbox.Volley

object WebService {

    fun callService(context: Context, queryString: String, completion: (GitHubRepo) -> Unit, failure: (String) -> Unit) {

        val endpoint = WebSericeEndpoint(queryString)

        val gitHubRepoRequest: MoshiJsonRequest<GitHubRepo> = MoshiJsonRequest(
            endpoint = endpoint,
            listener = Response.Listener { response ->
                val repo = response
                completion(repo)
            },
            errorListener = Response.ErrorListener { error ->
                if (error != null) else {
                    failure("Received unknown error")
                }
                val message = error.message

                val errorMsg = ErrorParser.errorMessageFrom(error)
                if (message == null) {
                    if (errorMsg != null){
                        failure(errorMsg)
                    } else {
                        failure("Received unknown error")
                    }
                } else {
                    failure(message)
                }
            })
        Volley.newRequestQueue(context).add(gitHubRepoRequest)
    }
}