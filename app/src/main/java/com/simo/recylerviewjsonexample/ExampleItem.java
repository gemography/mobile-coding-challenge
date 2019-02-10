package com.simo.recylerviewjsonexample;

public class ExampleItem {
    private String mRepoAvatarImg;
    private String mRepoOwner;
    private double mStars;
    private  String mRepoDescription;
    private  String mRepoName;


    public ExampleItem(String repoAvatarImg, String repoOwner, double stars,String repoDescription,String repoName) {
        mRepoAvatarImg = repoAvatarImg;
        mRepoOwner = repoOwner;
        mStars =stars;
        mRepoDescription = repoDescription;
        mRepoName = repoName;
    }

    public String getRepoAvatarImg() {
        return mRepoAvatarImg;
    }

    public String getRepoDescription() {
        return mRepoDescription;
    }

    public String getRepoOwner() {
        return mRepoOwner;
    }

    public double getStars() {
        return mStars;
    }
    public String getRepoName() { return  mRepoName; }
}
