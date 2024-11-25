# Task 6

## 1. **Pipeline Configuration (40 points)**

    - A Jenkins pipeline is configured and stored as a Jenkinsfile in the main git repository.
    - The pipeline includes the following steps:
        - Application build
        - Unit test execution
        - Security check with SonarQube
![SonarQube](images/sonarqube.png)
        - Docker image building and pushing to ECR (manual trigger)
        - Deployment to K8s cluster with Helm (dependent on the previous step)
![Jenkins pipeline](images/pipeline.png)

## 2. **Artifact Storage (20 points)**

    - Built artifacts (Dockerfile, Helm chart) are stored in git and ECR (Docker image).
![Built artifacts](images/artifact.png)

## 3. **Repository Submission (5 points)**

    - A repository is created with the application, Helm chart, and Jenkinsfile.
[GitHub Repository](https://github.com/askhat-zab/repo)
[GitHub Pages](https://askhat-zab.github.io/repo/)
![Check GH repo](images/gh-repo.png)

## 4. **Verification (5 points)**

    - The pipeline runs successfully and deploys the application to the K8s cluster.
![Jenkins pipeline](images/pipeline.png)
![Application](images/app.png)


## 5. **Additional Tasks (30 points)**

    - Application Verification (10 points)
        - Application verification is performed (e.g., curl main page, send requests to API, smoke test).
![Application verification](images/k_get_pods.png)
![Application verification](images/smoke_test.png)
    - Notification System (10 points)
        - A notification system is set up to alert on pipeline failures or successes.
    - Documentation (10 points)
        - The pipeline setup and deployment process, are documented in a README file.
[README](https://github.com/askhat-zab/rsschool-devops-course-tasks/blob/task_6/README.md)
[README](https://github.com/askhat-zab/repo/blob/main/README.md)


