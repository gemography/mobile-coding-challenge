package io.psisoft.codechallenge.model;

public class GithubRepositoryOwner {

    private String login;
    private String avatar_url;


    // Constructor
    public GithubRepositoryOwner(String login, String avatar_url) {
        this.login = login;
        this.avatar_url = avatar_url;
    }


    // Getters and Setters
    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getAvatar_url() {
        return avatar_url;
    }

    public void setAvatar_url(String avatar_url) {
        this.avatar_url = avatar_url;
    }
}
