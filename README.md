# Welcome to Junhua's Final Project for STAT301-3!

This GitHub Repo is a place to present my final project for Northwestern Univeristy STAT301-3 (Spring 2020).

### Data Source: League of Legends Diamond Ranked Games (10 min) (Kaggle)

This [data](https://www.kaggle.com/bobbyscience/league-of-legends-diamond-ranked-games-10-min) was uploaded on Kaggle for the purpose of training a prediction model in which predict the game outcome of a MOBA (multiplayer online battle arena) game, League of Legends (LoL), by looking at the first 10 min worth of data. To collect this data, I will simply download from the kaggle website where the csv version of the dataset is uploaded. The data contains 1 csv file with 9879 instances of 39 attributes. Fortunately, the data has no missing values. However, if the data is found to be insufficient, I might download and join with more data from the Riot API published by the game company for more informations. The main focus of this final project will be the exploratory data analysis as well as model building and tuning. I will split 10% of the total data as the test set for testing classification results from model building. I will also split 20% of the remaining 90% of training data for conducting an EDA, which include graphics that demonstrated some important relationships between the predictor variables and the response. Another important insight I hope to explore in this project is to determine what are the variables important for predicting a game outcome, and hopefully, we will find this answer with the techniques we will learn this quarter.

### Why this Data

The research question for this project is to predict the outcome (win or loss) given first 10 minutes of game statistics. Additionally if time allows, I will also explore what are the factors important for predicting this outcome, which will be reflective in level of significance in the prediction model. A classification approach will work best given our goal is to predict the response variable `blue_wins`, which is the win (1) or loss (0) of the game at the blue side given the first 10 minutes of the status in game.

### Potential Data Issues

From skimming on the predictors so far, there are defeinitely repeated predictors such as `blue_first_blood` and `red_first_blood` which are mutually exclusive, as well as some highly correlated predictors such as `blue_cs_per_min` and `blue_total_minion_killed`. There are also predictors that are opposite but equal with each other due to the nature of the game being divided in two side, for example, `blue_gold_difference` and `red_gold_difference`. During data cleaning, I will identify these predictors and trim down the dimension of the dataset before model fitting. At short glimpse, all variables are stored as integer types but some should be classified as factor. I will also make this change in data cleaning. 
