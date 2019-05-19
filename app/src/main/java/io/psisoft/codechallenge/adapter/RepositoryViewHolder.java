package io.psisoft.codechallenge.adapter;

import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import butterknife.BindView;
import butterknife.ButterKnife;
import io.psisoft.codechallenge.R;
import io.psisoft.codechallenge.model.GithubRepository;

public class RepositoryViewHolder extends RecyclerView.ViewHolder {

    @BindView(R.id.repository_name)
    TextView repositoryName;
    @BindView(R.id.repository_description)
    TextView repositoryDescription;
    @BindView(R.id.owner_image)
    ImageView ownerImage;
    @BindView(R.id.owner_name)
    TextView ownerName;
    @BindView(R.id.repository_stars)
    TextView repositoryStars;


    public RepositoryViewHolder(@NonNull View itemView) {
        super(itemView);
        ButterKnife.bind(this, itemView);
    }

    public void bindData(GithubRepository githubRepository){
        repositoryName.setText(githubRepository.getName());
        repositoryDescription.setText(githubRepository.getDescription());
        repositoryStars.setText(githubRepository.getScore());
        ownerName.setText(githubRepository.getOwner().getLogin());
    }
}
