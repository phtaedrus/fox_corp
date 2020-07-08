#Fox Corporation Terraform Project

Use this Terraform  to generate:

* An S3 bucket

* An IAM role

* An IAM policy attached to the role that allows it to perform any
            S3 actions on that bucket and the objects in it

* An EC2 instance with the IAM role attached

* Output the public IP of the EC2 instance and the S3 bucket name to output log files
            
        
##### I.) Please make sure that Terraform is installed on a linux machine 
https://learn.hashicorp.com/terraform/getting-started/install.html 
##### II.) AWS credentials should be configured at the command line with
#### 
```aws configure```

##### III.) At the command line please run
1] ```terraform init``` 

+ + This will prepare your terraform environment and let you know of
anything missing or broken.
 
``` 
> >  Terraform has been successfully initialized!
> >  You may now begin working with Terraform. 
> >  Try running "terraform plan" to see
> >  any changes that are required for your infrastructure. 
> >  All Terraform commands should now work
```
2] ```terraform plan```

+ + In a production setting you will want to know what 
you are destroying and what has been modified in state. This command will 
make sure you are ready to execute and give you a list of changes that are 
about to be made. 
 
 
  
```
> > An execution plan has been generated and is shown below.** 
> > 
> > Resource actions are indicated with the following symbols:
> > +create 
> > <=read (data resources)

>```

3] ```terraform apply```
+ +   This will deploy the resources, data, modules and terraform framework. 
```Plan: 6 to add, 0 to change, 0 to destroy.

> >   Do you want to perform these actions?
> >   Terraform will perform the actions described above.
> >   Only 'yes' will be accepted to approve.

> >   Enter a value: 
```

4] ```yes```

```
> > Apply complete! Resources: 7 added, 0 changed, 0 destroyed.

Outputs:

ec2_ip_address = 54.162.170.68
fox_bucket_ip = s3-foxcorp-test-kget.com

```
 + + Hooray! You have your infrastructure deployed. 
 
# **MAKE SURE TO RUN STEP 5**
 
5.a]  ```terraform destroy```

5.b] ```yes```
## Notes/Assumptions

1) This would be used by a seasoned Terraform devops professional as `aws configure`
is it's own set of complexities with decisions of user groups
and access policies.

2) Because of certain services propagation time between teardown and spinup 
I took the liberty of injecting a random 4 letter string into some of the services'
names. The state will overwrite them because there is no save mechanism.

3) This is a test/dummy deployment so security was in the best interest of no one here. 
That being said it is crucial to run 
```
terraform destroy
```
as well as logging into you AWS Console to double check permissions are cleaned up. 

 


