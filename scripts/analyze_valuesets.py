import requests
import pandas as pd
import csv
import re
from pathlib import Path
import base64
import json
from typing import Dict, List

CQL_PATH = '/Users/matt/dev/recoverx/ecqm-content-qicore-2024/input/cql'
VALUESET_PATH = '/Users/matt/dev/recoverx/ecqm-content-qicore-2024/input/vocabulary/valueset/external'
OUTPUT_DIR = '/Users/matt/dev/recoverx/ecqm-content-qicore-2024/scripts/output' 

def fetch_value_set(value_set_oid):
    """
    Fetches the concepts of a value set from VSAC using the VSAC API.
    
    :param value_set_oid: OID of the value set.
    :return: A list of dictionaries containing code and description of the concepts.
    """
    # API endpoint for value set retrieval
    endpoint = f"https://cts.nlm.nih.gov/fhir/res/ValueSet/{value_set_oid}/$expand?_format=json"
    headers = {
        'Authorization': f'Basic {encoded_api_key}'
    }
    # Set up the parameters
    params = {
        'id': value_set_oid
    }
    
    # Make the GET request to fetch the value set
    response = requests.get(endpoint, headers=headers)
    
    if response.status_code == 200:
        data = response.json()
        return data
    else:
        print(f"Failed to fetch value set: {response.status_code} - {response.text}")
        return None

def write_header_to_csv(output_file):
    with open(output_file, mode='w', encoding='utf-8') as file:
        writer = csv.writer(file)
        writer.writerow(["measure", "library", "valueset", "concept_system", "concept_code", "concept_display"])  # CSV header
        print()
        
def write_valueset_to_csv(measure, library, valueset, output_file):
    with open(output_file, mode='a', encoding='utf-8') as file:
        for concept in valueset.get('expansion', {}).get('contains', []):
            concept_system = concept.get('system')
            concept_code = concept.get('code')
            concept_display = concept.get('display')
            writer = csv.writer(file)
            writer.writerow([measure, library, valueset['url'], concept_system, concept_code, concept_display])
        print()

def read_valueset(value_set_oid):
    file_path = f'{VALUESET_PATH}/valueset-{value_set_oid}.json'
    with open(file_path, 'r') as file:
        data = json.load(file)
        return data    

def traverse_cql(library, library_valueset_oids: Dict[str, List[str]]):
    if library_valueset_oids.get(library):
        return
    file_path = f'{CQL_PATH}/{library}.cql'
    with open(file_path, 'r') as file:
        cql = file.read()
        value_set_oids = re.findall(r'valueset .*: \'http://cts.nlm.nih.gov/fhir/ValueSet/(.*)\'', cql)
        library_valueset_oids[library] = value_set_oids
        print(f"Value set OIDs for {library}: {value_set_oids}")
        libraries = re.findall(r'include (.*) version.*', cql)
        for lib in libraries:
            traverse_cql(lib, library_valueset_oids)

# Main function to fetch and write value set concepts to a CSV
def main():
    measures = ['CADBetaBlockerTherapyPriorMIorLVSDFHIR','CervicalCancerScreeningFHIR','ChlamydiaScreeninginWomenFHIR','HFBetaBlockerTherapyforLVSDFHIR']
    output_file = f"{OUTPUT_DIR}/measure-valuesets.csv"
    write_header_to_csv(output_file)
    for measure in measures:
      # Fetch the value set OIDs from the CQL file
      cql_file_valueset_oids = {}
      traverse_cql(measure, cql_file_valueset_oids)
      for library, value_set_oids in cql_file_valueset_oids.items():
        for value_set_oid in value_set_oids:
          valueset = read_valueset(value_set_oid)
          if valueset:            
              write_valueset_to_csv(measure, library, valueset, output_file)
              print(f"Value set concepts written to: {output_file}")
      print()
    
    

if __name__ == "__main__":
    main()