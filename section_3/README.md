# AWS Glue DataBrew
The high level of processing shows as follow:  

![db4](/section_3/img/output.png)

What is the Glue DataBrew?  
> AWS Glue DataBrew is a visual data preparation tool that enables users to clean and normalise data without writing any code, to reduce the time it takes to prepare data for analytics and machine learning (ML) by up to 80% compared to today’s conventional, code-based data preparation. We can choose from over 250 pre-built transformations to automate data preparation tasks, such as filtering anomalies, converting data to standard formats, and correcting invalid values, all without the need to write code.  

![db1](/section_3/img/databrew-1.png)

> A project in DataBrew stores all the information necessary for you to visually explore, understand, combine, clean, and normalise your data. When you create a project, you create a workspace to hold information about your data, the transformations that you make to it, and the jobs that you schedule to transform it.

## DataBrew Processing
1. Create a Dataset
![db2](/section_3/img/q_dataset.png)

2. Create a Project
![db3](/section_3/img/db_project.png)

3. Create a Recipe  
What is the Recipe?
    > A collection of data transformation steps is called a recipe. They are created or edited in an DataBrew project and can be published as a stand-alone entity.
    A published recipe is a template of just the transformations steps without context of the data. Users can publish multiple versions of a recipe from a project as they work on it. A recipe can be downloaded or applied to any other dataset in a project through a recipe job.

    Here, we use multiple functions of the recipe, including Window Funtions (ROW NUMBER), change data type, categorical mapping or relabeling, group by etc.  

    ![db4](/section_3/img/db-recipe.png)

4. Output  
We set up the output path into another AWS S3 bucket.  

    ![db4](/section_3/img/output2.png)
