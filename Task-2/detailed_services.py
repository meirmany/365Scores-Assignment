#!/usr/bin/env python3
import boto3
import json
import argparse
import botocore.exceptions

# Service-specific detail functions

def describe_ec2(region, arn):
    """Fetch detailed information for an EC2 instance using describe_instances."""
    ec2_client = boto3.client("ec2", region_name=region)
    instance_id = arn.split("/")[-1]
    if not instance_id.startswith("i-"):
        return {}
    try:
        response = ec2_client.describe_instances(InstanceIds=[instance_id])
        reservations = response.get("Reservations", [])
        if reservations and reservations[0]["Instances"]:
            return reservations[0]["Instances"][0]
    except botocore.exceptions.ClientError as e:
        print(f"Error describing EC2 instance {instance_id}: {e}")
    return {}

def describe_rds(region):
    """Fetch detailed information for RDS instances in the region."""
    rds_client = boto3.client("rds", region_name=region)
    try:
        response = rds_client.describe_db_instances()
        return response.get("DBInstances", [])
    except botocore.exceptions.ClientError as e:
        print(f"Error describing RDS instances in {region}: {e}")
    return []

def describe_s3(region):
    """Fetch detailed information for S3 buckets."""
    s3_client = boto3.client("s3", region_name=region)
    try:
        response = s3_client.list_buckets()
        return response.get("Buckets", [])
    except botocore.exceptions.ClientError as e:
        print(f"Error describing S3 buckets: {e}")
    return []

SERVICE_DESCRIBERS = {
    "ec2": lambda region, arn: describe_ec2(region, arn),
    "rds": lambda region, _: describe_rds(region),
    "s3": lambda region, _: describe_s3(region)
    # Extend with additional services as needed.
}

def get_service_details(region, resource):
    service = resource.get("Service", "").lower()
    arn = resource.get("Arn", "")
    if service in SERVICE_DESCRIBERS and arn:
        try:
            return SERVICE_DESCRIBERS[service](region, arn)
        except Exception as e:
            print(f"Error enriching resource {arn}: {e}")
    return {}

def get_detailed_resources(region, resources):
    enriched = []
    for resource in resources:
        service = resource.get("Service", "").lower()
        if service in SERVICE_DESCRIBERS:
            resource["Details"] = get_service_details(region, resource)
        enriched.append(resource)
    return enriched

def main():
    parser = argparse.ArgumentParser(
        description="Enrich AWS resources from Resource Explorer output with detailed information."
    )
    parser.add_argument("--input-file", required=True, help="JSON file from Phase 1 with tagged resources.")
    parser.add_argument("--region", default="us-east-1", help="AWS region to query for details (default: us-east-1)")
    args = parser.parse_args()

    # Load the Phase 1 output.
    with open(args.input_file, "r") as f:
        resources = json.load(f)

    print(f"Enriching details for resources in region {args.region} ...")
    enriched_resources = get_detailed_resources(args.region, resources)

    # Output the enriched resources.
    print(json.dumps(enriched_resources, indent=4, default=str))
    with open("detailed_aws_services.json", "w") as f:
        json.dump(enriched_resources, f, indent=4, default=str)
    print("Detailed AWS Services Report generated: detailed_aws_services.json")

if __name__ == "__main__":
    main()
