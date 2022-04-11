# Model Deployment

In this section, we will deploy our final model using the AWS Sagemaker, lambda functions and API gateway to help users to invoke the prediction system easily.



The high level steps:  

![flow](/section_7/flow.png)
1. Create endpoints dev env on AWS Segamaker for hosting and deployment of the final model.
2. Invoking the prediction system from the web API
3. Create Lambda Functions
4. Connect the API Gateaway (Rest API)
5. Invoke API Gateway with Lambda functions

## Create SagaMaker Deployment Env
- Open AWS SageMaker, create a new notebook instance with ml.t2.medium instance type and proper IAM role permission including AWS S3 and SageMaker Full access.  
- Open new notebook instance, click start jyputer lab, upload related files in this section 7 directory.  
- Choose Conda Python 3 env and the whole modelling code is listed in the [IMDB_v3](/section_7/IMDB_v3.ipynb), which is samilar to the main.R of modelling part in section 6.


## Create Lambda Function
- Open AWS Lambda service, create a new lambda function named imba_xgboost_func with SageMaker full access permission.
- Define the target lambda function:
```python
import boto3

def lambda_handler(event, context):

    body = event['body']
    # The SageMaker runtime is what allows us to invoke the endpoint that we've created.
    runtime = boto3.Session().client('sagemaker-runtime')
    # Now we use the SageMaker runtime to invoke our endpoint, sending the review we were given
    response = runtime.invoke_endpoint(EndpointName = '***ENDPOINT NAME HERE***',# The name of the endpoint we created
                                       ContentType = 'text/csv',                 # The data format that is expected
                                       Body = body
                                       )
    # The response is an HTTP response whose body contains the result of our inference
    result = response['Body'].read().decode('utf-8')
    # Round the result so that our web app only gets '1' or '0' as a response.
    result = float(result)

    return {
        'statusCode' : 200,
        'headers' : { 'Content-Type' : 'text/plain', 'Access-Control-Allow-Origin' : '*' },
        'body' : str(result)
    }
```

## Set up the API Gateway
- Create a new API using API Gateway (REST API) that will trigger the Lambda function we have just created.

- Using AWS Console, navigate to **Amazon API Gateway** and then click on **Get started**. On the next page, make sure that **New API** is selected and give the new api a name, for example, `imba_web_app`. Then, click on **Create API**.

- Now we have created an API, however it doesn't currently do anything. What we want it to do is to trigger the Lambda function that we created earlier. 

- Select the **Actions** dropdown menu and click **Create Method**. A new blank method will be created, select its dropdown menu and select **POST**, then click on the check mark beside it.
For the integration point, make sure that **Lambda Function** is selected and click on the **Use Lambda Proxy integration**. This option makes sure that the data that is sent to the API is then sent directly to the Lambda function with no processing. It also means that the return value must be a proper response object as it will also not be processed by API Gateway.

- Type the name of the Lambda function you created earlier into the **Lambda Function** text entry box and then click on **Save**. Click on **OK** in the pop-up box that then appears, giving permission to API Gateway to invoke the Lambda function you created.

- The last step in creating the API Gateway is to select the **Actions** dropdown and click on **Deploy API**. You will need to create a new Deployment stage and name it anything you like, for example `prod`.

- You have now successfully set up a public API to access your SageMaker model. Make sure to copy or write down the URL provided to invoke your newly created public API as this will be needed in the next step. This URL can be found at the top of the page, highlighted in blue next to the text **Invoke URL**.

    ![post](/section_7/POST.png)

## Deploy the Web App
Open `index.html` on the local computer, the browser will behave as a local web server and we can use the site to interact with the SageMaker model and output the prediction result.

_Note: remember to close the notebook instance and endpoints to avoid the extra charge._