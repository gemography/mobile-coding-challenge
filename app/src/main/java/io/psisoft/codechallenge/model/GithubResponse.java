package io.psisoft.codechallenge.model;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

import java.util.List;

public class GithubResponse {

    @SerializedName("total_count")
    @Expose
    private int totalCount;

    @SerializedName("incomplete_results")
    @Expose
    private boolean incompleteResults;

    private List<GithubRepository> items;


    // Constructor
    public GithubResponse(int totalCount, boolean incompleteResults, List<GithubRepository> items) {
        this.totalCount = totalCount;
        this.incompleteResults = incompleteResults;
        this.items = items;
    }

    // Getters and Setters
    public int getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
    }

    public boolean isIncompleteResults() {
        return incompleteResults;
    }

    public void setIncompleteResults(boolean incompleteResults) {
        this.incompleteResults = incompleteResults;
    }

    public List<GithubRepository> getItems() {
        return items;
    }

    public void setItems(List<GithubRepository> items) {
        this.items = items;
    }
}
