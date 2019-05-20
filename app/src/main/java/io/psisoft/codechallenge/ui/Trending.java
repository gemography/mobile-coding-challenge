package io.psisoft.codechallenge.ui;

import android.arch.lifecycle.Observer;
import android.arch.lifecycle.ViewModelProviders;
import android.arch.paging.PagedList;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import butterknife.BindView;
import butterknife.ButterKnife;
import io.psisoft.codechallenge.R;
import io.psisoft.codechallenge.adapter.RepositoryAdapter;
import io.psisoft.codechallenge.model.GithubRepository;

public class Trending extends Fragment {

    @BindView(R.id.trending_recyclerView)
    RecyclerView trendingRecyclerView;

    public Trending() {
        // Required empty public constructor
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_trending, container, false);
        ButterKnife.bind(this, view);

        // Setup trending recycler view
        trendingRecyclerView.setLayoutManager(new LinearLayoutManager(getContext()));
        trendingRecyclerView.setHasFixedSize(true);

        RepositoryViewModel itemViewModel = ViewModelProviders.of(this).get(RepositoryViewModel.class);
        final RepositoryAdapter adapter = new RepositoryAdapter();

        itemViewModel.itemPagedList.observe(this, (Observer<PagedList<GithubRepository>>) items -> adapter.submitList(items));

        trendingRecyclerView.setAdapter(adapter);
        return view;
    }

    @Override
    public void onStart() {
        super.onStart();

    }

}
