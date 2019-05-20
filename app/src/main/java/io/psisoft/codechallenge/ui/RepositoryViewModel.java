package io.psisoft.codechallenge.ui;

import android.arch.lifecycle.LiveData;
import android.arch.lifecycle.ViewModel;
import android.arch.paging.LivePagedListBuilder;
import android.arch.paging.PageKeyedDataSource;
import android.arch.paging.PagedList;

import io.psisoft.codechallenge.model.GithubRepository;
import io.psisoft.codechallenge.util.RepositoryDataSourceFactory;

public class RepositoryViewModel extends ViewModel {

    LiveData<PagedList<GithubRepository>> itemPagedList;
    LiveData<PageKeyedDataSource<Integer, GithubRepository>> liveDataSource;

    private static final int PAGE_SIZE = 30;

    public RepositoryViewModel() {

        RepositoryDataSourceFactory itemDataSourceFactory = new RepositoryDataSourceFactory();
        liveDataSource = itemDataSourceFactory.getItemLiveDataSource();

        PagedList.Config config =
                (new PagedList.Config.Builder())
                        .setEnablePlaceholders(false)
                        .setPageSize(PAGE_SIZE)
                        .build();

        itemPagedList = (new LivePagedListBuilder(itemDataSourceFactory, config)).build();

    }
}
