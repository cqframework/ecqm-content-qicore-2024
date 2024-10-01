library HFBetaBlockerTherapyforLVSDFHIR version '1.3.000'

using QICore version '4.1.1'

include FHIRHelpers version '4.3.000' called FHIRHelpers
include SupplementalDataElements version '3.4.000' called SDE
include QICoreCommon version '2.0.000' called QICoreCommon
include AHAOverall version '2.6.000' called AHA

codesystem "SNOMEDCT": 'http://snomed.info/sct'
codesystem "LOINC": 'http://loinc.org'

valueset "Allergy to Beta Blocker Therapy": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1177'
valueset "Arrhythmia": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.366'
valueset "Asthma": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.362'
valueset "Atrioventricular Block": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.367'
valueset "Beta Blocker Therapy for LVSD": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1184'
valueset "Beta Blocker Therapy Ingredient": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1493'
valueset "Bradycardia": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.412'
valueset "Cardiac Pacer": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1178.53'
valueset "Cardiac Pacer in Situ": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.368'
valueset "Hypotension": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.370'
valueset "Intolerance to Beta Blocker Therapy": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1178'
valueset "Left Ventricular Assist Device Placement": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1178.61'
valueset "Medical Reason": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1007'
valueset "Patient Reason": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1008'

code "Substance with beta adrenergic receptor antagonist mechanism of action (substance)": '373254001' from "SNOMEDCT" display 'Substance with beta adrenergic receptor antagonist mechanism of action (substance)'
code "Heart Rate": '8867-4' from "LOINC" display 'Heart Rate'

parameter "Measurement Period" Interval<DateTime>default Interval[@2025-01-01T00:00:00.0, @2026-01-01T00:00:00.0 )

context Patient

define "Age at start of Measurement Period":
  AgeInYearsAt(date from start of "Measurement Period")

define "Initial Population":
  "Age at start of Measurement Period" >= 18
    and Count(AHA."Qualifying Outpatient Encounter During Measurement Period") >= 2
    and exists AHA."Heart Failure Outpatient Encounter"

define "Denominator":
  "Initial Population"
    and exists AHA."Heart Failure Outpatient Encounter with History of Moderate or Severe LVSD"

define "Denominator Exclusions":
  exists (AHA."Heart Transplant")
    or exists (AHA."Heart Transplant Complications")
    or exists (AHA."Left Ventricular Assist Device")
    or exists (AHA."Left Ventricular Assist Device Complications")

define "Numerator":
  exists ("Beta Blocker Therapy for LVSD Ordered")
    or exists ("Currently Taking Beta Blocker Therapy for LVSD")

define "Denominator Exceptions":
  exists ("Consecutive Heart Rates Less than 50")
    or exists ("Medical or Patient Reason for Not Ordering Beta Blocker for LVSD")
    or exists ("Arrhythmia Diagnosis")
    or exists ("Hypotension Diagnosis")
    or exists ("Asthma Diagnosis")
    or exists ("Diagnosis of Allergy or Intolerance to Beta Blocker Therapy")
    or exists ("Bradycardia Diagnosis")
    or exists ("Allergy or Intolerance to Beta Blocker Therapy Ingredient")
    or (
      exists ("Atrioventricular Block Diagnosis")
      and not exists ("Diagnosis of Cardiac Pacer in Situ")
      and not exists ("Cardiac Pacer Device Implanted")
    )

define "SDE Ethnicity":
  SDE."SDE Ethnicity"

define "SDE Payer":
  SDE."SDE Payer"

define "SDE Race":
  SDE."SDE Race"

define "SDE Sex":
  SDE."SDE Sex"

// define "Atrioventricular Block without Cardiac Pacer":
//   exists ("Atrioventricular Block Diagnosis")
//     and not exists ("Diagnosis of Cardiac Pacer in Situ")
//     and not exists ("Cardiac Pacer Device Implanted")

define "Allergy or Intolerance to Beta Blocker Therapy Ingredient":
  ( [AllergyIntolerance: "Beta Blocker Therapy Ingredient"]
    union [AllergyIntolerance: "Substance with beta adrenergic receptor antagonist mechanism of action (substance)"] ) BetaBlockerAllergyIntolerance
    where BetaBlockerAllergyIntolerance.overlapsAfterHeartFailureOutpatientEncounter ( )
      and ( BetaBlockerAllergyIntolerance.clinicalStatus is null
          or BetaBlockerAllergyIntolerance.clinicalStatus ~ QICoreCommon."allergy-active"
      )

define "Arrhythmia Diagnosis":
  [Condition: "Arrhythmia"] Arrhythmia
    where Arrhythmia.overlapsHeartFailureOutpatientEncounter ( )
      and Arrhythmia.isActive ( )
      and Arrhythmia.verificationStatus ~ QICoreCommon."confirmed"

define "Asthma Diagnosis":
  [Condition: "Asthma"] Asthma
    where Asthma.overlapsHeartFailureOutpatientEncounter ( )
      and Asthma.isActive ( )
      and Asthma.verificationStatus ~ QICoreCommon."confirmed"

