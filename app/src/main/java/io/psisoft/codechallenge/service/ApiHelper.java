package io.psisoft.codechallenge.service;

import io.psisoft.codechallenge.model.GithubResponse;
import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Multipart;
import retrofit2.http.Query;

public interface ApiHelper {

    /**
     * Get github repositories from API.
     *
     * @param order order of repositories
     * @param sort  desc or asc sorting
     * @param createdDate qsdqs
     *
     * @return GithubRepositories
     */
    @GET("search/repositories")
    Call<GithubResponse> getGithubRepositories(
            @Query("q") String createdDate,
            @Query("sort") String sort,
            @Query("order") String order
            );
}
