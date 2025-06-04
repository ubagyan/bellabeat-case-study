
# Bellabeat Case Study - Fitbit Data Analysis
# Author: Han Htet San
# Date: 2025-06-04

# Load required libraries
install.packages("tidyverse")
library(tidyverse)

# Load data
daily_activity <- read.csv("dailyActivity_merged.csv")
sleep_day <- read.csv("sleepDay_merged.csv")

# Merge data
combined_data <- merge(sleep_day, daily_activity, by = "Id")

# Summarize user metrics
user_summary <- combined_data %>%
  group_by(Id) %>%
  summarise(
    avg_steps = mean(TotalSteps, na.rm = TRUE),
    avg_sedentary = mean(SedentaryMinutes, na.rm = TRUE),
    avg_sleep = mean(TotalMinutesAsleep, na.rm = TRUE)
  ) %>%
  mutate(UserLabel = paste("User", row_number()))

user_summary_long <- user_summary %>%
  pivot_longer(cols = c(avg_steps, avg_sedentary, avg_sleep), names_to = "Metric", values_to = "Value")

# Plot 1: Steps vs Sedentary Minutes
ggplot(daily_activity, aes(x = TotalSteps, y = SedentaryMinutes, color = as.factor(Id))) + 
  geom_point(alpha = 0.6, size = 2) +
  labs(title = "Steps vs Sedentary Minutes", x = "Total Steps", y = "Sedentary Minutes", color = "User ID") +
  theme_minimal() +
  theme(legend.position = "none") 

# Plot 2: Comparison per user
ggplot(user_summary_long, aes(x = UserLabel, y = Value, fill = Metric)) +
  geom_col(position = "dodge", width = 0.75) +
  scale_fill_manual(values = c("avg_steps" = "#1f77b4", "avg_sedentary" = "#2ca02c", "avg_sleep" = "#d62728")) +
  labs(
    title = "Comparison of Average Steps, Sedentary Time, and Sleep per User",
    x = "User",
    y = "Average Daily Value",
    fill = "Metric"
  ) +
  theme_minimal()

# Plot 3: Pie chart of < 7 hours sleep
sleep_day %>%
  mutate(SleepCategory = ifelse(TotalMinutesAsleep < 420, "< 7 hrs", "≥ 7 hrs")) %>%
  count(SleepCategory) %>%
  ggplot(aes(x = "", y = n, fill = SleepCategory)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y") +
  scale_fill_manual(values = c("< 7 hrs" = "#ff7f0e", "≥ 7 hrs" = "#1f77b4")) +
  labs(title = "Proportion of Days with Less than 7 Hours of Sleep", fill = "Sleep Duration") +
  theme_void()
