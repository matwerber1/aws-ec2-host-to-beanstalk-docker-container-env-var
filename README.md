# Purpose

Assuming you are running Docker containers on an AWS Elastic Beanstalk EC2 environment, this document provides an example of how you can pass the EC2 hostname to your Docker container as a runtime environment variable. 

## Contents

This project contains a Dockerfile for a Docker image that injects an EC2 host's hostname as an environment variable into container at launch time. You can build the image yourself, or you use the [berbs/eb-ec2-metadata-container](https://hub.docker.com/repository/docker/berbs/eb-ec2-metadata-container) I pushed to Dockerhub. 

If you're using Elastic Beanstalk to deploy your containers, you can upload the included [Dockerrun.aws.json](https://github.com/matwerber1/aws-ec2-host-to-beanstalk-docker-container-env-var/blob/master/Dockerrun.aws.json) to a sandbox Beanstalk environment which will pull and deploy the image from Dockerhub for you. 

## How it works

Each Amazon EC2 instance provides a local [instance metadata service](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html) at `http://169.254.169.254/latest/meta-data/`, and which is only reachable from within that host.

Within our Dockerfile, our entry point is a shell script that queries the instance metadata for the EC2 hostname, exports it as an environment variable, and runs our example web server to show you the variable:

```sh
# Dockerfile
ENTRYPOINT ["/tmp/commands.sh"]
```

```sh
# /tmp/commands.sh
export CONNECT_REST_ADVERTISED_HOST_NAME=$(curl 169.254.169.254/latest/meta-data/hostname)
python /tmp/application.py
```

## Security considerations

If you have attached an IAM role to your EC2 instance, the instance metadata endpoint contains (among other things) the temporary IAM access keys for that role. Therefore, any user or service that can run curl on your EC2 host can also assume that host's role. Carefully consider whether and where this permission should be granted. In addition to restricting access locally (e.g. blocking the curl command), [AWS launched new ways to control access to instance metadata](https://aws.amazon.com/about-aws/whats-new/2019/11/announcing-updates-amazon-ec2-instance-metadata-service/) in November 2019.
