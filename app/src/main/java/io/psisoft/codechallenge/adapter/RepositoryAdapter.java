package io.psisoft.codechallenge.adapter;

import android.arch.paging.PagedListAdapter;
import android.support.annotation.NonNull;
import android.support.v7.util.DiffUtil;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import io.psisoft.codechallenge.R;
import io.psisoft.codechallenge.model.GithubRepository;

public class RepositoryAdapter extends PagedListAdapter<GithubRepository, RepositoryViewHolder> {

    private RepositoryAdapter() {
        super(DIFF_CALLBACK);
    }

    private static DiffUtil.ItemCallback<GithubRepository> DIFF_CALLBACK =
            new DiffUtil.ItemCallback<GithubRepository>() {

                @Override
                public boolean areItemsTheSame(GithubRepository oldGithubRepository, GithubRepository newGithubRepository) {
                    return oldGithubRepository.getId() == newGithubRepository.getId();
                }

                @Override
                public boolean areContentsTheSame(GithubRepository oldGithubRepository,
                                                  GithubRepository newGithubRepository) {
                    return oldGithubRepository.equals(newGithubRepository);
                }
            };


    @NonNull
    @Override
    public RepositoryViewHolder onCreateViewHolder(@NonNull ViewGroup viewGroup, int i) {
        View view = LayoutInflater.from(viewGroup.getContext()).inflate(R.layout.repository_item_view, viewGroup, false);
        return new RepositoryViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull RepositoryViewHolder repositoryViewHolder, int i) {

        GithubRepository item = getItem(i);

        if(item != null) {
            repositoryViewHolder.bindData(item);
        }else{
            // TODO: make an action here
        }

    }
}
