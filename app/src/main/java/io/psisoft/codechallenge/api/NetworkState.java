package io.psisoft.codechallenge.api;

public class NetworkState {

    private final Status status;
    private final String msg;

    public static final NetworkState INITIALIZED;
    public static final NetworkState NOT_INITIALIZED;
    public static final NetworkState LOADING;
    public static final NetworkState LOADED;
    public static final NetworkState FAILED;

    NetworkState(Status status, String msg) {
        this.status = status;
        this.msg = msg;
    }

    static {
        INITIALIZED = new NetworkState(Status.INITIALIZED, "Initialized");
        NOT_INITIALIZED = new NetworkState(Status.NOT_INITIALIZED, "Not initialized properly");
        LOADED = new NetworkState(Status.SUCCESS, "Success");
        LOADING = new NetworkState(Status.RUNNING, "Running");
        FAILED = new NetworkState(Status.FAILED, "Problem was accrued");
    }

    public Status getStatus() {
        return status;
    }

    public String getMsg() {
        return msg;
    }
}
