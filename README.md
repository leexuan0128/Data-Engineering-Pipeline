# AWS Data Pipeline for an Online Grocery Shopping Website

### Target
Build a data pipeline for an online order processing system based on a series of services of AWS.

### Data Source

[3 Million Instacart Orders](https://tech.instacart.com/3-million-instacart-orders-open-sourced-d40d29ead6f2)

### Services Used
- AWS S3
- AWS Glue Crawler
- AWS Glue Databrew
- AWS Glue Job ETL
- AWS Athena

### Archtiecture
High level architecture of data pipeline
![ETL](images/dats_pipeline.jpeg)

### Steps
1. **Build the Data Lake**
    
    After we have the cvs source data, we need to build a data lake and load the input into it. We can use the HDFS, NoSQL or Object Store. Here, we use the AWS S3 to store the raw data. AWS S3 is an object storage which has a good compatibility with other Big Data AWS services. AWS Glue is a serverless AWS service for data acquistion and ETL. Here, we run AWS Glue Crawler to automatically discovery table definitions and schemas from the data source.
    ![Glue](images/Glue.png)


2. **Query the data through Athena**

    After the data is cataloged by Glue Crawler, we can use Athena to execuate the SQL statements to query the specific data. The transformed data will be stored into a new S3 bucket for the next processing. The files are also partitioned and converted into Parquet format to optimize performance and cost.

3. **ELT in Glue Databrew**


4. **Dev Endpoints**

5. **ETL in Glue Job**