library(ggplot2)
library(tidyverse)
library(rstatix)

# Creating the dataset

observations = rbind(c('morning','A',26),c('afternoon', 'A', 18), c('night','A',31),
                      c('morning','B',13),c('afternoon', 'B', 17), c('night','B',24),
                      c('morning','C',35),c('afternoon', 'C', 31), c('night','C',33),
                      c('morning','D',6),c('afternoon', 'D', 2), c('night','D',4))
columns = c('team', 'workstation', 'defect')
data = data.frame(observations)
colnames(data) <- columns
# Change type of column defect to numeric
data$defect = as.numeric(as.character(data$defect))
summary(data)

# (a) For the moment, we analyse the variables team and work station separately

  # For this we need to use ANOVA test and check that the following assumptions hold true:
  # 1. No significant outliers
  # 2. Normality
  # 3. Homoscedasticity: homogeneity of variance
aov_model_team = aov(defect~team, data=data)
aov_model_ws = aov(defect~workstation, data=data)

# i. Can we say that the performance are not the same with respect to the team?

  # Visualizing the teams using boxplots
boxplot(defect~team, data=data)
  # We can see that there are no outliers.

  # Checking normality per team using the Shapiro-Wilk test
data %>%
  group_by(team) %>%
  shapiro_test(defect)
        # team      variable statistic     p
        # <fct>     <chr>        <dbl> <dbl>
        # 1 afternoon defect       0.957 0.761
        # 2 morning   defect       0.965 0.808
        # 3 night     defect       0.846 0.213
  # Since the p values are > 0.05 for each team, we can assume normality

  # Checking homoscedasticity
bartlett.test(aov_model_team$residuals ~ data$team)
        #         Bartlett test of homogeneity of variances
        # 
        # data:  aov_model_team$residuals by data$team
        # Bartlett's K-squared = 0.035381, df = 2, p-value = 0.9825
  # Since the p-value>0.05 we can assume homoscedasticity

  # Now, going back to the result of ANOVA for team
summary(aov_model_team)
        #             Df Sum Sq Mean Sq F value Pr(>F)
        # team         2     72    36.0   0.223  0.805
        # Residuals    9   1454   161.6   
  # Since p-value>0.05 we can conclude that there is no significant variation among different teams

# ii. Can we say that the difficulties associated to each work station are not the same?

  # Visualizing the workstations using boxplots
boxplot(defect~workstation, data=data)
  # We can see that there are no outliers.

  # Checking normality per workstation using the Shapiro-Wilk test
data %>%
  group_by(workstation) %>%
  shapiro_test(defect)
        # workstation variable statistic     p
        # <fct>       <chr>        <dbl> <dbl>
        # 1 A           defect       0.983 0.747
        # 2 B           defect       0.976 0.702
        # 3 C           defect       1     1.00 
        # 4 D           defect       1     1.00 
  # Since the p values are > 0.05 for each workstation, we can assume normality

  # Checking homoscedasticity
bartlett.test(aov_model_ws$residuals ~ data$workstation)
        #       Bartlett test of homogeneity of variances
        # 
        # data:  aov_model_team$residuals by data$workstation
        # Bartlett's K-squared = 3.4989, df = 3, p-value = 0.3209
  # Since the p-value>0.05 we can assume homoscedasticity
  # Now, going back to the result of ANOVA for team
summary(aov_model_ws)
        #             Df Sum Sq Mean Sq F value   Pr(>F)    
        # workstation  3   1362   454.0   22.15 0.000314 ***
        # Residuals    8    164    20.5 
# Since p-value<0.05 we can conclude that there is a significant variation among different workstations!

# (b) Now we take into account both variables in the same time. 
# At first we consider the additive model Yi,j = μ + ai + bj + εi,j where the are i.i.d. random variables whose distribution 
# is N(0,σ2)
# i. How to validate the use of the additive model?

# The additive model
model = lm(defect ~ workstation + team, data=data)
summary(model)

        #   Residuals:
        #   Min     1Q Median     3Q    Max 
        #   -5     -3      1      2      3 
        # 
        #   Coefficients:
        #   Estimate Std. Error t value Pr(>|t|)    
        #   (Intercept)    22.000      2.769   7.945 0.000211 ***
        #   workstationB   -7.000      3.197  -2.189 0.071133 .  
        #   workstationC    8.000      3.197   2.502 0.046392 *  
        #   workstationD  -21.000      3.197  -6.568 0.000597 ***
        #   teammorning     3.000      2.769   1.083 0.320206    
        #   teamnight       6.000      2.769   2.167 0.073370 .  
        #   ---
        #   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
        # 
        #   Residual standard error: 3.916 on 6 degrees of freedom
        #   Multiple R-squared:  0.9397,	Adjusted R-squared:  0.8895 
        #   F-statistic:  18.7 on 5 and 6 DF,  p-value: 0.001342

  # The Adjusted R-squared value:0.8895 is high meaning that the model fits the data well.
  
# ii. We accept the additive model. How to estimate E[Yi,j] in this model?
data %>%
  mutate(Expectation = case_when(workstation %in% c('A','B') ~ 22,
                                workstation =='C' ~ 22 + 8,
                                workstation =='D' ~ 22 - 21))

        # team workstation defect Expectation
        # 1    morning           A     26          22
        # 2  afternoon           A     18          22
        # 3      night           A     31          22
        # 4    morning           B     13          22
        # 5  afternoon           B     17          22
        # 6      night           B     24          22
        # 7    morning           C     35          30
        # 8  afternoon           C     31          30
        # 9      night           C     33          30
        # 10   morning           D      6           1
        # 11 afternoon           D      2           1
        # 12     night           D      4           1


# iii. Is the variable team influent?
summary(model)
anova(model)
        # Analysis of Variance Table
        # 
        # Response: defect
        # Df Sum Sq Mean Sq F value    Pr(>F)    
        # workstation  3   1362  454.00 29.6087 0.0005408 ***
        # team         2     72   36.00  2.3478 0.1765355    
        # Residuals    6     92   15.33                      

  # The variable team is not influent because we get p-values>0.05 in the additive model
  # and even in ANOVA 

# iv. Is the variable work station influent?
summary(model)
anova(model)
  # Yes workstation is influent as p-value <0.05 for workstation C and D
  # And also p-value<0.05 in ANOVA 