define "Atrioventricular Block Diagnosis":
  [Condition: "Atrioventricular Block"] AtrioventricularBlock
    where AtrioventricularBlock.overlapsHeartFailureOutpatientEncounter ( )
      and AtrioventricularBlock.isActive ( )
      and AtrioventricularBlock.verificationStatus ~ QICoreCommon."confirmed"

define "Beta Blocker Therapy for LVSD Ordered":
  [MedicationRequest: "Beta Blocker Therapy for LVSD"] BetaBlockerOrdered
      where BetaBlockerOrdered.isOrderedDuringHeartFailureOutpatientEncounter ( )
        and BetaBlockerOrdered.status in { 'active', 'completed' }
        and BetaBlockerOrdered.intent in { 'order', 'original-order', 'reflex-order', 'filler-order', 'instance-order' }

define "Bradycardia Diagnosis":
  [Condition: "Bradycardia"] Bradycardia
    where Bradycardia.overlapsHeartFailureOutpatientEncounter ( )
      and Bradycardia.isActive ( )
      and Bradycardia.verificationStatus ~ QICoreCommon."confirmed"

define "Cardiac Pacer Device Implanted":
  [Procedure: "Cardiac Pacer"] ImplantedCardiacPacer
    with AHA."Heart Failure Outpatient Encounter with History of Moderate or Severe LVSD" ModerateOrSevereLVSDHFOutpatientEncounter
      such that ImplantedCardiacPacer.performed.toInterval ( ) starts before end of ModerateOrSevereLVSDHFOutpatientEncounter.period
    where ImplantedCardiacPacer.status = 'completed'

define "Consecutive Heart Rates Less than 50":
  ( from
      "Heart Rates" HeartRate,
      AHA."Heart Failure Outpatient Encounter with History of Moderate or Severe LVSD" ModerateOrSevereLVSDHFOutpatientEncounter
      let PriorHeartRate: Last("Heart Rates" MostRecentPriorHeartRate
          where MostRecentPriorHeartRate.effective.toInterval() during ModerateOrSevereLVSDHFOutpatientEncounter.period
            and MostRecentPriorHeartRate.effective.toInterval() before HeartRate.effective.toInterval()
          sort by start of effective.toInterval()
      )
      where HeartRate.effective.toInterval ( ) during ModerateOrSevereLVSDHFOutpatientEncounter.period
        and HeartRate.status in { 'final', 'amended', 'corrected' }
        and HeartRate.value as Quantity < 50 '/min'
        and PriorHeartRate.value as Quantity < 50 '/min'
      return HeartRate
  )

define "Single Heart Rate Less than 50 value":
  ( from
      "Heart Rates" HeartRate
    where HeartRate.status in { 'final', 'amended', 'corrected' }
      and HeartRate.value as Quantity < 50 '/min'
    return HeartRate
  )

define "Heart Rates":
  [Observation: "Heart Rate"] HeartRate

define "Diagnosis of Allergy or Intolerance to Beta Blocker Therapy":
  ( ["Condition": "Allergy to Beta Blocker Therapy"]
    union ["Condition": "Intolerance to Beta Blocker Therapy"] ) BetaBlockerAllergyOrIntoleranceDiagnosis
    where BetaBlockerAllergyOrIntoleranceDiagnosis.overlapsAfterHeartFailureOutpatientEncounter ( )
      and BetaBlockerAllergyOrIntoleranceDiagnosis.isActive ( )
      and BetaBlockerAllergyOrIntoleranceDiagnosis.verificationStatus ~ QICoreCommon."confirmed"

define "Diagnosis of Cardiac Pacer in Situ":
  ["Condition": "Cardiac Pacer in Situ"] CardiacPacerDiagnosis
    where CardiacPacerDiagnosis.overlapsAfterHeartFailureOutpatientEncounter ( )
      and CardiacPacerDiagnosis.isActive ( )
      and CardiacPacerDiagnosis.verificationStatus ~ QICoreCommon."confirmed"

define "Hypotension Diagnosis":
  ["Condition": "Hypotension"] Hypotension
    where Hypotension.overlapsHeartFailureOutpatientEncounter ( )
      and Hypotension.isActive ( )
      and Hypotension.verificationStatus ~ QICoreCommon."confirmed"

define "Medical or Patient Reason for Not Ordering Beta Blocker for LVSD":
  ["MedicationNotRequested"] NoBetaBlockerOrdered
    with AHA."Heart Failure Outpatient Encounter with History of Moderate or Severe LVSD" ModerateOrSevereLVSDHFOutpatientEncounter
      such that NoBetaBlockerOrdered.authoredOn during ModerateOrSevereLVSDHFOutpatientEncounter.period
    where NoBetaBlockerOrdered.medication in "Beta Blocker Therapy for LVSD"
      and ( NoBetaBlockerOrdered.reasonCode in "Medical Reason"
          or NoBetaBlockerOrdered.reasonCode in "Patient Reason"
      )

define "Currently Taking Beta Blocker Therapy for LVSD":
  ["MedicationRequest": "Beta Blocker Therapy for LVSD"] ActiveBetaBlocker
      where ActiveBetaBlocker.overlapsAfterHeartFailureOutpatientEncounter ( )
