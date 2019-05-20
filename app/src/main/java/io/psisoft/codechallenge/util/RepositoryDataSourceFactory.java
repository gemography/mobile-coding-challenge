package io.psisoft.codechallenge.util;

import android.arch.lifecycle.MutableLiveData;
import android.arch.paging.DataSource;
import android.arch.paging.PageKeyedDataSource;

import io.psisoft.codechallenge.model.GithubRepository;

public class RepositoryDataSourceFactory extends DataSource.Factory {

    private MutableLiveData<PageKeyedDataSource<Integer, GithubRepository>> repositoryLiveDataSource = new MutableLiveData<>();

    @Override
    public DataSource create() {
        RepositoryDataSource repositoryDataSource = new RepositoryDataSource();
        repositoryLiveDataSource.postValue(repositoryDataSource);
        return repositoryDataSource;
    }

    public MutableLiveData<PageKeyedDataSource<Integer, GithubRepository>> getItemLiveDataSource() {
        return repositoryLiveDataSource;
    }
}
