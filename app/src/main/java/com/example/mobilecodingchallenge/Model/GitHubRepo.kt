package com.example.mobilecodingchallenge

import com.squareup.moshi.Json
import com.squareup.moshi.JsonClass

@JsonClass(generateAdapter = true)
data class GitHubRepo(@Json(name = "total_count") var totalCounts: Int = 0, @Json(name = "items") var gitHubRepo: List<Items> = listOf()) {
}

@JsonClass(generateAdapter = true)
data class Items(@Json(name = "id") var repoId: String? = null,
                      @Json(name = "name") var repoName: String? = null,
                      @Json(name = "description") var repoDescription: String? = null,
                      @Json(name = "owner") var repoOwner: RepoOwner? = RepoOwner("",""),
                      @Json(name = "stargazers_count") var repoStars: Int? = 0) {

}

@JsonClass(generateAdapter = true)
data class RepoOwner(@Json(name = "login") var login: String,
                     @Json(name = "avatar_url") var avatar: String) {
}