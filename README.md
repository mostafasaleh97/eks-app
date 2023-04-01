
# CICD to build eks infra and deploy app on it.

The idea from this project to use cicd pipeline to build infra of eks cluster on aws using terraform then build owr app and deploy it on eks cluster.



![App structure](https://github.com/mostafasaleh97/eks-app/blob/main/image.png?raw=false)


## Steps

This project is done by the following steps:

- preparing my terraform files
- preparing my app and dockerfile
- Setting the deployment files
- preparing my jenkinsfile
- Using jenkis to build pipeline

## 1-Preparing my terraform files

Build this step depend the nature of infrastucure we need.
Our infrastucure cosistes of the following:
- VPC contains two public subnets and two private subnets in two availability zone.
- internet gatway to access internet to my vpc.
- Nat gatway installed in public subnet to access internet to private subnets when needed.
- Two route table one for public sunets and the other for private.
- Security group of my cluster.
- EKS cluter with one groupnodes of one node that set in one of private subnet.
After preparing my terraform files, I push them with other files to my repo that I will use it by jenkins.

   









## preparing my app and dockerfile
I am already have a simple python app for test.

My app consists of simple front app and backend need database so I will use redis in this test as my datbase. 

I write a simple dockerfile that I will use after that in my cicd pipeline to build image in my dockerfile so I can use it in my kubernates deployment.

## Setting the deployment files
In this stage, I prepared two deployments files and two services

The first, my app deployment and I use my image in it and the service here from type of loadbalncer so i can access it from loadbalncer that will be created in public subnets.

The second, redis deployment to use it as database and it's service from type of cluster ip so my app can connect with it.

## preparing my jenkinsfile
Before this step, I have already installed jwnkins in Ec2 intsance and configured the neccessary credentials that I will use in my pipeline.

My pipeline consists of many stages:
- The first stage to build EKS infra using terraform and I use here the aws credentials as enviroment variables.
- The second stage to build my image using the dockerfile and bush it to my dockerhub.
- The last one to deploy the kubernates mainfests using the image I built in the second stage.

## Use jenkis to build pipeline
I just here create new item from type of pipeline and added my repo link to it then build the pipeline that used my jenkinsfile in the my repo un git hub.