package com.example.mobilecodingchallenge

import android.icu.text.SimpleDateFormat
import android.icu.util.Calendar
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.ArrayAdapter
import android.widget.LinearLayout
import android.widget.Toast
import androidx.recyclerview.widget.LinearLayoutManager
import kotlinx.android.synthetic.main.activity_main.*


class MainActivity : AppCompatActivity() {

    lateinit var adapter: GitHubRepoRecycleAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        WebService.callService(this,getQueryString(),{response ->
            adapter = GitHubRepoRecycleAdapter(this,response.gitHubRepo)
            gitHubRepoListView.adapter = adapter

            val layoutManager = LinearLayoutManager(this)
            gitHubRepoListView.layoutManager = layoutManager
            gitHubRepoListView.setHasFixedSize(true)

        },{
            Toast.makeText(this,it,Toast.LENGTH_LONG).show()
        })

    }

    fun getQueryString(page: Int = 1) : String {
        val date = Calendar.getInstance()
        date.add(Calendar.DATE, -30)

        val formatter = SimpleDateFormat("yyyy-MM-dd")
        val thirtyDaysBeforeTodayInString = formatter.format(date)

        var queryString = "q=created:%3E$thirtyDaysBeforeTodayInString&sort=stars&order=desc"
        if (page > 1) {
            queryString = "$queryString&page=$page"
        }
        return queryString
    }
}
