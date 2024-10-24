import os
import json
import requests
from tqdm import tqdm

FHIR_SERVER_URL = "http://localhost:8089/fhir/ValueSet"

VALUESET_DIRECTORY = "input/vocabulary/valueset/external"
VALUESET_OUTPUT_DIRECTORY = "input/vocabulary/valueset/external/converted"


def convert_valuesets():
  print("Loading valuesets...")
  files = [f for f in os.listdir(VALUESET_DIRECTORY) if f.endswith(".json")]
  for file in tqdm(files):
    convert_valueset(file)

def convert_valueset(filename: str):
  filepath = os.path.join(VALUESET_DIRECTORY, filename)
  with open(filepath, 'r') as file:
    valueset = json.load(file)
    fhir_id = valueset["id"]
    if 'expansion' in valueset:
      compose = {"include": []}
      include = {"system": None, "concept": []}

      for code_info in valueset['expansion'].get('contains', []):
        # Check if the system is already included
        if include["system"] != code_info['system']:
          # If system changes, store the previous include and reset
          if include["system"]:
            compose["include"].append(include)
          include = {"system": code_info['system'], "concept": []}
        
        # Add the code and display to the concepts
        include["concept"].append({
          "code": code_info['code'],
          "display": code_info.get('display', "")
        })

      # Append the last include block
      compose["include"].append(include)
      
      # Add the new compose to the ValueSet and remove the expansion
      valueset['compose'] = compose
      del valueset['expansion']

  output_file = f'{VALUESET_OUTPUT_DIRECTORY}/{filename}'
  with open(output_file, 'w', encoding='utf-8') as f:
    json.dump(valueset, f, indent=2)

if __name__ == "__main__":
    convert_valueset("valueset-evdm-hysterectomy.json")
    # convert_valuesets()