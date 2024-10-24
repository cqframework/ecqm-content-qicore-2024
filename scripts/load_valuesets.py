import os
import json
import requests
from tqdm import tqdm

FHIR_SERVER_URL = "http://localhost:8089/fhir/ValueSet"

VALUESET_DIRECTORY = "input/vocabulary/valueset/external/converted"

def load_valuesets():
  print("Loading valuesets...")
  files = [f for f in os.listdir(VALUESET_DIRECTORY) if f.endswith(".json")]
  for filename in tqdm(files, desc="Loading valuesets"):
    filepath = os.path.join(VALUESET_DIRECTORY, filename)
    with open(filepath, 'r') as file:
      valueset = json.load(file)
      fhir_id = valueset["id"]
      response = requests.put(f"{FHIR_SERVER_URL}/{fhir_id}", json=valueset)
      if response.status_code == 201 or response.status_code == 200:
        continue
        # print(f"Successfully loaded {filename}")
      else:
        print(f"Failed to load {filename}: {response.status_code} - {response.text}")
  print("Valuesets loaded.")

if __name__ == "__main__":
    load_valuesets()