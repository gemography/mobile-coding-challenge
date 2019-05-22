package io.psisoft.codechallenge.ui;

import android.arch.lifecycle.ViewModelProviders;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.v4.app.Fragment;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ProgressBar;
import android.widget.Toast;

import butterknife.BindView;
import butterknife.ButterKnife;
import io.psisoft.codechallenge.R;
import io.psisoft.codechallenge.adapter.RepositoryAdapter;
import io.psisoft.codechallenge.api.Status;

public class Trending extends Fragment {

    @BindView(R.id.trending_recyclerView)
    RecyclerView trendingRecyclerView;
    @BindView(R.id.progress_circular)
    ProgressBar progressBar;

    public Trending() {
        // Required empty public constructor
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_trending, container, false);
        ButterKnife.bind(this, view);

        // Setup trending recycler view
        trendingRecyclerView.setLayoutManager(new LinearLayoutManager(getContext()));
        trendingRecyclerView.setHasFixedSize(true);

        RepositoryViewModel itemViewModel = ViewModelProviders.of(this).get(RepositoryViewModel.class);
        final RepositoryAdapter adapter = new RepositoryAdapter();

        // Observe itemPagedList
        itemViewModel.getItemPagedList().observe(this, adapter::submitList);

        // Observe the Network state
        itemViewModel.getNetworkState().observe(this, networkState -> {

            //TODO: In this task, I only treated a few network states.
            // However, I can add further features to treat error messages.

            if (networkState != null && networkState.getStatus() == Status.NOT_INITIALIZED) {
                progressBar.setVisibility(View.GONE);
                Toast.makeText(getContext(), networkState.getMsg(), Toast.LENGTH_LONG).show();
            }

            if (networkState != null && networkState.getStatus() == Status.INITIALIZED) {
                progressBar.setVisibility(View.GONE);
            }

            if (networkState != null && networkState.getStatus() == Status.FAILED) {
                Toast.makeText(getContext(), networkState.getMsg(), Toast.LENGTH_LONG).show();
            }

        });

        trendingRecyclerView.setAdapter(adapter);

        return view;
    }

    @Override
    public void onStart() {
        super.onStart();

    }

}
