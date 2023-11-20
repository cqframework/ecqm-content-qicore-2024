library HIVScreeningFHIR version '0.1.000'

using QICore version '4.1.1'

/*This spec aligns with AU2023/PY2024 QDM version*/


include FHIRHelpers version '4.3.000' called FHIRHelpers
include SupplementalDataElements version '3.4.000' called SDE
include CQMCommon version '2.0.000' called CQMCommon
include QICoreCommon version '2.0.000' called QICoreCommon

codesystem "LOINC": 'http://loinc.org'
codesystem "ActCode": 'http://terminology.hl7.org/CodeSystem/v3-ActCode'
codesystem "ConditionClinicalStatusCodes": 'http://terminology.hl7.org/CodeSystem/condition-clinical'
codesystem "ConditionVerificationStatus": 'http://terminology.hl7.org/CodeSystem/condition-ver-status'

valueset "HIV": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.120.12.1003'
valueset "Human Immunodeficiency Virus (HIV) Laboratory Test Codes (Ab and Ag)": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1056.50'
valueset "Office Visit": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1001'
valueset "Preventive Care Services - Established Office Visit, 18 and Up": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1025'
valueset "Preventive Care Services, Initial Office Visit, 0 to 17": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1022'
valueset "Preventive Care Services-Initial Office Visit, 18 and Up": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1023'
valueset "Preventive Care, Established Office Visit, 0 to 17": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1024'

code "Birth date": '21112-8' from "LOINC" display 'Birth date'
code "HIV 1 and 2 tests - Meaningful Use set": '75622-1' from "LOINC" display 'HIV 1 and 2 tests - Meaningful Use set'
code "AMB": 'AMB' from "ActCode" display 'Ambulatory'
code "active": 'active' from "ConditionClinicalStatusCodes"
code "refuted": 'refuted' from "ConditionVerificationStatus"

parameter "Measurement Period" Interval<DateTime>

context Patient

define "Initial Population":
  AgeInYearsAt(date from start of "Measurement Period") in Interval[15, 65]
    and exists "Qualifying Encounters"

define "Denominator":
  "Initial Population"

define "Numerator":
  ( "Has HIV Test Performed" )

define "Denominator Exclusions":
  exists ( ["Condition": "HIV"] HIV
      where HIV.prevalenceInterval ( ) starts before start of "Measurement Period"
        and HIV.verificationStatus !~ "refuted"
  )

define "Qualifying Encounters":
  ( ["Encounter": "Preventive Care Services, Initial Office Visit, 0 to 17"]
    union ["Encounter": "Preventive Care Services-Initial Office Visit, 18 and Up"]
    union ["Encounter": "Preventive Care, Established Office Visit, 0 to 17"]
    union ["Encounter": "Preventive Care Services - Established Office Visit, 18 and Up"]
    union ["Encounter": "Office Visit"] ) Encounter
    where Encounter.period during "Measurement Period"
      and Encounter.status = 'finished'

define "Has HIV Test Performed":
  exists ( ["Observation": "Human Immunodeficiency Virus (HIV) Laboratory Test Codes (Ab and Ag)"]
    union ["Observation": "HIV 1 and 2 tests - Meaningful Use set"] ) HIVTest
    where AgeInYearsAt(date from start of QICoreCommon."ToInterval"(HIVTest.effective)) in Interval[15, 65]
      and QICoreCommon."ToInterval" ( HIVTest.effective ) starts before end of "Measurement Period"
      and ( HIVTest.status = 'final'
          or HIVTest.status = 'amended'
          or HIVTest.status = 'corrected'
      )

define "SDE Ethnicity":
  SDE."SDE Ethnicity"

define "SDE Payer":
  SDE."SDE Payer"

define "SDE Race":
  SDE."SDE Race"

define "SDE Sex":
  SDE."SDE Sex"