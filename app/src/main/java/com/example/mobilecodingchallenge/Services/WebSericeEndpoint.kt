package com.example.mobilecodingchallenge

import com.android.volley.Request

class WebSericeEndpoint(val queryString: String): Endpoint {

    override fun method(): Int {
        return Request.Method.GET
    }

    override fun url(): String {
        return "https://api.github.com/search/repositories?" + queryString
    }

    override fun classType(): Class<Any> {
        return GitHubRepo().javaClass
    }

    override fun headers(): Map<String, String> {
        return super.headers().plus(mapOf("Content-Type" to "application/json; charset=UTF-8"))
    }

}
