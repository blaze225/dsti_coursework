library(ggplot2)

# Creating the dataset
columns = c('observation','country','% agricultural population','calories per day per person')
observation = seq(1,11)
country = c('Switzerland', 'France', 'Sweden', 'United States', 'Russia', 'China', ' India', 'Brazil', 'Peru', 'Algeria', 'Zaire')
population = c(4,5.7,4.9,3,14.8,69.6,63.8,26.2,38.3,24.7,65.7)
calories = c(3432,3273,3049,3642,3394,2628,2204,2643,2192,2687,2159)
data <- data.frame(observation, country, population, calories)
colnames(data) <- columns

# (a) Make a drawing of those observations
ggplot(data, aes(x=population, y=calories)) + 
  geom_point()+
  geom_label(label=country, size=3, nudge_x=2, hjust='left')+
  xlim(0,100)

# (b) Estimate the parameters of the model: Yi = β0 + β1.xi + εi

model1 = lm(calories ~ population, data = data)
summary(model1)

  # We get an Adjusted R-squared value of 0.6656 which is not good.
  # Looking at the plot we can see that it is not a linear relationship. So, trying with a quadratic term

data['population_sqr'] = data$`% agricultural population`^2
model2 = lm(calories ~ population + population_sqr , data = data)
summary(model2)

  # Now with the quadratic population term we get an Adjusted R-squared value of 0.805 which is a lot better and a lower p-value for the F-statistic 
  # So, parameters of the model:
  # β0 (Intercept) = 3639.8630
  # β1 (Coeff for population) = -51.7009
  # β2 (Coeff for population_sqr) = 0.4814
  # εi (Error/Residual) = -8.76 (median)

# (c) Explain the different outputs of the lm functions used in the R software and precise the tests that are 
# performed and how they are performed

  # Residuals: The error between the prediction of the model and the actual results.
  # Coefficients: For each variable and the intercept, a weight is produced which has attributes like the standard error, a t-test value and significance.
    # Estimate - weight given to the variable
    # Std. Error -  average amount that the coefficient estimates vary from the actual average value of the response variable
    # t value - measure of how many standard deviations our coefficient estimate is far away from 0. The t-value is calculated by taking the coefficient divided by the Std. Error
    # Pr(>|t|) - p-value - probability of observing any value equal or larger than t. A small value means that there is a lower chance that the relationship is due to chance, so it mens a strong relation.
  # Residual Standard Error: standard deviation of the residuals. Its a measure of the quality of a linear regression fit. Smaller is better
  # Multiple R-Squared: amount of variance explained by the model ( Variance explained/Total Variance)
  # Adjusted R-Square: takes into account the number of explanatory variables
  # F-statistic: from the global-fisher test, used to validate if at least one of the coefficients of the model are significatively different from zero.

# (d) Construct a confidence interval at 95% for the regression curve, at a point x0
simulated_data = data.frame(population = 0, population_sqr = 0)
conf_intervals <- predict(model2,newdata= simulated_data, interval = "confidence", level = 0.95)
conf_intervals
  # This gives us the CI for all 11 points


# (e) Draw the points, the regression curve and the curves associated to the confident interval on the same graphic.

simulated_data = data.frame(population = runif(100, 2, max = 75))
simulated_data$population_sqr = simulated_data$population^2
simulated_data = simulated_data[order(simulated_data[,1]),]
# Computes the confidence interval for the expectation of the response variable
pred.clim <- predict(model2, newdata = simulated_data, interval = "confidence", level = 0.95)
# Computes the confidence interval for the fitted values of the response variable
pred.plim <- predict(model2, newdata = simulated_data, interval = "prediction", level = 0.95)
matplot(simulated_data$population, cbind(pred.clim, pred.plim[,-1]), lty = c(1,2,2,3,3),
        lwd=2, type ='l', ylab = 'calories per day per person', xlab = '% agricultural population',
        main = 'Confidence interval')
points(data$population, data$`calories per day per person`)



