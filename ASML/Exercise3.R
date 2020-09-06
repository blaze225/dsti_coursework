library(ggplot2)
library(rpart)
library(randomForest)
library(VSURF)

# Importing test2.Rdata into the environment
summary(data2)

# (a) Perform the multiple regression model and analyse all the outputs that are available

model <- lm(Y~X1+X2+X3+X4+X5+X6+X7+X8+X9,data=data2)
summary(model)

        # Residuals:
        #   Min      1Q  Median      3Q     Max 
        # -3.2756 -0.8626 -0.0438  0.8902  4.3626 
        # 
        # Coefficients:
        #   Estimate Std. Error t value Pr(>|t|)    
        # (Intercept)  4.49487    0.50850   8.840  < 2e-16 ***
        #   X1          -1.32311    0.10317 -12.824  < 2e-16 ***
        #   X2          -0.03532    0.11071  -0.319   0.7498    
        #   X3           0.26148    0.24549   1.065   0.2873    
        #   X4          -0.20474    0.01091 -18.770  < 2e-16 ***
        #   X5           0.07352    0.03005   2.447   0.0148 *  
        #   X6          -0.02360    0.04098  -0.576   0.5650    
        #   X7           0.72070    0.12643   5.700 2.07e-08 ***
        #   X8          -0.04999    0.11979  -0.417   0.6766    
        #   X9           0.10592    0.12223   0.867   0.3866    
        # ---
        #   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
        # 
        # Residual standard error: 1.331 on 490 degrees of freedom
        # Multiple R-squared:  0.5334,	Adjusted R-squared:  0.5248 
        # F-statistic: 62.24 on 9 and 490 DF,  p-value: < 2.2e-16

  # The Adjusted R-squared:0.5248 is very less meaning that this model does not fit the data well.
  # The important variables for the model are X1,X4,X5 and X7.

# (b) Is this model interesting?
  # The low Adjusted R-squared value confirms that this is a poor model, so not interesting at all.

# (c) Perform a non-linear model and analyse it.
  # Using CART
tree = rpart(data2$Y~.,data=data2[2:10], control=rpart.control(cp=10^-9,minsplit=2))
summary(tree)
      # Variable importance
      # X4 X1 X7 X3 X8 X2 X6 X9 
      # 59 31  4  1  1  1  1  1 
printcp(tree)
      # Regression tree:
      #   rpart(formula = data2$Y ~ ., data = data2[2:10], control = rpart.control(cp = 10^-9, 
      #                                                                            minsplit = 2))
      # 
      # Variables actually used in tree construction:
      #   [1] X1 X2 X3 X4 X5 X6 X7 X8 X9
      # 
      # Root node error: 1860.5/500 = 3.7211

  # Using Random Forest
rf.reg = randomForest(data2$Y~.,data=data2[2:10],ntree=500, importance=TRUE)
      # Call:
      #   randomForest(formula = data2$Y ~ ., data = data2[2:10], ntree = 500,      importance = TRUE) 
      # Type of random forest: regression
      # Number of trees: 500
      # No. of variables tried at each split: 3
      # 
      # Mean of squared residuals: 0.08959967
      # % Var explained: 97.59
  # We can see that this model better captures the data with almost 98% variance

# (d) What are the variables that are really conneted to the response variable?

  # Checking variable importance from the CART output we can see that X4, X1, X7 are more important than others
  # From the Random Forest output
rf.reg$importance
      # %IncMSE IncNodePurity
      # X1  2.170904194     574.62446
      # X2  0.005790316      30.94955
      # X3  0.003841615      28.91975
      # X4  3.869036589     984.27549
      # X5  0.007128899      30.34113
      # X6 -0.005674547      22.09077
      # X7  0.300733891     118.14688
      # X8 -0.007042038      24.59479
      # X9  0.002578216      23.53232
  # The most important are again X4,X1 and X7

vozone = VSURF(data2$Y~.,data=data2[2:10])
vozone$varselect.interp
vozone$varselect.pred
      # We get: 4 1 7 which again confirms that X4,X1 and X7 are the most important