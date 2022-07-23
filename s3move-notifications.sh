#!/bin/bash

# IMPORTANT -- CONFIGURATION VARIABLES
PNBUCKETNAME=<bucket_name>/<Folder_path>
SMSBUCKETNAME=<bucket_name>/<Folder_path>

# Check to see if there is any file for PN to be transferred. If so, move the file to Amazon S3
if [ "$(find /home/gds/pn/ -name "*.json")" ]; then
        # Make sure that CRON is able to find the AWS Configuration File
        export AWS_CONFIG_FILE=/root/.aws/config
        # Execute S3 moved to Bucket configured above
        aws s3 mv /home/gds/pn/ s3://$PNBUCKETNAME --recursive
fi

# Check to see if there is a any SERVER backups to move. If so, move the backups to Amazon S3
if [ "$(find /home/gds/sms/ -name "*.json")" ]; then
        # Make sure that CRON is able to find the AWS Configuration File
        export AWS_CONFIG_FILE=/root/.aws/config
        # Execute S3 moved to Bucket configured above
        aws s3 mv /home/gds/sms/ s3://$SMSBUCKETNAME --recursive
        exit 0
else
    	# If nothing exists in any of these folders, then do nothing
    	exit 0
fi
