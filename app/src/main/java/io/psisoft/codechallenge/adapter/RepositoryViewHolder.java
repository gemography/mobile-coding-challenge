package io.psisoft.codechallenge.adapter;

import android.content.Context;
import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.bumptech.glide.Glide;

import java.util.Map;
import java.util.NavigableMap;
import java.util.TreeMap;

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

    private Context context;
    private static final NavigableMap<Long, String> suffixes = new TreeMap<>();

    static {
        suffixes.put(1_000L, "k");
        suffixes.put(1_000_000L, "M");
        suffixes.put(1_000_000_000L, "G");
        suffixes.put(1_000_000_000_000L, "T");
        suffixes.put(1_000_000_000_000_000L, "P");
        suffixes.put(1_000_000_000_000_000_000L, "E");
    }


    public RepositoryViewHolder(@NonNull View itemView) {
        super(itemView);
        ButterKnife.bind(this, itemView);

        context = itemView.getContext();
    }

    // Bind data to the ViewHolder
    public void bindData(GithubRepository githubRepository) {

        repositoryName.setText(githubRepository.getName());
        repositoryDescription.setText(githubRepository.getDescription());
        repositoryStars.setText(format(githubRepository.getStargazersCount()));

        ownerName.setText(githubRepository.getOwner().getLogin());

        Glide.with(context)
                .load(githubRepository.getOwner().getAvatar_url())
                .centerCrop()
                .placeholder(R.drawable.ic_image_placeholder)
                .into(ownerImage);
    }

    // Custom number formatting
    private String format(long value) {
        if (value == Long.MIN_VALUE) return format(Long.MIN_VALUE + 1);
        if (value < 0) return "-" + format(-value);
        if (value < 1000) return Long.toString(value);

        Map.Entry<Long, String> e = suffixes.floorEntry(value);
        Long divideBy = e.getKey();
        String suffix = e.getValue();

        long truncated = value / (divideBy / 10);
        boolean hasDecimal = truncated < 100 && (truncated / 10d) != (truncated / 10);
        return hasDecimal ? (truncated / 10d) + suffix : (truncated / 10) + suffix;
    }
}
