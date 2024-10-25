import os
import pathlib
import xml.etree.ElementTree as ET
from typing import Optional

import pandas as pd
import requests
from loguru import logger

from vsac_valueset_fetcher import base

MEASURE_ID_TO_NAME = {v: k for k, v in base.MeasureIDMap.__members__.items()}


class VsacValuesetFetcher:
    base_url = base.VSAC_URL
    api_key = base.encoded_api_key
    """
    This class fetches the valuesets and concepts of a given measure from VSAC using the VSAC SVS API.
    Returns and saves the dataframe at output_df_path
    :params
    -   base_url : svs api url for vsac
    -   api_key : UMLS key to access VSAC svs and FHIR endpoints
    -   measure ID : CMS measure ID of the value set (refer Base for a predefined list of ids)
    -   version : release version
    -   systems : list of systems to be fetched (defaults to all systems)
    -   output_df_path : path where the parsed df should be stored (defaults to valuesets.csv in cwd of user)
    """

    def __init__(
        self,
        output_path: pathlib.Path = base.OUTPUT_DF_PATH,
        requested_systems: list[str] = list(base.TaxonomyMap.__members__.values()),
    ) -> None:
        self.output_path = output_path
        self.requested_systems = requested_systems

    def fetch_value_sets(
        self,
        measure_id: str,
        version: str,
    ) -> Optional[pd.DataFrame]:
        """
        Fetches the valuesets and concepts of a given measure from VSAC using the VSAC SVS API and returns a dataframe.
        """
        tag_value = measure_id + version
        endpoint = f"{self.base_url}/RetrieveMultipleValueSets?tagName=CMS eMeasure ID&tagValue={tag_value}"
        headers = {"Authorization": f"Basic {self.api_key}"}
        response = requests.get(endpoint, headers=headers)
        if response.status_code == 200:
            logger.info("Fetched valuesets for {}", measure_id)
            return self.parse_response(response.text, measure_id)
        else:
            logger.debug(
                "Failed to fetch value set: {} - {}",
                response.status_code,
                response.text,
            )
            return None

    def fetch_and_save_valuesets(
        self,
        measures: list[str],
        version: str,
    ) -> pd.DataFrame:
        """
        Fetches and savesthe valuesets and concepts of a given measure from VSAC using the VSAC SVS API.
        Returns and saves the dataframe at output_df_path
        """
        final_df = pd.DataFrame()
        for measure in measures:
            measure_df = self.fetch_value_sets(measure, version)
            final_df = pd.concat([final_df, measure_df], ignore_index=True)
        final_df.to_csv(self.output_path)
        logger.info("Saved the csv at {}", self.output_path)
        logger.info("Total number of entries {}", len(final_df))

        return final_df

    def parse_response(self, xml_content: str, measure_id: str) -> pd.DataFrame:
        root = ET.fromstring(xml_content.replace("ns0:", ""))
        rows = self._process_valuesets(root)
        return self._build_dataframe(rows, measure_id)

    def _process_valuesets(self, root: ET.Element) -> list[dict[str, Optional[str]]]:
        """Process all valuesets and their concepts into rows of data"""
        rows: list[dict[str, Optional[str]]] = []
        # All valuesets begin with the tag "DescribedValueSet"
        valuesets = root.findall(".//DescribedValueSet")
        for valueset in valuesets:
            valueset_info = {
                "Valueset OID": valueset.get("ID"),
                "ValuesetName": valueset.get("displayName"),
                "eCQM Version": valueset.get("version"),
            }
            # All concepts begin with the tag "Concept"
            concepts = valueset.findall(".//Concept")
            if concepts:
                for concept in concepts:
                    rows.append(
                        {
                            **valueset_info,
                            "System": concept.get("codeSystemName"),
                            "System Version": concept.get("codeSystemVersion"),
                            "Code": concept.get("code"),
                            "Descriptor": concept.get("displayName"),
                        }
                    )
            else:
                rows.append(valueset_info)
        return rows

    def _build_dataframe(
        self, rows: list[dict[str, Optional[str]]], measure_id: str
    ) -> pd.DataFrame:
        """Build and format the final DataFrame with expected columns"""
        df = pd.DataFrame(rows)

        df["Measure Name"] = MEASURE_ID_TO_NAME[measure_id]
        df["Measure ID"] = measure_id

        expected_columns = [
            "Measure Name",
            "Measure ID",
            "Valueset OID",
            "ValuesetName",
            "eCQM Version",
            "System",
            "System Version",
            "Code",
            "Descriptor",
        ]
        return df[expected_columns]


if __name__ == "__main__":
    from vsac_valueset_fetcher import base

    concepts = VsacValuesetFetcher().fetch_and_save_valuesets(
        list(base.MeasureIDMap.__members__.values()),
        base.VersionMap.May2024.value,
    )
    print(concepts.head())
