library MPPEncounterLevel

using QICore version '4.1.1'

include FHIRHelpers version '4.3.000' called FHIRHelpers
include CQMCommon version '1.4.000' called CQMCommon
include QICoreCommon version '1.5.000' called QICoreCommon
include SupplementalDataElements version '3.4.000' called SDE
include TJCOverall version '8.9.000' called TJC
include AttributionModel version '0.1.0' called AM

valueset "Antithrombotic Therapy for Ischemic Stroke": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1110.62'
valueset "Hemorrhagic Stroke": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.212'
valueset "Ischemic Stroke": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.247'
valueset "Medical Reason For Not Providing Treatment": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.473'
valueset "Nonelective Inpatient Encounter": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.424'
valueset "Patient Refusal": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.93'
valueset "Pharmacological Contraindications For Antithrombotic Therapy": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1110.52'

parameter "Measurement Period" Interval<DateTime>
  default Interval[@2024-01-01T00:00:00.000Z, @2025-01-01T00:00:00.000Z)

context Patient

define "Non Elective Inpatient Encounter":
  ["Encounter": "Nonelective Inpatient Encounter"] NonElectiveEncounter
        where NonElectiveEncounter.period ends during day of "Measurement Period"

define "All Stroke Encounter":
  "Non Elective Inpatient Encounter" NonElectiveEncounter
  let ConditionCode: NonElectiveEncounter.principalDiagnosis().code
    where ( ConditionCode in "Hemorrhagic Stroke"
       or   ConditionCode in "Ischemic Stroke" )  

define "Encounter with Principal Diagnosis and Age":
  "All Stroke Encounter" AllStrokeEncounter
    where AgeInYearsAt(date from start of AllStrokeEncounter.period ) >= 18

define "Initial Population":
  "Encounter with Principal Diagnosis and Age" Encounter
    where Encounter.isAttributable()

