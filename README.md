# STAT628-Mod2


Preprocess Data Upload: Oct-17-2021 (Bruce Zheng)
1. ID:182 Bodyfat 0 to 7.3
2. ID:42 Height 29.5 to 69.5
3. Create a WEIGHT_KG variable, WEIGHT_KG = 0.453592 * WEIGHT  # 1 pound = 0.453592 kg
4. Create a HEIGHT_M variable, HEIGHT_M = 0.0254 * HEIGHT  # 1 inch  =  0.0254 m


Building Models Uploaded: Oct-18-2021 (Suhui Liu)
1. Build the full model, Stepwise with linear regression using R, return the estimated coefficients, stds, t-statistics, p-values, adjusted R-squared and RMSE.
2. Build the Split in age groups model using R, return the estimated coefficients, stds, t-statistics, p-values, adjusted R-squared and RMSE.

Building Models Uploaded: Oct-18-2021 (Yixuan Wang)
1. Build the full model with linear regression, return the estimated coefficients, stds, t-statistics, p-values, adjusted R-squared and RMSE.
2. Using 3-fold and cross-validation to find the curve of lambda and training and test score.
3. Build two Lasso regression models, return the estimated coefficients, stds, t-statistics, p-values, adjusted R-squared and RMSE.

Diagnostics Uploaded: Oct-18-2021 (Haishuo Chen)
1. model diagnostics on linear model assumptions and high leverage points.
2. Drop two high leverage points and improve the performance of our model.
3. Validate performance on test data.

Code Clean: Oct-18-2021 (Haishuo Chen)
1. two files: Diagnostics, full model and lasso

How to use the code:
1. Using preprocess.ipynb in python to cleaning the data, replace the outliers, change the measurement from inch/lbs to m/kg.
2. Using model(full+step+split_age).R in R to build the full model, stepwise regression model and split in age model, and get their coefficient estimation, adjusted R square and RMSE.
3. Using Module2(Full Model+Lasso Regression).ipynb in python to build the full model and lasso regression with lambda=0.2 and 1, and get their coefficient estimation, confidence intervals, adjusted R square and RMSE.
4. Using Diagnostics.ipynb in python to test the linear regression assumptions, find the outliers and high leverage points, and do the overfitting and performance test.
5. Using shiny_app.R in R to build our shiny app.
6. All plots are from model(full+step+split_age).R and Diagnostics.ipynb, all tables are summarized by our group which is the screenshot from our presentation slides.
