# Source: https://www.kaggle.com/bobbyscience/league-of-legends-diamond-ranked-games-10-min/kernels

# Load libraries
library(tidyverse)
library(janitor)
library(naniar)
library(dataMaid)

games <- read_csv("data/unprocessed/high_diamond_ranked_10min.csv")

games %>% 
  filter(blueFirstBlood == 0 & redFirstBlood == 0)

dataset <- read_csv("data/unprocessed/high_diamond_ranked_10min.csv") %>% 
  clean_names() %>%
  mutate(
    first_blood = blue_first_blood,
    dragons = blue_dragons - red_dragons,
    heralds = blue_heralds - red_heralds,
    experience = blue_experience_diff,
    kills = blue_kills - red_kills,
    assists = blue_assists - red_assists,
    towers_destroyed = blue_towers_destroyed - red_towers_destroyed,
    wards_placed = blue_wards_placed - red_wards_placed,
    wards_destroyed = blue_wards_destroyed - red_wards_destroyed,
    cs_per_min = blue_cs_per_min - red_cs_per_min,
    gold_per_min = blue_gold_per_min - red_gold_per_min,
    avg_level = blue_avg_level - red_avg_level,
    elite_monsters = blue_elite_monsters - red_elite_monsters,
    total_jungle_minions_killed = blue_total_jungle_minions_killed - red_total_jungle_minions_killed
  ) %>% 
  select(
    -game_id, -blue_gold_diff, -red_gold_diff, -blue_experience_diff, -red_experience_diff, 
    -red_first_blood, -red_total_gold, -red_total_experience, -red_total_minions_killed, 
    -red_deaths, -red_wards_placed, -red_wards_destroyed, -red_cs_per_min, -red_gold_per_min,
    -red_kills, -red_assists, -red_elite_monsters, -red_avg_level, -red_total_jungle_minions_killed,
    -red_towers_destroyed, -red_dragons, -red_heralds, -blue_towers_destroyed, -blue_dragons, -blue_heralds,
    -blue_total_gold, -blue_total_experience, -blue_cs_per_min, -blue_gold_per_min, -blue_first_blood,
    -blue_total_minions_killed, -blue_deaths, -blue_wards_placed, -blue_wards_destroyed,
    -blue_kills, -blue_assists, -blue_elite_monsters, -blue_avg_level, -blue_total_jungle_minions_killed
  )

# Set seed
RNGversion("3.5")
set.seed(27182)

# set fraction for training, testing, and eda
fractionTrain <- 0.60
fractionTest <- 0.20
fractionEDA <- 0.20

# compute sample size for each
sampleSizeTrain <- floor(fractionTrain * nrow(dataset))
sampleSizeTest <- floor(fractionTest * nrow(dataset))
sampleSizeEDA <- floor(fractionEDA * nrow(dataset))

# create the randomly-sampled indices for each dataframes
# use setdiff() to avoid overlapping subsets of indices
indicesTrain <- sort(sample(seq_len(nrow(dataset)), size=sampleSizeTrain))
indicesNotTrain <- setdiff(seq_len(nrow(dataset)), indicesTrain)
indicesEDA <- sort(sample(indicesNotTrain, size=sampleSizeEDA))
indicesTest <- setdiff(indicesNotTrain, indicesEDA)

# assign indices for train, test, and eda
train <- dataset[indicesTrain, ]
test <- dataset[indicesTest, ]
EDA <- dataset[indicesEDA, ]

# Update dataset to csv
#write_csv(EDA, "data/processed/games_eda.csv")
#write_csv(test, "data/processed/games_test.csv")
#write_csv(train, "data/processed/games_train.csv")

# Update variable description
attr(dataset$blue_wins, "shortDescription") <- "game outcome for blue team (0: lose, 1: win)"
attr(dataset$first_blood, "shortDescription") <- "first blood for blue team (binary)"
attr(dataset$dragons, "shortDescription") <- "difference in the number of dragons slain by the two teams (blue-red)"
attr(dataset$heralds, "shortDescription") <- "difference in the number of heralds slain by the two teams (blue-red)"
attr(dataset$elite_monsters, "shortDescription") <- "difference in the number of elite monsters slain by the two teams (blue-red)"
attr(dataset$experience, "shortDescription") <- "difference in total experience gained by the two teams (blue-red)"
attr(dataset$kills, "shortDescription") <- "difference in the total number of kills by the two teams (blue-red)"
attr(dataset$assists, "shortDescription") <- "difference in the total number of assists by the two teams (blue-red)"
attr(dataset$towers_destroyed, "shortDescription") <- "difference in the number of tower destroyed by the two teams (blue-red)"
attr(dataset$wards_placed, "shortDescription") <- "difference in the total number of wards placed by the two teams (blue-red)"
attr(dataset$wards_destroyed, "shortDescription") <- "difference in the total number of wards destroyed by the two teams (blue-red)"
attr(dataset$cs_per_min, "shortDescription") <- "difference in the average cs per minutes per player of the two teams (blue-red)"
attr(dataset$gold_per_min, "shortDescription") <- "difference in the average gold per minutes per player of the two teams (blue-red)"
attr(dataset$avg_level, "shortDescription") <- "difference in the average player level of the two teams (blue-red)"
attr(dataset$total_jungle_minions_killed, "shortDescription") <- "difference in the total number of jungle minions killed by the two teams (blue-red)"

# Make a codebook containing these variable description (already made)
#makeCodebook(dataset, replace = TRUE)
