# Predict game outcome from first 10 minutes of League of Legends plays - STAT301-3 Final Project

This GitHub Repo is a place to present my final project for Northwestern University STAT301-3 (Spring 2020).

### Data Source: [League of Legends Diamond Ranked Games (10 min) (Kaggle)](https://www.kaggle.com/bobbyscience/league-of-legends-diamond-ranked-games-10-min)

This data was published on Kaggle 4 months ago (2020) for the purpose of building a model to predict the game outcome of a MOBA (multiplayer online battle arena) game, League of Legends (LoL), by looking at the first 10 min worth of data. To collect this data, I will simply download from the Kaggle website which contains a csv file with 9879 instances of 39 attributes. The data contains team information such as average player level and gold gained as well as team KDA (Kill/Death/Assist) statistics. Fortunately, the data has no missing values to be handled. However, if the data is found to be insufficient, I might download more available gaming data using the Riot API from the game company for more informations. The target variable for this competition is `blue_wins`, where a value of 1 means the blue team has won and 0 otherwise. Another important insight I hope to explore in this project is to determine which variables important for predicting a game outcome, and hopefully, we will gain insights as we proceed this data exploration process.

I will first approach this dataset by conducting an Exploratory Data Analysis on the team statistics using 20% of the whole dataset provided in `"
high_diamond_ranked_10min.csv"`, which includes about 10k gameplays. Then using the initial analysis, I will begin the data cleaning and wrangling process to address with potential data issues mentioned in the next section below. Finally, after data cleaning, I will proceed to the model building process trying different classification algorithms and compare their performance in predicting our target.

### Why this Data

I am a gamer and I play League of Legends a lot. I have always been interested in exploring whether a game outcome is predictable and what aspect of the game is predictive to the outcome. From there, I can compare and reflect upon my own gaming experience to build these aspects as a player as well as gain insights into game design as a developer in the future. The research question for this project is to predict the outcome (win or loss) given first 10 minutes of game statistics. Additionally if time allows, I will also explore what are the factors important for predicting this outcome, which will be reflective in level of significance in the prediction model.

### Potential Data Issues

From a brief skimming through the datasets, there are some potential cleanings that need to be done on the data:
1. There are repeated predictors such as `blue_first_blood` and `red_first_blood` which are mutually exclusive within every unique observation. There are also similar predictors such as `blue_dragons` and `red_dragons` that are not mutually exclusive and need to be handled differently.
2. There are also predictors that are opposite but equal with each other due to the nature of the game being divided in two side. For example, `blue_gold_difference` and `red_gold_difference` has the same absolute value as the gold difference is calculated by subtracting the gold from its team by the opposite team.
3. There are some highly correlated predictors such as `blue_cs_per_min` and `blue_gold_per_min` when cs (amount of minions killed) is one of the main sources of gold income.
4. Many categorical columns that should be change to factor types instead of character.
5. Reduce number of features by handling predictor issues above and trim down the dimension of the dataset before model fitting.
6. For the purpose of EDA, I will drop the `gameId` column entirely and assume each row represents a unique game/observation.
