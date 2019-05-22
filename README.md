# Mobile Coding Challenge

## Idea of the App 
The task is to implement a small app that will list the most starred Github repos that were created in the last 30 days. 
You'll be fetching the sorted JSON data directly from the Github API (Github API explained down below). 

## Features
* As a User I should be able to list the most starred Github repos that were created in the last 30 days. 
* As a User I should see the results as a list. One repository per row. 
* As a User I should be able to see for each repo/row the following details :
  * Repository name
  * Repository description 
  * Numbers of stars for the repo. 
  * Username and avatar of the owner. 
* [BONUS] As a User I should be able to keep scrolling and new results should appear (pagination).

## Things to keep in mind 🚨
* Features are less important than code quality. Put more focus on code quality and less on speed and number of features implemented. 
* Your code will be evaluated based on: code structure, programming best practices, legibility (and not number of features implemented or speed). 
* The git commit history (and git commit messages) will be also evaluated.
* Do not forget to include few details about the project in the README (e.g explain choice of libraries, how to run it ...) 

## How to get the data from Github 
To get the most starred Github repos created in the last 30 days (relative to 2017-11-22), you'll need to call the following endpoint : 

`https://api.github.com/search/repositories?q=created:>2017-10-22&sort=stars&order=desc`

The JSON data from Github will be paginated (you'll receive around 100 repos per JSON page). 

To get the 2nd page, you add `&page=2` to the end of your API request : 

`https://api.github.com/search/repositories?q=created:>2017-10-22&sort=stars&order=desc&page=2`

To get the 3rd page, you add `&page=3` ... etc

You can read more about the Github API over [here](https://developer.github.com/v3/search/#search-repositories
).

## Mockups
![alt text](https://raw.githubusercontent.com/hiddenfounders/mobile-coding-challenge/master/mockup.png)

Here's what each element represents : 

![alt text](https://raw.githubusercontent.com/hiddenfounders/mobile-coding-challenge/master/row-explained.png)


## Technologies
For this project, I still stuck to the Android Jetpack libraries:

* Butter Knife --> Viewbinding library for android.
* Retrofit -->  REST client library for android, it makes it easy to retrieve JSON data via API.
* Paging library -->  Facilitates loading data  from network data source on-demand, and also allows the app to work with large data sets.
* ViewModel library --> Stores and manages UI-related data in a lifecycle conscious way.
* Glide --> Used for loading images efficiently.


## How to run project
Follow the indications on the Google Developpers Doc [here](https://developer.android.com/training/basics/firstapp/running-app).

