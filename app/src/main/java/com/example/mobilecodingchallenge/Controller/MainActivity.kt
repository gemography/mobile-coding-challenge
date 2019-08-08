package com.example.mobilecodingchallenge

import android.icu.text.SimpleDateFormat
import android.icu.util.Calendar
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.Toast
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {

    lateinit var adapter: GitHubRepoRecycleAdapter
    var gitHubRepo: List<Items> = listOf()
    private var isServiceRunning = false
    private var page = 1

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        adapter = GitHubRepoRecycleAdapter(this,gitHubRepo.toMutableList())
        gitHubRepoListView.adapter = adapter
        gitHubRepoListView.layoutManager = LinearLayoutManager(this)
        gitHubRepoListView.setHasFixedSize(true)

        loadData(getQueryString())

        gitHubRepoListView.addOnScrollListener(object: RecyclerView.OnScrollListener() {
            override fun onScrolled(recyclerView: RecyclerView, dx: Int, dy: Int) {
                super.onScrolled(recyclerView, dx, dy)
                val linearLayoutManager = recyclerView
                    .layoutManager as LinearLayoutManager?

                if (!isServiceRunning && linearLayoutManager!!.itemCount <= linearLayoutManager.findLastVisibleItemPosition() + 2) {
                    page = page + 1
                    loadData(getQueryString(page))
                }
            }

        })
    }

    fun loadData(queryString: String) {
        progressBar.visibility = View.VISIBLE
        isServiceRunning = true
        WebService.callService(this,queryString,{response ->
            isServiceRunning = false
            progressBar.visibility = View.INVISIBLE
            if (gitHubRepo.count() == 0) {
                gitHubRepo = response.gitHubRepo
                adapter.setData(response.gitHubRepo)
            } else {
                adapter.addMoreData(response.gitHubRepo)
            }
        },{
            Toast.makeText(this,it,Toast.LENGTH_LONG).show()
            isServiceRunning = false
            progressBar.visibility = View.INVISIBLE
        })
    }

    fun getQueryString(page: Int = 1) : String {
        val date = Calendar.getInstance()
        date.add(Calendar.DATE, -1)

        val formatter = SimpleDateFormat("yyyy-MM-dd")
        val thirtyDaysBeforeTodayInString = formatter.format(date)

        var queryString = "q=created:%3E$thirtyDaysBeforeTodayInString&sort=stars&order=desc"
        if (page > 1) {
            queryString = "$queryString&page=$page"
        }
        return queryString
    }
}
