package io.psisoft.codechallenge.api;

import io.psisoft.codechallenge.model.GithubResponse;
import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Query;

public interface ApiHelper {

    /**
     * Get github repositories from API.
     *
     * @param order desc or asc order
     * @param sort  sorted attribute
     * @param createdDate page size
     * @param page page number
     *
     * @return GithubRepositories
     */
    @GET("search/repositories")
    Call<GithubResponse> getGithubRepositories(
            @Query("q") String createdDate,
            @Query("sort") String sort,
            @Query("order") String order,
            @Query("page") int page
            );
}
