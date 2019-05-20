package io.psisoft.codechallenge.util;

import android.arch.paging.PageKeyedDataSource;
import android.support.annotation.NonNull;

import io.psisoft.codechallenge.api.ApiService;
import io.psisoft.codechallenge.model.GithubRepository;
import io.psisoft.codechallenge.model.GithubResponse;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;


public class RepositoryDataSource extends PageKeyedDataSource<Integer, GithubRepository> {

    public static final int FIRST_PAGE = 1;
    private static final String SORTED_BY = "stars";
    private static final String ORDER = "desc";
    private static final String LIST_SIZE = "created:>2017-10-22";

    @Override
    public void loadInitial(@NonNull LoadInitialParams<Integer> params, @NonNull LoadInitialCallback<Integer, GithubRepository> callback) {

        // Load data for the first page
        ApiService.getInstance()
                .getApiHelper()
                .getGithubRepositories(LIST_SIZE, SORTED_BY, ORDER, FIRST_PAGE)
                .enqueue(new Callback<GithubResponse>() {
                    @Override
                    public void onResponse(Call<GithubResponse> call, Response<GithubResponse> response) {

                        if (response.body() != null) {
                            callback.onResult(response.body().getItems(), null, FIRST_PAGE + 1);
                        }

                    }

                    @Override
                    public void onFailure(Call<GithubResponse> call, Throwable t) {
                        //TODO: I should treat the failure case --> this is a feature
                    }
                });

    }

    @Override
    public void loadBefore(@NonNull LoadParams<Integer> params, @NonNull LoadCallback<Integer, GithubRepository> callback) {

        // Load data for the previews page
        ApiService.getInstance()
                .getApiHelper()
                .getGithubRepositories(LIST_SIZE, SORTED_BY, ORDER, params.key)
                .enqueue(new Callback<GithubResponse>() {
                    @Override
                    public void onResponse(Call<GithubResponse> call, Response<GithubResponse> response) {

                        if (response.body() != null) {
                            Integer key = (params.key > 1) ? params.key - 1 : null;
                            callback.onResult(response.body().getItems(), key);
                        }
                    }

                    @Override
                    public void onFailure(Call<GithubResponse> call, Throwable t) {
                        //TODO: I should treat the failure case --> this is a feature
                    }
                });

    }

    @Override
    public void loadAfter(@NonNull LoadParams<Integer> params, @NonNull LoadCallback<Integer, GithubRepository> callback) {

        // Load data for the next page
        ApiService.getInstance()
                .getApiHelper()
                .getGithubRepositories(LIST_SIZE, SORTED_BY, ORDER, params.key)
                .enqueue(new Callback<GithubResponse>() {
                    @Override
                    public void onResponse(Call<GithubResponse> call, Response<GithubResponse> response) {

                        if (response.body() != null) {
                            Integer key = response.body().isIncompleteResults() ? params.key + 1 : null;
                            callback.onResult(response.body().getItems(), key);
                        }

                    }

                    @Override
                    public void onFailure(Call<GithubResponse> call, Throwable t) {
                        //TODO: I should treat the failure case --> this is a feature
                    }
                });

    }


}
