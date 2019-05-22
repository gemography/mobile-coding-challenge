package io.psisoft.codechallenge.utils;

import android.arch.lifecycle.MutableLiveData;
import android.arch.paging.DataSource;

public class RepositoryDataSourceFactory extends DataSource.Factory {

    private MutableLiveData<RepositoryDataSource> repositoryLiveDataSource = new MutableLiveData<>();

    @Override
    public DataSource create() {
        RepositoryDataSource repositoryDataSource = new RepositoryDataSource();
        repositoryLiveDataSource.postValue(repositoryDataSource);
        return repositoryDataSource;
    }

    public MutableLiveData<RepositoryDataSource> getItemLiveDataSource() {
        return repositoryLiveDataSource;
    }
}
