package io.psisoft.codechallenge.service;

import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class ApiService {

    private static final String BASE_URL = "https://api.github.com/";
    private static ApiService mInstance;
    private Retrofit retrofit;

    private ApiService(){
        retrofit = new Retrofit.Builder()
                .baseUrl(BASE_URL)
                .addConverterFactory(GsonConverterFactory.create())
                .build();
    }

    public static synchronized ApiService getInstance(){
        if(mInstance == null){
            mInstance = new ApiService();
        }
        return mInstance;
    }

    public ApiHelper getApiHelper(){
        return retrofit.create(ApiHelper.class);
    }
}
