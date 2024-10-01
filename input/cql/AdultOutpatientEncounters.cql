library AdultOutpatientEncounters version '4.8.000'

using QICore version '4.1.1'

include FHIRHelpers version '4.3.000' called FHIRHelpers
include QICoreCommon version '2.0.000' called QICoreCommon
include Status version '1.6.000' called Status

codesystem "CERNER": 'https://fhir.cerner.com/7614e3af-e4eb-4094-af40-f129322755cb/codeSet/71'

valueset "Annual Wellness Visit": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1240' 
valueset "Home Healthcare Services": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1016' 
valueset "Office Visit": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1001' 
valueset "Online Assessments": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1089' 
valueset "Preventive Care Services Established Office Visit, 18 and Up": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1025' 
valueset "Preventive Care Services Initial Office Visit, 18 and Up": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1023' 
valueset "Telephone Visits": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1080' 

code "Clinic": '22282402' from "CERNER" display 'Clinic'

parameter "Measurement Period" Interval<DateTime>

context Patient

define "Qualifying Encounters":
  ( ( [Encounter: "Office Visit"]
    union [Encounter: "Annual Wellness Visit"]
    union [Encounter: "Preventive Care Services Established Office Visit, 18 and Up"]
    union [Encounter: "Preventive Care Services Initial Office Visit, 18 and Up"]
    union [Encounter: "Home Healthcare Services"]
    union [Encounter: "Online Assessments"]
    union [Encounter: "Telephone Visits"]
    union [Encounter: "Clinic"] ).isEncounterPerformed() ) ValidEncounter
    where ValidEncounter.period.toInterval() during day of "Measurement Period"