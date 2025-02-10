# AWS API 

## A Python script uses Boto3 to list AWS services and provide details  

## The solution is split into two scripts:  

1. **Service Discovery (`used_services.py`):**  
   This script queries the AWS Resource Explorer API (via the `resource-explorer-2` client) to list AWS resources in a specified region.    
   It uses a pre-configured view that filters resources by a specific tag (e.g., `ENV`). The output is saved to `filtered_aws_resources.json`.  

2. **Services Enrichment (`detailed_services.py`):**  
   This script reads the filtered output from Phase 1 and for each service  
   (currently for EC2, RDS, and S3, but you may add other services as needed),  
   retrieves detailed information using service-specific AWS API calls. The enriched results are saved to `detailed_aws_services.json`.

---

## Pre-Requisites

- **AWS Credentials:**  
  Ensure your AWS CLI is installed and configured with valid credentials and your IAM permissions allow you to call the following APIs:
  - Resource Explorer (`resource-explorer-2:list_resources`)
  - EC2 (`describe_instances`)
  - RDS (`describe_db_instances`)
  - S3 (`list_buckets`)

- **AWS Resource Explorer:**  
  Enable AWS Resource Explorer in your account.  

  **Important:**  
  Create a custom view in Resource Explorer that filters resources based on a tag.  
  For example, you can create a view that only includes resources having a tag with the key `ENV`.  
  - $`aws resource-explorer-2 create-view --view-name My-EC2-Only-View --included-properties Name=tags --filters FilterString="tag.key:ENV" --region us-east-1` 
  - Note: The ARN of the created view will be provided to the scripts using the `--view-arn` argument.

- **Python & Dependencies:**  
  - Python 3.x is required.
  - Install required Python packages:
    ```bash
    pip install boto3
    ```
---

## Scripts Overview

### 1. Service Discovery (`used.services.py`)

- **Goal:**  
  Query the AWS Resource Explorer API to list AWS resources in the specified region using a pre-configured view (that filters on tag, e.g., `ENV`).
  
- **Key Functionality:**
  - Creates a boto3 client for `resource-explorer-2` and queries the API using the provided view ARN.
  - Handles pagination using the `NextToken` parameter.
  - Saves the complete list of resources to `filtered_aws_resources.json`.

- **Usage Example:**
  ```bash
  python3 used.services.py --region us-east-1 --view-arn arn:aws:resource-explorer-2:us-east-1:123456789012:view/MyFilteredView
  ```

### 2.Services Enrichment (`detailed_services.py`) 

- **Goal:**
  Enrich the resource inventory (from Phase 1) by retrieving detailed information for known services (currently supports EC2, RDS, and S3).

- **Key Functionality:**

- Reads the JSON file produced by Phase 1 (`filtered_aws_resources.json`).
- For each resource, calls the corresponding AWS API to retrieve extended details.
- Writes the enriched details to `detailed_aws_services.json`.

- **Usage Example:**
```bash
python3 `detailed_resources.py` --input-file `filtered_aws_resources.json` --region us-east-1
```

This command reads the filtered resource list and enriches details for defined resources (currently EC2, RDS, and S3),  
and saving the output to `detailed_aws_services.json`.  
