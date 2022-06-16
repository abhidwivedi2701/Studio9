### You must fill in the following varibles before executing the deployment.
# Remove the <> symbols before deploying.

############## Base Account and VPC ##################

# the account ID of the AWS account you will deploy to
account                         = ""

# the name of the AWS region e.g. "us-east-1"
aws_region                      = ""

# the comma separated list of availability zones e.g. [ "1a", "1b" ]
azs                             = []

# the VPC CIDR block you will launch DeepCortex into
vpc_cidr                        = ""

######################################################

######################### VPC ########################

# the following variables determine if you will create a VPC during deployemnt or use an already exisitng VPC
# if you choose to use an already existing VPC fill out the "Existing VPC Section"

# set to true to create a vpc or false to use one that's already created
create_vpc                      = "false"

# set to false to create NAT instances for private-egress subnets or true if only using public subnets
# should be false if using an existing VPC since that currently only supports public subnets
only_public                      = "true"

# the ami id for the machine that will serve as the NAT (should be specific for NAT instances)
# only use if only_public is false
nat_ami_id                      = ""

# if creating a VPC, enter the comma separated list of CIDRs for each subnet and availability zone
# Ex: [ "10.0.1.0/24", "10.0.2.0/24", ], [] for no subnets of that type
# if using an existing VPC, just enter placeholders for the correct number of subnets being used
# Ex: [ 0, 0 ] for 2 subnets of that type, [] for no subnets of that type
public_subnets                  = [0, 0]
private_subnets                 = []
private_subnets_egress          = []

######################################################

############## Existing VPC Section ##################

# the VPC ID of the VPC you will launch DeepCortex into
vpc_id                          = ""

# the VPC S3 Endpoint of the VPC you will launch DeepCortex into
vpce_id                         = ""

# the subnet IDs of the subnets you will launch DeepCortex into
subnet_id_0                     = ""
subnet_id_1                     = ""

######################################################

###################### IAM ###########################

# set to true to create IAM resources or false to use resources that have already created
create_iam                      = "false"

# set to true to use one IAM role for all machines and applications rather than splitting them up to give only necessary access to each machine type
singular_iam_role               = "true"

# set to true to use an IAM user on the DC/OS machines and set to false to use IAM roles
use_app_iam_user                = "false"

# if you plan to use IAM roles for terraform and packer, set to true
use_iam_roles                   = "true"

######################################################

################## AWS Variables #####################

# the arn value for the region being used
# ex: in AWS gov cloud a polic resources is written as "arn:aws-us-gov:iam::aws:policy"
# the arn value you would supply for AWS gov cloud is "aws-us-gov"
arn                             = ""

# the S3 endpoint for the region being used e.g. "s3-us-gov-west-1.amazonaws.com"
s3_endpoint                     = ""

######################################################

################## AMIs and Users ####################

# the ami id for the machine that will serve as the bastion (should be CentOS/RHEL or Amazon Linux)
bastion_ami_id                  = ""

# the ami id for the machines that will run DeepCortex (should be a CentOS/RHEL 7.4 ami)
packer_base_ami                 = ""

# if you plan to use IAM roles for packer enter the instance profile you wish packer to use
packer_iam_instance_profile     = ""

# if you would like packer to ssh via private IP (ex: if you're launching the deployment from a machine within your VPC) set this to true
packer_ssh_private_ip           = "true"

# if you would like to use a custom security group for packer enter the ID here
packer_security_group           = ""

# operating system for DeepCortex machines (centos or rhel)
machine_os                      = ""

# the default ssh user for the above ami (likely centos for CentOS machines or ec2-user for RHEL so make sure to check the ami you are using)
main_user                       = ""

# the public ssh key for the key you would like to use to access the DC/OS machines used for DeepCortex
ssh_public_key                  = ""

# the name of the above ssh key on the deployment machine (will be used to ssh to the captain machine during deployment)
ssh_key_name                    = ""

######################################################

################## Machine Access ####################

# the CIDR for a VPN or machine IP that should be able to access DeepCortex
access_cidr                     = ""

