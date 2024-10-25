"""This module defines all constants as well as base classes"""

import base64
import enum
import os
import pathlib

_ROOT = pathlib.Path(__file__).parent.parent
API_KEY = os.getenv("API_KEY")
encoded_api_key = base64.b64encode(API_KEY.encode()).decode()
VSAC_URL = "https://vsac.nlm.nih.gov/vsac/svs"
OUTPUT_DF_PATH = pathlib.Path(os.getcwd()) / "valuesets.csv"


class MeasureIDMap(str, enum.Enum):
    CervicalCancerScreeningFHIR = "CMS124"
    HFBetaBlockerTherapyforLVSDFHIR = "CMS144"
    CADBetaBlockerTherapyPriorMIorLVSDFHIR = "CMS145"
    ChlamydiaScreeninginWomenFHIR = "CMS153"


class VersionMap(str, enum.Enum):
    May2024 = "v13"


class TaxonomyMap(str, enum.Enum):
    SNOMEDCT = "http://snomed.info/sct"
    LOINC = "http://loinc.org"
    RXNORM = "http://www.nlm.nih.gov/research/umls/rxnorm"
    CPT = "http://www.ama-assn.org/go/cpt"
    ICD10 = "http://www.cms.gov/Medicare/Coding/ICD10"
    ICD10CM = "http://hl7.org/fhir/sid/icd-10-cm"
    ICD9CM = "http://terminology.hl7.org/CodeSystem/icd9cm"
    HSLOC = "https://www.cdc.gov/nhsn/cdaportal/terminology/codesystem/hsloc.html"
    GENDER = "http://terminology.hl7.org/CodeSystem/v3-AdministrativeGender"
    HCPCS = "https://www.cms.gov/Medicare/Coding/HCPCSReleaseCodeSets"
    HospitalAcqCond = "https://www.cms.gov/Medicare/Medicare-Fee-for-Service-Payment/HospitalAcqCond/Coding"
    RACE = "urn:oid:2.16.840.1.113883.6.238"
