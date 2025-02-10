#!/usr/bin/env python3
import boto3
import json
import argparse
import botocore.exceptions

def list_resources(region, view_arn, max_results=100):
    client = boto3.client("resource-explorer-2", region_name=region)
    all_resources = []
    next_token = None

    while True:
        params = {"MaxResults": max_results, "ViewArn": view_arn}
        if next_token:
            params["NextToken"] = next_token

        try:
            response = client.list_resources(**params)
        except botocore.exceptions.ClientError as e:
            print(f"Error querying resources in {region}: {e}", flush=True)
            return []

        resources = response.get("Resources", [])
        all_resources.extend(resources)
        next_token = response.get("NextToken")
        if not next_token:
            break

    return all_resources

def main():
    parser = argparse.ArgumentParser(
        description="List AWS resources using the AWS Resource Explorer API using a pre-configured view."
    )
    parser.add_argument("--region", default="us-east-1", help="AWS region to query (default: us-east-1)")
    parser.add_argument("--view-arn", required=True, help="View ARN to use for the search (pre-filtered with tag.key:ENV).")
    args = parser.parse_args()

    print(f"Querying AWS resources in region {args.region} using view ARN '{args.view_arn}'")
    resources = list_resources(args.region, args.view_arn)

    if not resources:
        print("No resources found.")
    else:
        print(json.dumps(resources, indent=4, default=str))
        with open("filtered_aws_resources.json", "w") as f:
            json.dump(resources, f, indent=4, default=str)
        print("Filtered AWS Resources Report generated: filtered_aws_resources.json")

if __name__ == "__main__":
    main()
