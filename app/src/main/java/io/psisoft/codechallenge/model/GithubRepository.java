package io.psisoft.codechallenge.model;

import java.util.Objects;

public class GithubRepository {

    private int id;
    private String name;
    private String description;
    private GithubRepositoryOwner owner;
    private int score;


    // Constructor
    public GithubRepository(int id, String name, String description, GithubRepositoryOwner owner, int score) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.owner = owner;
        this.score = score;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

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

    public GithubRepositoryOwner getOwner() {
        return owner;
    }

    public void setOwner(GithubRepositoryOwner owner) {
        this.owner = owner;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }


    // Methods
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        GithubRepository that = (GithubRepository) o;
        return id == that.id;
    }

}
