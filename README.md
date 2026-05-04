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

======================================================================================

Task 1. Create the configuration files
--------------------------------------------------------------------------
In Cloud Shell, create your Terraform configuration files and a directory structure that resembles the following.
main.tf
variables.tf
modules/
└── instances
    ├── instances.tf
    ├── outputs.tf
    └── variables.tf
└── storage
    ├── storage.tf
    ├── outputs.tf
    └── variables.tf


2.Fill out the variables.tf files in the root directory and within the modules. Add three variables to each file: region, zone, and project_id. 
For their default values, use , <filled in at lab start>, and your Google Cloud Project ID

3.Add the Terraform block and the Google Provider to the main.tf file. Verify the zone argument is added along with the project and region arguments in the Google Provider block.

4.Initialize Terraform.

--------------------------------------------------------------------------
Task 2. Import infrastructure

1.In the Google Cloud Console, on the Navigation menu, click Compute Engine > VM Instances. Two instances named tf-instance-1 and tf-instance-2 have already been created for you.
Import the existing instances into the instances module. To do this, you will need to follow these steps:
First, add the module reference into the main.tf file then re-initialize Terraform.
Next, write the resource configurations in the instances.tf file to match the pre-existing instances.
Name your instances tf-instance-1 and tf-instance-2.
For the purposes of this lab, the resource configuration should be as minimal as possible. To accomplish this, you will only need to include the following additional arguments in your configuration: machine_type, boot_disk, network_interface, metadata_startup_script, and allow_stopping_for_update. For the last two arguments, use the following configuration as this will ensure you won't need to recreate it:
--------------------------------------
metadata_startup_script = <<-EOT
        #!/bin/bash
    EOT
allow_stopping_for_update = true
-----------------------------------------
Once you have written the resource configurations within the module, use the terraform import command to import them into your instances module.
Apply your changes. Note that since you did not fill out all of the arguments in the entire configuration, the apply will update the instances in-place. This is fine for lab purposes, but in a production environment, you should make sure to fill out all of the arguments correctly before importing.
---------------------------------------------------------------------------
Task 3. Configure a remote backend
Create a Cloud Storage bucket resource inside the storage module. For the bucket name, use Bucket Name. For the rest of the arguments, you can simply use:

location = "US"
force_destroy = true
uniform_bucket_level_access = true

Add the module reference to the main.tf file. Initialize the module and apply the changes to create the bucket using Terraform.

Configure this storage bucket as the remote backend inside the main.tf file. Be sure to use the prefix terraform/state so it can be graded successfully.

If you've written the configuration correctly, upon init, Terraform will ask whether you want to copy the existing state data to the new backend. Type yes at the prompt.
------------------------------------------------------------------------
Task 4. Modify and update infrastructure

Navigate to the instances module and modify the tf-instance-1 resource to use an e2-standard-2 machine type.

Modify the tf-instance-2 resource to use an e2-standard-2 machine type.

Add a third instance resource and name it Instance Name. For this third resource, use an e2-standard-2 machine type. Make sure to change the machine type to e2-standard-2 to all the three instances.

Initialize Terraform and apply your changes.
----------------------------------------------
Task 5. Destroy resources

Destroy the third instance Instance Name by removing the resource from the configuration file. After removing it, initialize terraform and apply the change.

----------------------------------------------
Task 6. Use a module from the Registry

In the Terraform Registry, browse to the Network Module.

Add this module to your main.tf file. Use the following configurations:

Use version 10.0.0 (different versions might cause compatibility errors).
Name the VPC VPC Name, and use a global routing mode.
Specify 2 subnets in the region, and name them subnet-01 and subnet-02. For the subnets arguments, you just need the Name, IP, and Region.
Use the IP 10.10.10.0/24 for subnet-01, and 10.10.20.0/24 for subnet-02.
You do not need any secondary ranges or routes associated with this VPC, so you can omit them from the configuration.
Once you've written the module configuration, initialize Terraform and run an apply to create the networks.

Next, navigate to the instances.tf file and update the configuration resources to connect tf-instance-1 to subnet-01 and tf-instance-2 to subnet-02.

-----------------------------------------------------------------
Task 7. Configure a firewall
Create a firewall rule resource in the main.tf file, and name it tf-firewall.
This firewall rule should permit the VPC Name network to allow ingress connections on all IP ranges (0.0.0.0/0) on TCP port 80.
Make sure you add the source_ranges argument with the correct IP range (0.0.0.0/0).
Initialize Terraform and apply your changes.
------------------------------------------------------------------

Credit: Google skills


