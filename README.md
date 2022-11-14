   *************************Create an Azure VM cluster with Terraform*********************


Step1: First we need to install the terraform and setup environment variables.
Kindly check link below

https://learn.microsoft.com/en-us/azure/developer/terraform/get-started-windows-powershell?tabs=bash

In this article, we are going to perform below task

Set up Azure authentication.
Create a Terraform configuration file.
Use a Terraform configuration file to create a load balancer.
Use a Terraform configuration file to deploy two Linux VMs in an availability set.
Initialize Terraform.
Create a Terraform execution plan.
Apply the Terraform execution plan to create the Azure resources.

Set up Azure authentication

Authentication can be done only via Azure cli for Terraform, so make sure Azure cli need to be installed.
Once authentication completed, we can use VS code to work with Terraform.