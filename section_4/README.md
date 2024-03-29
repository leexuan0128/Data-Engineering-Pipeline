# Glue Job With PySpark Env  

## The general steps are as follows

1. Create the AWS Glue Job with our Spark Script.

2. Read the source data (parquet) from the AWS S3.

3. Join the target table and converted.

4. Write the new table back into a new AWS S3 bucket.

## Glue Job Creation  
- Env: Spark 3.1 + Python 3 + Glue Version 3.0
- ETL Lanuage: Python
- IAM Role: Glue Job and S3 Full Access
- Type: Spark Env
- Editor: Spark script editor
- This job runs on a notebook instance of Dev Endpoints in Glue using an existing script in the S3

## Job Result  
The job outputs a 1.2GB object file into a new S3 bucket.  

![result](/section_3/img/output4.png)