# the CIDR for the IP of the external machine that is running the deployment container (leave blank if using a machine in the same VPC you are deploying in)
deploy_cidr                     = ""

# the security group for the internal machine that is running the deployment container (leave blank if using an external machine)
deploy_sg                       = ""

# extra ssh keys: fill out the following section if you wish for the DC/OS machines to have additional
# ssh keys added to allow other users to ssh to those machines with a key other than the one provided above

# set to true if you'd like to add additional keys
download_ssh_keys               = ""

# specify the location of the file in S3 that contains the list of public keys you'd like to add to each machine
# leave blank if the above value is set to false
ssh_keys_s3_bucket              = ""

######################################################

###################### Logging #######################

# log file path depending upon machine_os (for centos or rhel file name is messages and Debian-based systems is syslog)
packer_log_file                 = "/tmp/packer_output.log"

terraform_log_file              = "/var/log/messages*"

# specify the location of the file in S3 that contains deployment related logs
deployment_logs_s3_path       = "deployment_logs"

# no of days deployment logs remain in S3 bucket
deployment_logs_retention_period = "7"

######################################################

################# Deployment Type ####################

# set to true for a private S3/local based deployment when public internet access is not available
private_deployment              = "true"

# set to the bucket containing S3 artifacts if the above is set to true
artifacts_s3_bucket             = ""

######################################################

#################### S3 Buckets ######################

# the name of the S3 buckets used for storing terraform artifacts, storing DeepCortex data, and storing DC/OS data
tf_bucket                       = ""
dcos_apps_bucket                = ""
dcos_stack_bucket               = ""

######################################################

##################### Redshift #######################

include_redshift                = "true"

# if you want to restore resdhift from a previous snapshot, speicfy the ID below
redshift_snapshot               = ""

# the number of days you wish to store redshift snapshots
automated_snapshot_retention_period = "7"

####################################################

##################### MongoDB #######################

# if you would like to restore mongo data from a backup, provide the date (YYYY_MM_DD) which should correspond to a directory in the main DeepCortex S3 bucket under mongo_backups
mongo_restore_date              = ""

# the number of days you wish to store mongo backups
mongo_backup_retention_period = "7"

####################################################

#################### Resource Tags ###################

# the tags that will be applied to the infrastructure (environment, owner, usage)
# environment and owner can only be a combined 17 characters
environment                     = ""
tag_owner                       = ""
tag_usage                       = ""

######################################################

############# Amazon SSM Agent and CLI ###############

# if you are in an AWS environment that does not support ssm, you should set this to false
install_amazon_ssm_agent        = ""

# if you do not wish to install the AWS CLI or your AMIs come with it pre-installed, set this to false (private deployment only)
install_aws_cli                 = ""

######################################################

################### Certificates #####################

# if you wish to explicitly specify the location for root certificate authorities, do so below (leave blank if you don't know what this is)
aws_ca_bundle                   = ""

######################################################

################## Data Settings ####################

# specify if Public MSTAR and CAD data should be uploaded to the default DeepCortex S3 bucket
upload_datasets                 = "false"

######################################################

###################### Other #########################

# The amount of time (minutes) to give slave nodes to connect to the master before they are terminated and a replaced with a new node. This aims to prevent failed nodes from holding up the deployment.
threshold_for_rogue_nodes = "10"

######################################################

### DO NOT CHANGE ANYTHING BELOW THIS LINE

############################################################################################################

################# Default Settings ###################

# version of DC/OS
dcos_version                    = "1.10.2"

# public vs private baile
baile_access                    = "private"

# smtp email true or false (if true, need to provide access keys for SES as env vars SMTP_AWS_ACCESS_KEY_ID SMTP_AWS_SECRET_ACCESS_KEY)
email_on                        = "false"

# enable online prediction (true/false)
online_prediction               = "false"

# true or false for downloading latest files (frontend and mstar) from S3 rather than using files in the docker container
download_from_s3                = "false"

# Platform
s3_prefix                       = "deepcortex"
cluster_name                    = "deepcortex-falcon"

