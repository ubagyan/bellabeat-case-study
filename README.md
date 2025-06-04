
# Bellabeat Case Study: Google Data Analytics Capstone

## 📄 Summary
This project is part of the Google Data Analytics Professional Certificate capstone performed by Han San. A real-world case study using Fitbit data to generate insights for **Bellabeat**, a high-tech wellness company that manufactures health-focused smart products for women.

The goal is to uncover smart device usage trends and provide actionable marketing recommendations to support Bellabeat's growth strategy.

---

## 📊 Business Task
**Objective:** Identify smart device usage trends to inform Bellabeat’s marketing strategies, especially for their Leaf product.

### Key Questions:
1. What are the usage trends in smart fitness devices?
2. How can these trends relate to Bellabeat's customers?
3. What strategic marketing recommendations emerge?

---

## 📁 Data Sources
The data used was sourced from [Fitbit Dataset on Kaggle](https://www.kaggle.com/arashnic/fitbit), and includes:
- Daily activity data
- Sleep data
- Heart rate (second-by-second)
- Weight log

---

## 🧼 Data Cleaning & Tools
Data was processed using:
- **R** (tidyverse, dplyr, ggplot2)
- **SQL** (SQLite for querying large heart rate data)

---

## 📈 Key Visualizations


### 1. Steps vs Sedentary Minutes (Scatter Plot)
A negative correlation shows users who take more steps tend to have fewer sedentary minutes.

![Steps vs Sedentary Minutes](Steps%20Vs%20Sedentary%20Minutes_Colored.png)

```r
ggplot(daily_activity, aes(x = TotalSteps, y = SedentaryMinutes, color = as.factor(Id))) +
  geom_point(alpha = 0.6, size = 2) +
  labs(title = "Steps vs Sedentary Minutes", x = "Total Steps", y = "Sedentary Minutes", color = "User ID") +
  theme_minimal() +
  theme(legend.position = "none")
```

---

### 2. Average Metrics per User (Bar Chart)
A grouped bar chart comparing **Average Steps**, **Sedentary Time**, and **Sleep** across users.

![Comparison of Average Metrics](Comparison%20of%20Average%20Steps%2C%20Sedentary%20Time%20and%20Sleep%20per%20user.png)

```r
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

ggplot(user_summary_long, aes(x = UserLabel, y = Value, fill = Metric)) +
  geom_col(position = "dodge", width = 0.75) +
  scale_fill_manual(values = c("avg_steps" = "#1f77b4", "avg_sedentary" = "#2ca02c", "avg_sleep" = "#d62728")) +
  labs(title = "Comparison of Average Steps, Sedentary Time, and Sleep per User",
       x = "User", y = "Average Daily Value", fill = "Metric") +
  theme_minimal()
```

---

### 3. Sleep Duration (Pie Chart)
The pie chart shows the proportion of days where users slept less than 7 hours.

![Sleep Duration Pie Chart](Proportion%20of%20Days%20with%20_7%20hours%20of%20sleep.png)

```r
sleep_day %>%
  mutate(SleepCategory = ifelse(TotalMinutesAsleep < 420, "< 7 hrs", "≥ 7 hrs")) %>%
  count(SleepCategory) %>%
  ggplot(aes(x = "", y = n, fill = SleepCategory)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y") +
  scale_fill_manual(values = c("< 7 hrs" = "#ff7f0e", "≥ 7 hrs" = "#1f77b4")) +
  labs(title = "Proportion of Days with Less than 7 Hours of Sleep", fill = "Sleep Duration") +
  theme_void()
```

---

## 💡 Key Insights
- Active users have significantly lower sedentary minutes.
- Many users average <7 hours of sleep — an opportunity for sleep-focused wellness tools.
- Heart rate trends reveal that most users spend time in the moderate activity zone.

---

## ✅ Recommendations
- Promote Leaf and Time as behavior motivators for movement.
- Use sleep tracking to deliver personalized nighttime health suggestions.
- Offer wellness bundles that integrate hydration, sleep, and stress tracking.

---

## 📁 Files in this Repository
- `Bellabeat_Final_Report_ubagyan.docx` – Full case study report
- `bellabeat_analysis.R` – R script for data cleaning and visualization
- `heart_rate_summary.sql` – SQL queries for heart rate interpretation
- `Steps Vs Sedentary Minutes_Colored.png`, `Proportion of Days with _7 hours of sleep.png`, etc. – Key visualizations

---

## 📬 Contact
- 🌐 [LinkedIn](https://www.linkedin.com/in/han-htet-s-185a9b2ab/)

---

*This project was completed as part of the Google Data Analytics Capstone Project. All personal data in the Fitbit dataset was anonymized.*
