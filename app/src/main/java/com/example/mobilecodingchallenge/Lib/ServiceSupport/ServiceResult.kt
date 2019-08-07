package com.example.mobilecodingchallenge

enum class ServiceResultCase {
    Success, Failure
}

open class ServiceResult<T> {
    val case: ServiceResultCase
    private var responseObject: T?
    private var error: String?

    constructor(responseObj: T) {
        this.responseObject = responseObj
        this.error = null
        this.case = ServiceResultCase.Success
    }

    constructor(errorMessage: String) {
        this.responseObject = null
        this.error = errorMessage
        this.case = ServiceResultCase.Failure
    }

    fun success(): T? {
        return responseObject
    }

    fun error(): String? {
        return error
    }
}