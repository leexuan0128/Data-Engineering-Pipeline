# Automated ETL Job Pipeline

Use Cases:
1. Create a lambda function to define and trigger the glue job automatically.
2. Create a lambda function to trigger a job run for one Databrew project.
3. Schedule the lambda functions in the AWS CloudWatch, run daily.

## Schedule-Based Architecture  
![5_1](/section_5/img/Automated%20ETL%20Pipeline%20(Schedule%20Based).jpeg)  

- Create target lambda functions for Glue Job and DataBrew  
**Lambda functions for Glue Job**:  
    - Name: glue-job-etl-daily  
    - Runtime: python 3.8  
    - IAM Role: Full access to Glue
    ```python
    import boto3

    glue= boto3.client('glue')

    def lambda_handler(event, context):    
    response = glue.start_job_run(JobName='gluejob3.0')
    ```

    **Lambda functions for Glue Job**:  
    - Name: databrew-etl-daily  
    - Runtime: python 3.8  
    - IAM Role: Full access to Databrew
    ```python
    import boto3

    databrew= boto3.client('databrew')

    def lambda_handler(event, context):    
        response = databrew.start_job_run(Name='user-features-2')
    ```
- Create the EventBrige  
**Trigger for Glue Job**:
    - Name: glue-job-etl-daily  
    - Rule type: schedule  
    - Pattern: rate expression (fixed rate of day)  
    - Target: lambda functon (glue-job-etl-daily)  
      
    **Trigger for Databrew Daily**:
    - Name: databrew-etl-daily
    - Rule type: schedule
    - Pattern: rate expression (fixed rate of day)
    - Target: lambda functon (databrew-etl-daily)