package io.psisoft.codechallenge.ui;

import android.arch.core.util.Function;
import android.arch.lifecycle.LiveData;
import android.arch.lifecycle.Transformations;
import android.arch.lifecycle.ViewModel;
import android.arch.paging.LivePagedListBuilder;
import android.arch.paging.PagedList;

import io.psisoft.codechallenge.api.NetworkState;
import io.psisoft.codechallenge.model.GithubRepository;
import io.psisoft.codechallenge.utils.RepositoryDataSource;
import io.psisoft.codechallenge.utils.RepositoryDataSourceFactory;

public class RepositoryViewModel extends ViewModel {

    private LiveData<PagedList<GithubRepository>> itemPagedList;
    private LiveData<RepositoryDataSource> myDataSource;
    private LiveData<NetworkState> networkState;

    private static final int PAGE_SIZE = 30;

    public RepositoryViewModel() {
        init();
    }

    public void init() {

        RepositoryDataSourceFactory itemDataSourceFactory = new RepositoryDataSourceFactory();
        myDataSource = itemDataSourceFactory.getItemLiveDataSource();

        networkState = Transformations.switchMap(myDataSource,
                (Function<RepositoryDataSource, LiveData<NetworkState>>) RepositoryDataSource::getNetworkState);

        PagedList.Config config =
                (new PagedList.Config.Builder())
                        .setEnablePlaceholders(false)
                        .setPageSize(PAGE_SIZE)
                        .build();

        itemPagedList = (new LivePagedListBuilder(itemDataSourceFactory, config)).build();


    }

    public LiveData<PagedList<GithubRepository>> getItemPagedList() {
        return itemPagedList;
    }

    public LiveData<NetworkState> getNetworkState() {
        return networkState;
    }
}
