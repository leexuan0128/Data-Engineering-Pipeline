# Model Deployment

In this section, we will deploy our final model using the AWS Sagemaker, lambda functions and API gateway to help users to invoke the prediction system easily.

Compete code is in [IMDB](/section_7/IMDB_v3.ipynb).

The high level steps:  
1. Create endpoints dev env on AWS Segamaker for hosting and deployment the final model.

2. Invoking the prediction system from the web API
 
3. Create Lambda Functions

4. Connect the API Gateaway (Rest API)

5. Invoke API Gateway with Lambda functions