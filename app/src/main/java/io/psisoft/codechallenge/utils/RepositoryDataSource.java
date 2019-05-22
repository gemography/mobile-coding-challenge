package io.psisoft.codechallenge.utils;

import android.arch.lifecycle.MutableLiveData;
import android.arch.paging.PageKeyedDataSource;
import android.support.annotation.NonNull;

import io.psisoft.codechallenge.api.ApiService;
import io.psisoft.codechallenge.api.NetworkState;
import io.psisoft.codechallenge.model.GithubResponse;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;


public class RepositoryDataSource extends PageKeyedDataSource {

    public static final int FIRST_PAGE = 1;
    private static final String SORTED_BY = "stars";
    private static final String ORDER = "desc";
    private static final String LIST_SIZE = "created:>2017-10-22";

    private ApiService apiService;
    private MutableLiveData<NetworkState> networkState;


    public RepositoryDataSource() {
        apiService = ApiService.getInstance();
        networkState = new MutableLiveData<>();
    }

    @Override
    public void loadInitial(@NonNull LoadInitialParams params, @NonNull LoadInitialCallback callback) {

        networkState.postValue(NetworkState.LOADING);

        // Load data for the first page
        apiService.getApiHelper()
                .getGithubRepositories(LIST_SIZE, SORTED_BY, ORDER, FIRST_PAGE)
                .enqueue(new Callback<GithubResponse>() {
                    @Override
                    public void onResponse(Call<GithubResponse> call, Response<GithubResponse> response) {

                        if (response.isSuccessful() && response.body() != null) {
                            callback.onResult(response.body().getItems(), null, FIRST_PAGE + 1);
                            networkState.postValue(NetworkState.INITIALIZED);
                        } else {
                            networkState.postValue(NetworkState.NOT_INITIALIZED);
                        }

                    }

                    @Override
                    public void onFailure(Call<GithubResponse> call, Throwable t) {
                        networkState.postValue(NetworkState.NOT_INITIALIZED);
                    }
                });
    }

    @Override
    public void loadBefore(@NonNull LoadParams params, @NonNull LoadCallback callback) {

        networkState.postValue(NetworkState.LOADING);

        // Load data for the previews page
        apiService.getApiHelper()
                .getGithubRepositories(LIST_SIZE, SORTED_BY, ORDER, (int) params.key)
                .enqueue(new Callback<GithubResponse>() {
                    @Override
                    public void onResponse(Call<GithubResponse> call, Response<GithubResponse> response) {

                        if (response.isSuccessful() && response.body() != null) {
                            Integer key = ((int) params.key > 1) ? (int) params.key - 1 : null;
                            callback.onResult(response.body().getItems(), key);
                            networkState.postValue(NetworkState.LOADED);
                        } else {
                            networkState.postValue(NetworkState.FAILED);
                        }

                    }

                    @Override
                    public void onFailure(Call<GithubResponse> call, Throwable t) {
                        networkState.postValue(NetworkState.FAILED);
                    }
                });

    }

    @Override
    public void loadAfter(@NonNull LoadParams params, @NonNull LoadCallback callback) {

        networkState.postValue(NetworkState.LOADING);

        // Load data for the next page
        apiService.getApiHelper()
                .getGithubRepositories(LIST_SIZE, SORTED_BY, ORDER, (int) params.key)
                .enqueue(new Callback<GithubResponse>() {
                    @Override
                    public void onResponse(Call<GithubResponse> call, Response<GithubResponse> response) {

                        if (response.isSuccessful() && response.body() != null) {
                            Integer key = response.body().isIncompleteResults() ? (int) params.key + 1 : null;
                            callback.onResult(response.body().getItems(), key);
                            networkState.postValue(NetworkState.LOADED);
                        } else {
                            networkState.postValue(NetworkState.FAILED);
                        }

                    }

                    @Override
                    public void onFailure(Call<GithubResponse> call, Throwable t) {
                        networkState.postValue(NetworkState.FAILED);
                    }
                });

    }

    public MutableLiveData getNetworkState() {
        return networkState;
    }
}
