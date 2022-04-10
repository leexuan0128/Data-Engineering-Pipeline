# Build the Machine Learning Model

In the daily industry environment, Data Scientist is normally responsible for Modelling. In this step, we will try to build a Machine Learning Model to predict the _users' next purchase probability_ using the previous data features we queried from the [section 2](/section_2/) and [section 3](/section_3/).

Details:
- IDE: RStudio
- Based-Model: Tree-Based Method, [XGBoost](https://xgboost.readthedocs.io/en/stable/parameter.html)
- Data Source: order.products.train, order.products.test
- Hyper-Parameters: see Main.R


Modelling:  
1. Load project
2. Append user_id to order.products.train
3. Feature engineering part
4. Build train and test data
5. Split train data into train and validation
6. Modelling (find a best parameters set)
7. Predict


ROC Curve: 0.843
![roc](/section_6/ROC.png)

Compete modelling code is put inyo [main.R](/section_6/main.R)