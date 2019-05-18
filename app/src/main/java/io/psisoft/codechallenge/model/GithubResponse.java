package io.psisoft.codechallenge.model;

import java.util.List;

public class GithubResponse {

    private int total_count;
    private boolean incomplete_results;
    private List<GithubResponse> items;


    // Constructor
    public GithubResponse(int total_count, boolean incomplete_results, List<GithubResponse> items) {
        this.total_count = total_count;
        this.incomplete_results = incomplete_results;
        this.items = items;
    }

    // Getters and Setters
    public int getTotal_count() {
        return total_count;
    }

    public void setTotal_count(int total_count) {
        this.total_count = total_count;
    }

    public boolean isIncomplete_results() {
        return incomplete_results;
    }

    public void setIncomplete_results(boolean incomplete_results) {
        this.incomplete_results = incomplete_results;
    }

    public List<GithubResponse> getItems() {
        return items;
    }

    public void setItems(List<GithubResponse> items) {
        this.items = items;
    }

}
