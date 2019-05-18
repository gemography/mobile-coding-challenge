package io.psisoft.codechallenge.model;

public class GithubRepository {

    private String name;
    private String description;
    private GithubRepository owner;
    private int score;


    // Constructor
    public GithubRepository(String name, String description, GithubRepository owner, int score) {
        this.name = name;
        this.description = description;
        this.owner = owner;
        this.score = score;
    }

    // Getters and Setters
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public GithubRepository getOwner() {
        return owner;
    }

    public void setOwner(GithubRepository owner) {
        this.owner = owner;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }
}