bootstrap_asg_desired_capacity  = "1"
bootstrap_asg_min_size          = "0"
bootstrap_asg_max_size          = "1"

master_asg_desired_capacity     = "1"
master_asg_min_size             = "1"
master_asg_max_size             = "1"

# mesos, docker, log
master_xvde_size                = "50"
master_xvdf_size                = "50"
master_xvdh_size                = "50"

slave_asg_desired_capacity      = "3"
slave_asg_min_size              = "1"
slave_asg_max_size              = "3"

# mesos, docker, volume0, log
slave_xvde_size                 = "150"
slave_xvdf_size                 = "100"
slave_xvdg_size                 = "100"
slave_xvdh_size                 = "50"

gpu_slave_asg_desired_capacity  = "0"
gpu_slave_asg_min_size          = "0"
gpu_slave_asg_max_size          = "1"

# mesos, docker, log
gpu_slave_xvde_size             = "50"
gpu_slave_xvdf_size             = "50"
gpu_slave_xvdh_size             = "50"

public_slave_asg_desired_capacity  = "1"
public_slave_asg_min_size          = "1"
public_slave_asg_max_size          = "1"

# mesos, docker, log
public_slave_xvde_size             = "50"
public_slave_xvdf_size             = "50"
public_slave_xvdh_size             = "50"

captain_asg_desired_capacity       = "1"
captain_asg_min_size               = "0"
captain_asg_max_size               = "1"


# Redshift
redshift_family = "redshift-1.0"
redshift_database_name = "dev"
redshift_master_username = "deepcortex"
redshift_node_type = "dc1.large"
redshift_cluster_type = "single-node"
redshift_number_of_nodes = 1
redshift_encrypted = false
redshift_skip_final_snapshot = false
redshift_enhanced_vpc_routing = false

# Docker
docker_registry_url = "https://index.docker.io/v1/"

### Application Versions

# core applications

aries_docker_image_version = "2.1.0"
baile_docker_image_version = "2.1.0"
cortex_docker_image_version = "2.1.0"
cortex_task_docker_image_version = "2.1.0"
orion_docker_image_version = "2.1.0"
job_master_docker_image_version = "2.1.0"
um_docker_image_version = "2.0.0"

# supporting services

baile_haproxy_docker_image_version = "2.0.2"
logstash_docker_image_version = "2.0.0"
rmq_docker_image_version = "2.0.2"
scorpius_mongobackup_version = "1.0"

# DC/OS Catalog Services

percona_mongo_version="0.4.0-3.6.6"
elastic_version="2.3.0-5.6.5"
kibana_version="2.3.0-5.6.5"
marathon_lb_version="1.12.0"

# front end

salsa_version = "falcon"
baile_haproxy_api_path = "/v2.0/"

# online prediction services

argo_docker_image_version = "0.0.0-4f1c330c6da9efc8a9c27d3e566df8d9ed03346b"
pegasus_docker_image_version = "0.0.1-SNAPSHOT-29-gcf00f03"
taurus_docker_image_version = "0.0.0-ba399e1f12a328ad63a8e128deb8775a805a7fcd"

# Number of total DC/OS services
dcos_services = "15"

# It is observed that at the time of bootstrap DCOS cluster sometime slave nodes don't get connected with mesos-master.
# In this case platform stack stuck in infinite loop.
# To overcome this problem, script waits for specify threshold limit. If slave nodes don't get connected within the threshold limit then In order to allow autoscaling group to spin up fresh instance, script terminate rouge nodes.
threshold_for_rogue_nodes = "10"

# list of docker tar must be present on S3 before loading image to registry
docker_tar_list = "aries-api-rest.tar,baile-haproxy.tar,baile.tar,cortex-api-rest.tar,cortex-job-master.tar,cortex-tasks-gpu.tar,cortex-tasks-sklearn.tar,dcos-rabbitmq.tar,debian.tar,httpd.tar,logstash-rmq.tar,marathon-lb.tar,orion-api-rest.tar,percona-backup.tar,percona-server-mongodb.tar,registry.tar,um-service.tar,scorpius-mongobackup.tar"
######################################################