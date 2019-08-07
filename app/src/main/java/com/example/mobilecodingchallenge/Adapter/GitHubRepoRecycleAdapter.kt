package com.example.mobilecodingchallenge

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide

class GitHubRepoRecycleAdapter(val context: Context, val gitHubRepo: List<Items>) : RecyclerView.Adapter<GitHubRepoRecycleAdapter.Holder>() {

    override fun onBindViewHolder(holder: Holder, position: Int) {
        holder.bindItems(gitHubRepo[position],context)
    }

    override fun getItemCount(): Int {
        return gitHubRepo.count()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): Holder {
        val view = LayoutInflater.from(parent.context).inflate(R.layout.githubrepo_list_item, parent, false)
        return Holder(view)
    }

    inner class Holder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        val repoName = itemView.findViewById<TextView>(R.id.repoName)
        val repoDescription = itemView.findViewById<TextView>(R.id.repoDescription)
        val avatarImage = itemView.findViewById<ImageView>(R.id.avatarImage)
        val ownerName = itemView.findViewById<TextView>(R.id.ownerName)
        val starCount = itemView.findViewById<TextView>(R.id.starCounter)

        fun bindItems(gitHubItem: Items, context: Context) {
            repoName.text = gitHubItem.repoName
            repoDescription.text = gitHubItem.repoDescription

            Glide.with(context).load(gitHubItem.repoOwner?.avatar).into(avatarImage)
            ownerName.text = gitHubItem.repoOwner?.login
            starCount.text = gitHubItem.repoStars?.toDouble()?.let { formatPoints(it) }
        }
    }

    fun formatPoints(number: Double) : String {
        var numberString = ""
        if (Math.abs(number / 1000000) > 1) {
            numberString = (number / 1000000).toString() + "m"

        } else if (Math.abs(number / 1000) > 1) {
            numberString = (number / 1000).toString() + "k"

        } else {
            numberString = number.toString()
        }
        return numberString
    }

}