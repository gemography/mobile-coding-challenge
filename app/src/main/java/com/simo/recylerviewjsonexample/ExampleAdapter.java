package com.simo.recylerviewjsonexample;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.squareup.picasso.Picasso;

import java.util.ArrayList;

import androidx.recyclerview.widget.RecyclerView;

public class ExampleAdapter extends RecyclerView.Adapter<ExampleAdapter.ExampleViewHolder> {
    private Context mContext;
    private ArrayList<ExampleItem> mExampleList;

    public ExampleAdapter(Context context, ArrayList<ExampleItem> exampleList) {
        mContext = context;
        mExampleList = exampleList;
    }

    @Override
    public ExampleViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View v = LayoutInflater.from(mContext).inflate(R.layout.example_item, parent, false);
        return new ExampleViewHolder(v);
    }

    @Override
    public void onBindViewHolder(ExampleViewHolder holder, int position) {
        ExampleItem currentItem = mExampleList.get(position);

        String repoAvatarImg = currentItem.getRepoAvatarImg();
        String repoOwner = currentItem.getRepoOwner();
        String repoName = currentItem.getRepoName();
        String repoDescription = currentItem.getRepoDescription();
        double stars = currentItem.getStars();

        holder.mRepoName.setText(repoName);
        holder.mRepoStars.setText(stars+"k");
        holder.mRepoDescription.setText(repoDescription);
        holder.mRepoOwner.setText(repoOwner);
        // picasso mechanism get Image from the API
        Picasso.get().load(repoAvatarImg).fit().centerInside().into(holder.mRepoAvatarImg);
    }

    @Override
    public int getItemCount() {
        return mExampleList.size();
    }

    public class ExampleViewHolder extends RecyclerView.ViewHolder {
        public ImageView mRepoAvatarImg;
        public TextView mRepoName;
        public TextView mRepoStars;
        public TextView mRepoDescription;
        public TextView mRepoOwner;

        public ExampleViewHolder(View itemView) {
            super(itemView);
            mRepoAvatarImg = itemView.findViewById(R.id.repoAvatarImg);
            mRepoName = itemView.findViewById(R.id.repoName);
            mRepoStars = itemView.findViewById(R.id.stars);
            mRepoDescription = itemView.findViewById(R.id.repoDescription);
            mRepoOwner = itemView.findViewById(R.id.repoOwner);
        }
    }
}