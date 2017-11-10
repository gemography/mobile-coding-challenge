# Mobile Coding Challenge

## Idea of the App 
The task is to implement a small app that will list the most starred Github repos that were created in the last 30 days. The data (including the sorting) will be provided by Github API. 

## Expected Behavior of the App

* Each row should include the repo name, description and number of stars.
* The results should be paginated. 

## Technologies to use 
Choose whatever mobile platform you're most familiar with. 

For iOS, you can use either use Swift or Objective-C. 

For Android, you can either use Kotlin or Java. 

## How to get the data from Github API 
To get the most starred Github repos created in the last 30 days, you should call the following URL :

`https://api.github.com/search/repositories?q=created:>2017-10-01&sort=stars&order=desc`

Keep in mind that the Github API won't be returning all the 28,886 available repos at once (because it's a bad practice), instead the results will be paginated and you will be receiving around 100 repos per page.  

To get the second page for example, you should call the following URL :    

`https://api.github.com/search/repositories?q=created:>2017-10-01&sort=stars&order=desc&page=2`

You can read more about the Github API over [here](https://developer.github.com/v3/search/#search-repositories
).

## How we'll evaluate
* Your code will be evaluated based on: code structure, programming best practices, legibility. 
* The git commit history will be also evaluated.
* Do not forget documentation. Or how are we going to evaluate your work if we can't init the project on our machines? 
* Put more focus on code quality and less on speed. Don't hack something quickly, take your time and craft something clean. 

## Once you're done with the app 
* Put the code of your project on Github and send the repo to **zakaria[at]hiddenfounders.com**

## Questions?
If you have any questions or feedback, don't hesitate to contact us via **zakaria[at]hiddenfounders.com**

