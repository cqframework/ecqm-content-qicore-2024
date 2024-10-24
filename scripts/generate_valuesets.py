import csv
import json
from datetime import datetime
from typing import Any, Dict, List, Tuple

from fhirclient.models import fhirdatetime 
from fhirclient.models import identifier as id
from fhirclient.models import valueset as vs

PROJECT_ROOT = "/Users/Abhi/Documents/rx-dev"
VALUESETS_CSV_PATH = PROJECT_ROOT + "/ecqm-content-qicore-2024/input/vocabulary/valueset/valueset-csvs/Hysterectomy_9_22_SNOMED_list_Hysterectomy_Reviewed.csv"
VALUESETS_OUTPUT_DIR = PROJECT_ROOT + "/ecqm-content-qicore-2024/input/vocabulary/valueset/external/"


def create_valueset(
    oid: str, name: str, title: str, codes_and_concepts: List[Tuple[str, str]]
) -> vs.ValueSet:
    """
    Create a FHIR ValueSet resource using fhirclient models.

    Args:
        oid: The OID for the ValueSet
        name: The name of the ValueSet
        title: The title of the ValueSet
        codes_and_concepts: List of tuples containing (concept, code)

    Returns:
        A FHIR ValueSet resource
    """
    current_date = datetime.now()
    timestamp: str = current_date.strftime("%Y-%m-%dT%H:%M:%S-06:00")
    year: str = current_date.strftime("%Y%m%d")

    valueset = vs.ValueSet()

    # Set the metadata
    valueset.id = oid
    valueset.url = f"ValueSet/{oid}"
    valueset.version = current_date.strftime("%Y%m%d")
    valueset.name = name
    valueset.title = title
    valueset.status = "active"
    valueset.experimental = False
    valueset.publisher = "Evidium"

    # Create and set the identifier
    identifier = id.Identifier()
    identifier.system = "urn:ietf:rfc:3986"
    identifier.value = oid
    valueset.identifier = [identifier]

    # Create the expansion
    expansion = vs.ValueSetExpansion()
    expansion.identifier = year
    expansion.timestamp = fhirdatetime.FHIRDateTime(timestamp)

    # Create contains elements
    contains: List[vs.ValueSetExpansionContains] = []
    for concept, code in codes_and_concepts:
        contains_element = vs.ValueSetExpansionContains()
        contains_element.system = "http://snomed.info/sct"
        contains_element.code = code
        contains_element.display = concept
        contains.append(contains_element)

    expansion.contains = contains
    valueset.expansion = expansion

    return valueset


def process_csv(filename: str) -> List[Tuple[str, str]]:
    """
    Process CSV file and extract Concept and Id pairs.

    Args:
        filename: Path to the CSV file

    Returns:
        List of tuples containing (concept, code)

    Raises:
        KeyError: If required columns 'Concept' or 'Id' are missing
        FileNotFoundError: If the CSV file doesn't exist
    """
    codes_and_concepts: List[Tuple[str, str]] = []

    try:
        with open(filename, "r") as csvfile:
            reader = csv.DictReader(csvfile)

            # Validate required columns exist
            required_columns = {"Concept", "Id"}
            if not required_columns.issubset(reader.fieldnames or []):
                missing = required_columns - set(reader.fieldnames or [])
                raise KeyError(f"Missing required columns: {missing}")

            for row in reader:
                concept = row["Concept"].strip()
                code = row["Id"].strip()
                codes_and_concepts.append((concept, code))

        return codes_and_concepts
    except FileNotFoundError:
        raise FileNotFoundError(f"CSV file not found: {filename}")


def save_valueset(valueset: vs.ValueSet, output_file: str) -> None:
    """
    Save ValueSet to a JSON file.

    Args:
        valueset: The FHIR ValueSet resource to save
        output_file: Path where the JSON file should be saved

    Raises:
        IOError: If there's an error writing to the output file
    """
    try:
        with open(output_file, "w") as f:
            json.dump(valueset.as_json(), f, indent=2)
    except IOError as e:
        raise IOError(f"Error writing to output file: {e}")


def main() -> None:
    """Main function to orchestrate the ValueSet generation process."""
    name = "Hysterectomy"
    title = "Hysterectomy"
    oid = "evdm-hysterectomy"
    output_path = VALUESETS_OUTPUT_DIR + "valueset-" + oid + ".json"
    try:
        # Process the CSV to get all concept-code pairs
        codes_and_concepts = process_csv(VALUESETS_CSV_PATH)

        # Create a ValueSet
        valueset = create_valueset(
            oid=oid, name=name, title=title, codes_and_concepts=codes_and_concepts
        )

        # Save to file
        save_valueset(valueset, output_path)
        print("ValueSet successfully generated and saved.")

    except (FileNotFoundError, KeyError, IOError) as e:
        print(f"Error: {e}")
        raise


if __name__ == "__main__":
    main()
