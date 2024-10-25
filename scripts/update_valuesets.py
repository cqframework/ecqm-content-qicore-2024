import base64
import csv
import json
import re
from pathlib import Path

import pandas as pd
import requests

# Replace with your VSAC API key
API_KEY = "apikey:ef6477ff-c9dc-4f5a-99f6-0048ddffc516"
encoded_api_key = base64.b64encode(API_KEY.encode()).decode()

# Define the base URL for VSAC API
VSAC_URL = "https://vsac.nlm.nih.gov/vsac/svs"


# Function to fetch value set concepts from VSAC
def fetch_value_set(value_set_oid):
    """
    Fetches the concepts of a value set from VSAC using the VSAC API.

    :param value_set_oid: OID of the value set.
    :return: A list of dictionaries containing code and description of the concepts.
    """
    # API endpoint for value set retrieval
    endpoint = f"https://cts.nlm.nih.gov/fhir/res/ValueSet/{value_set_oid}/$expand?_format=json"
    headers = {"Authorization": f"Basic {encoded_api_key}"}
    # Set up the parameters
    params = {"id": value_set_oid}

    # Make the GET request to fetch the value set
    response = requests.get(endpoint, headers=headers)

    if response.status_code == 200:
        data = response.json()
        return data
    else:
        print(f"Failed to fetch value set: {response.status_code} - {response.text}")
        return None


# Function to write concepts to CSV
def write_concepts_to_csv(concepts, output_file):
    """
    Writes the value set concepts to a CSV file.

    :param concepts: List of dictionaries containing code and description.
    :param output_file: Path to the output CSV file.
    """
    with open(output_file, mode="w", newline="", encoding="utf-8") as file:
        writer = csv.writer(file)
        writer.writerow(["Code", "Display Name", "System"])  # CSV header

        for concept in concepts:
            writer.writerow([concept["code"], concept["display"], concept["system"]])


def vsac_valueset_files(path: str):
    # Specify the directory
    directory = Path(path)
    # List all files in the directory
    files = [file.name for file in directory.iterdir() if file.is_file()]
    files = [f for f in files if re.match(r"^valueset-\d+\..*\.json$", f)]
    oids = [re.match(r"^valueset-(\d+\..*)\.json$", f).group(1) for f in files]
    # Print the list of files
    return files


# Main function to fetch and write value set concepts to a CSV
def main():
    valueset_path = "/Users/matt/dev/recoverx/ecqm-content-qicore-2024/input/vocabulary/valueset/external"
    files = vsac_valueset_files(valueset_path)

    # Fetch the value set concepts
    for file in files:
        value_set_oid = re.match(r"^valueset-(\d+\..*)\.json$", file).group(1)
        valueset_json = fetch_value_set(value_set_oid)
        if valueset_json:
            # Write the JSON data to a file
            output_file = f"{valueset_path}/{file}"
            with open(output_file, "w", encoding="utf-8") as f:
                json.dump(valueset_json, f, indent=2)
                print(f"Value set data written to {output_file}")
        else:
            print(f"No data to write for value_set {file}.")


if __name__ == "__main__":
    main()
