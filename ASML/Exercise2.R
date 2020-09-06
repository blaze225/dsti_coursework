library(ggplot2)

# Importing test1.Rdata into the environment
summary(data)

# (a) Perform the multiple regression model and analyse all the outputs that are available

model <- lm(Y~X1+X2+X3+X4+X5+X6+X7+X8+X9,data=data)
summary(model)
      # Residuals:
      #   Min        1Q    Median        3Q       Max 
      # -0.298157 -0.063828  0.000327  0.064227  0.287811 
      # 
      # Coefficients:
      #   Estimate Std. Error   t value Pr(>|t|)    
      # (Intercept)  2.0261760  0.0377967    53.607   <2e-16 ***
      #   X1           3.0023823  0.0076688   391.509   <2e-16 ***
      #   X2          -0.0027336  0.0082289    -0.332   0.7399    
      # X3          -0.0205566  0.0182475    -1.127   0.2605    
      # X4          -3.0004636  0.0008108 -3700.703   <2e-16 ***
      #   X5          -0.0022834  0.0022333    -1.022   0.3071    
      # X6          -0.0063286  0.0030461    -2.078   0.0383 *  
      #   X7          -1.0158935  0.0093976  -108.101   <2e-16 ***
      #   X8          -0.0024736  0.0089039    -0.278   0.7813    
      # X9          -0.0041122  0.0090857    -0.453   0.6510    
      # ---
      #   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
      # 
      # Residual standard error: 0.09893 on 490 degrees of freedom
      # Multiple R-squared:      1,	Adjusted R-squared:      1 
      # F-statistic: 1.567e+06 on 9 and 490 DF,  p-value: < 2.2e-16
  # Observations:
  # We can notice that the Adjusted R-squared value is 1 which means that the model perfectly fits the data.
  # The same is confirmed by the low value of Residual standard error: 0.09893
  # The most important variables that are needed for the model are  X1,X4,X6,X7 and the Intercept as indicated by the low p-values.

# (b) What are the variables that are really connected to the response variable?

  # Using the 'Backward' iterative method using Akaike information criterion (AIC) to compare performance and select best variables
  
model_back = step(model, direction='backward')
model_back
  # The lowest AIC=-2310.67 with Y ~ X1 + X4 + X6 + X7

summary(model_back)
  # Gives us same performance (Adjusted R-squared:1) with these variables
      # Residuals:
      #   Min        1Q    Median        3Q       Max 
      # -0.285588 -0.066303  0.000747  0.065736  0.287570 
      # 
      # Coefficients:
      #   Estimate Std. Error   t value Pr(>|t|)    
      # (Intercept)  2.0310926  0.0295953    68.629   <2e-16 ***
      #   X1           3.0022119  0.0076034   394.852   <2e-16 ***
      #   X4          -3.0003658  0.0008033 -3735.142   <2e-16 ***
      #   X6          -0.0062016  0.0030189    -2.054   0.0405 *  
      #   X7          -1.0157352  0.0093561  -108.564   <2e-16 ***
      #   ---
      #   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
      # 
      # Residual standard error: 0.0987 on 495 degrees of freedom
      # Multiple R-squared:      1,	Adjusted R-squared:      1 
      # F-statistic: 3.542e+06 on 4 and 495 DF,  p-value: < 2.2e-16