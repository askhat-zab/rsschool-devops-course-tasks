# Task 6


## 1. **Pipeline Configuration (40 points)**
    - A Jenkins pipeline is configured and stored as a Jenkinsfile in the main git repository.
![Jenkins pipeline](images/0_pipeline.png)
    - The pipeline includes the following steps:
        - Application build
![Application build](images/1_build.png)
        - Unit test execution
![Unit test execution](images/2_unit_test.png)
        - Security check with SonarQube
![SonarQube](images/3_sonarqube.png)
        - Docker image building and pushing to ECR (manual trigger)
![Dockerize](images/4_dockerize_1.png)
![Dockerize](images/4_dockerize_2.png)
        - Deployment to K8s cluster with Helm (dependent on the previous step)
![Helm install](images/5_deploy.png)
        - Configure the pipeline to be triggered on each push event to the repository.
![Trigger](images/12_trigger.png)


## 2. **Artifact Storage (20 points)**
    - Built artifacts (Dockerfile, Helm chart) are stored in git and ECR (Docker image).
![Built artifacts](images/6_artifact.png)


## 3. **Repository Submission (5 points)**
    - A repository is created with the application, Helm chart, and Jenkinsfile.
![Repository](images/7_repo.png)
[GitHub Repository](https://github.com/askhat-zab/repo)
[GitHub Pages](https://askhat-zab.github.io/repo/)


## 4. **Verification (5 points)**
    - The pipeline runs successfully and deploys the application to the K8s cluster.
![Jenkins pipeline](images/0_pipeline.png)
![Application](images/8_app.png)


## 5. **Additional Tasks (30 points)**
    - Application Verification (10 points)
        - Application verification is performed (e.g., curl main page, send requests to API, smoke test).
![Get pods](images/9_k_get_pods.png)
![Curl](images/10_smoke_test.png)
    - Notification System (10 points)
        - A notification system is set up to alert on pipeline failures or successes.
![Email](images/11_email.png)
    - Documentation (10 points)
        - The pipeline setup and deployment process, are documented in a README file.
[README](https://github.com/askhat-zab/rsschool-devops-course-tasks/blob/task_6/README.md)
[README](https://github.com/askhat-zab/repo/blob/main/README.md)


