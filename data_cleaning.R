# Source: https://www.kaggle.com/bobbyscience/league-of-legends-diamond-ranked-games-10-min/kernels

# Load libraries
library(tidyverse)
library(janitor)
library(naniar)
library(dataMaid)

games <- read_csv(
  "data/unprocessed/high_diamond_ranked_10min.csv") %>% 
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

# Check missing values (if any)
missing_values <- games %>% 
  miss_var_summary() %>% 
  filter(n_miss > 0) # NONE

# Split data
games_analysis <- games %>% 
  sample_frac(0.90)

games_test <- games %>% 
  setdiff(games_analysis)

games_eda <- games_analysis %>% 
  sample_frac(0.20)

games_train <- games_analysis %>% 
  setdiff(games_eda)

write_csv(games_eda, "data/processed/games_eda.csv")
write_csv(games_test, "data/processed/games_test.csv")
write_csv(games_train, "data/processed/games_train.csv")