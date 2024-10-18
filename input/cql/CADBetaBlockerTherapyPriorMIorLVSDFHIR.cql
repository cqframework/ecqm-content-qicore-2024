library CADBetaBlockerTherapyPriorMIorLVSDFHIR version '0.1.000'

using QICore version '4.1.1'

include FHIRHelpers version '4.3.000' called FHIRHelpers
include SupplementalDataElements version '3.4.000' called SDE
include QICoreCommon version '2.0.000' called QICoreCommon
include AHAOverall version '2.6.000' called AHA

codesystem "ActCode": 'http://terminology.hl7.org/CodeSystem/v3-ActCode'
codesystem "SNOMEDCT": 'http://snomed.info/sct'
codesystem "CERNER": 'https://fhir.cerner.com/24e03c9a-e2fd-45f4-8243-e38cc7e8418d/codeSet/71'

valueset "Allergy to Beta Blocker Therapy": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1177'
valueset "Arrhythmia": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.366'
valueset "Asthma": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.362'
valueset "Atrioventricular Block": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.367'
valueset "Beta Blocker Therapy": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1174'
valueset "Beta Blocker Therapy for LVSD": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1184'
valueset "Beta Blocker Therapy Ingredient": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1493'
valueset "Bradycardia": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.412'
valueset "Cardiac Pacer": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1178.53'
valueset "Cardiac Pacer in Situ": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.368'
valueset "Cardiac Surgery": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.371'
valueset "Care Services in Long-Term Residential Facility": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1014'
valueset "Coronary Artery Disease No MI": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.369'
valueset "Ejection Fraction": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1134'
valueset "Face-to-Face Interaction": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1048'
valueset "Home Healthcare Services": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1016'
valueset "Hypotension": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.370'
valueset "Intolerance to Beta Blocker Therapy": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1178'
valueset "Medical Reason": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1007'
valueset "Moderate or Severe": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1092'
valueset "Moderate or Severe LVSD": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1090'
valueset "Myocardial Infarction": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.403'
valueset "Nursing Facility Visit": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1012'
valueset "Office Visit": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1001'
valueset "Outpatient Consultation": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1008'
valueset "Patient Provider Interaction": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1012'
valueset "Patient Reason": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1008'
valueset "System Reason": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1009'

code "Left ventricular systolic dysfunction (disorder)": '134401001' from "SNOMEDCT" display 'Left ventricular systolic dysfunction (disorder)'
code "Clinic": '22282402' from "CERNER" display 'Clinic'
code "Substance with beta adrenergic receptor antagonist mechanism of action (substance)": '373254001' from "SNOMEDCT" display 'Substance with beta adrenergic receptor antagonist mechanism of action (substance)'
code "Ambulatory": 'AMB' from "ActCode" display 'ambulatory'

parameter "Measurement Period" Interval<DateTime>
  default Interval[@2025-01-01T00:00:00.0, @2026-01-01T00:00:00.0)

context Patient

define "Age at start of Measurement Period":
  AgeInYearsAt(date from start of "Measurement Period")

define "Qualifying Encounter":
  "Qualifying Encounter During Measurement Period" Encounter1
        with "Qualifying Encounter During Measurement Period" Encounter2
          such that Encounter2.id !~ Encounter1.id

define "Initial Population":
  "Age at start of Measurement Period" >= 18
    and exists "Qualifying Encounter"
    and exists "Qualifying CAD Encounter"

define "Denominator 1":
  "Initial Population"
    and exists "Qualifying CAD Encounter and History of Moderate or Severe LVSD"

define "Numerator 1":
  exists "Beta Blocker Therapy for LVSD Ordered"
    or exists "Currently Taking Beta Blocker Therapy for LVSD"

define "Denominator Exceptions 1":
  exists "Arrhythmia with Qualifying CAD Encounter and History of Moderate or Severe LVSD"
    or exists "Asthma with Qualifying CAD Encounter and History of Moderate or Severe LVSD"
    or exists "Bradycardia with Qualifying CAD Encounter and History of Moderate or Severe LVSD"
    or exists "Hypotension with Qualifying CAD Encounter and History of Moderate or Severe LVSD"
    or exists "Consecutive Heart Rates Less than 50 with Qualifying CAD Encounter and History of Moderate or Severe LVSD"
    or exists "Allergy or Intolerance to Beta Blocker Therapy Ingredient with Qualifying CAD Encounter and History of Moderate or Severe LVSD"
    or exists "Diagnosis of Allergy or Intolerance to Beta Blocker Therapy with Qualifying CAD Encounter and History of Moderate or Severe LVSD"
      //Issue https://github.com/cqframework/cql-execution/issues/296 tied to https://github.com/projecttacoma/fqm-execution/issues/222
      /*or "Has Medical or Patient Reason for Not Ordering Beta Blocker for LVSD" */
    or ( exists "Atrioventricular Block with Qualifying CAD Encounter and History of Moderate or Severe LVSD"
      and not exists "Diagnosis of Cardiac Pacer in Situ with Qualifying CAD Encounter and History of Moderate or Severe LVSD"
      and not exists "Cardiac Pacer Device Implanted with Qualifying CAD Encounter and History of Moderate or Severe LVSD")

define "Denominator 2":
  "Initial Population"
    and exists "Qualifying CAD Encounter and Prior MI"

define "Numerator 2":
  exists "Beta Blocker Therapy Ordered"
    or exists "Currently Taking Beta Blocker Therapy"

define "Denominator Exceptions 2":
  exists "Arrhythmia with Qualifying CAD Encounter and Prior MI"
    or exists "Asthma with Qualifying CAD Encounter and Prior MI"
    or exists "Bradycardia with Qualifying CAD Encounter and Prior MI"
    or exists "Hypotension with Qualifying CAD Encounter and Prior MI"
    or exists "Consecutive Heart Rates Less than 50 with Qualifying CAD Encounter and Prior MI"
    or exists "Allergy or Intolerance to Beta Blocker Therapy Ingredient with Qualifying CAD Encounter and Prior MI"
    or exists "Diagnosis of Allergy or Intolerance to Beta Blocker Therapy with Qualifying CAD Encounter and Prior MI"
      //Issue https://github.com/cqframework/cql-execution/issues/296 tied to https://github.com/projecttacoma/fqm-execution/issues/222
      /*or "Has Medical or Patient Reason for Not Ordering Beta Blocker Therapy" */
    or (exists "Atrioventricular Block with Qualifying CAD Encounter and Prior MI"
      and not exists "Diagnosis of Cardiac Pacer in Situ with Qualifying CAD Encounter and Prior MI"
      and not exists "Cardiac Pacer Device Implanted with Qualifying CAD Encounter and Prior MI")

define "SDE Ethnicity":
  SDE."SDE Ethnicity"

define "SDE Payer":
  SDE."SDE Payer"

define "SDE Race":
  SDE."SDE Race"

define "SDE Sex":
  SDE."SDE Sex"

define "Coronary Artery Disease Encounter":
  "Outpatient Encounter During Measurement Period" ValidQualifyingEncounter
    with [Condition: "Coronary Artery Disease No MI"] CoronaryArteryDisease
      such that CoronaryArteryDisease.overlapsDayOfEncounter ( ValidQualifyingEncounter )

define "Allergy or Intolerance to Beta Blocker Therapy Ingredient with Qualifying CAD Encounter and History of Moderate or Severe LVSD":
  ( ( [AllergyIntolerance: "Beta Blocker Therapy Ingredient"]
      union [AllergyIntolerance: "Substance with beta adrenergic receptor antagonist mechanism of action (substance)"] ) BetaBlockerAllergyIntolerance
      where BetaBlockerAllergyIntolerance.overlapsAfterDayOfEncounter ( "Qualifying CAD Encounter and History of Moderate or Severe LVSD" )
  )

define "Allergy or Intolerance to Beta Blocker Therapy Ingredient with Qualifying CAD Encounter and Prior MI":
  ( ( [AllergyIntolerance: "Beta Blocker Therapy Ingredient"]
      union [AllergyIntolerance: "Substance with beta adrenergic receptor antagonist mechanism of action (substance)"] ) BetaBlockerAllergyIntolerance
      where BetaBlockerAllergyIntolerance.overlapsAfterDayOfEncounter ( "Qualifying CAD Encounter and Prior MI" )
  )

define "Arrhythmia with Qualifying CAD Encounter and History of Moderate or Severe LVSD":
  ( [Condition: "Arrhythmia"] ArrhythmiaDiagnosis
      where ArrhythmiaDiagnosis.overlapsDayOfEncounter ( "Qualifying CAD Encounter and History of Moderate or Severe LVSD" )
  )

define "Arrhythmia with Qualifying CAD Encounter and Prior MI":
  ( [Condition: "Arrhythmia"] ArrhythmiaDiagnosis
      where ArrhythmiaDiagnosis.overlapsDayOfEncounter ( "Qualifying CAD Encounter and Prior MI" )
  )

define "Asthma with Qualifying CAD Encounter and History of Moderate or Severe LVSD":
  ( [Condition: "Asthma"] AsthmaDiagnosis
      where AsthmaDiagnosis.overlapsDayOfEncounter ( "Qualifying CAD Encounter and History of Moderate or Severe LVSD" )
  )

define "Asthma with Qualifying CAD Encounter and Prior MI":
  ( [Condition: "Asthma"] AsthmaDiagnosis
      where AsthmaDiagnosis.overlapsDayOfEncounter ( "Qualifying CAD Encounter and Prior MI" )
  )

define "Atrioventricular Block with Qualifying CAD Encounter and History of Moderate or Severe LVSD":
  ( [Condition: "Atrioventricular Block"] AtrioventricularBlock
      where AtrioventricularBlock.overlapsDayOfEncounter ( "Qualifying CAD Encounter and History of Moderate or Severe LVSD" )
  )

define "Atrioventricular Block with Qualifying CAD Encounter and Prior MI":
  ( [Condition: "Atrioventricular Block"] AtrioventricularBlock
      where AtrioventricularBlock.overlapsDayOfEncounter ( "Qualifying CAD Encounter and Prior MI" )
  )  

define "Beta Blocker Therapy for LVSD Ordered":
  ( [MedicationRequest: medication in "Beta Blocker Therapy for LVSD"] BetaBlockerForLVSDOrdered
      where BetaBlockerForLVSDOrdered.authoredDuringDayOfEncounter ( "Qualifying CAD Encounter and History of Moderate or Severe LVSD" )
  )

define "Beta Blocker Therapy Ordered":
  ( [MedicationRequest: medication in "Beta Blocker Therapy"] BetaBlockerOrdered
      where BetaBlockerOrdered.authoredDuringDayOfEncounter ( "Qualifying CAD Encounter and Prior MI" )
  )

define "Bradycardia with Qualifying CAD Encounter and History of Moderate or Severe LVSD":
  ( [Condition: "Bradycardia"] BradycardiaDiagnosis
      where BradycardiaDiagnosis.overlapsDayOfEncounter ( "Qualifying CAD Encounter and History of Moderate or Severe LVSD" )
  )

define "Bradycardia with Qualifying CAD Encounter and Prior MI":
  ( [Condition: "Bradycardia"] BradycardiaDiagnosis
      where BradycardiaDiagnosis.overlapsDayOfEncounter ( "Qualifying CAD Encounter and Prior MI" )
  )

define "Cardiac Pacer Device Implanted with Qualifying CAD Encounter and History of Moderate or Severe LVSD":
  ( [Procedure: "Cardiac Pacer"] ImplantedCardiacPacer
      with "Qualifying CAD Encounter and History of Moderate or Severe LVSD" CADEncounterModerateOrSevereLVSD
        such that ImplantedCardiacPacer.performed.toInterval ( ) starts before end of CADEncounterModerateOrSevereLVSD.period
  )

define "Cardiac Pacer Device Implanted with Qualifying CAD Encounter and Prior MI":
  ( [Procedure: "Cardiac Pacer"] ImplantedCardiacPacer
      with "Qualifying CAD Encounter and Prior MI" CADEncounterMI
        such that ImplantedCardiacPacer.performed.toInterval ( ) starts before end of CADEncounterMI.period
  )
            
/*
* @code: Heart rate - 8867-4
* @profile: http://hl7.org/fhir/StructureDefinition/heartrate 
*/


define "Consecutive Heart Rates Less than 50 with Qualifying CAD Encounter and History of Moderate or Severe LVSD":
  ( from
      ["observation-heartrate"] HeartRate,
      "Qualifying CAD Encounter and History of Moderate or Severe LVSD" CADEncounterModerateOrSevereLVSD
      let PriorHeartRate: Last(["observation-heartrate"] MostRecentPriorHeartRate
          where MostRecentPriorHeartRate.effective.toInterval() during CADEncounterModerateOrSevereLVSD.period
            and MostRecentPriorHeartRate.effective.toInterval() before HeartRate.effective.toInterval()
          sort by start of effective.toInterval()
      )
      where HeartRate.effective.toInterval ( ) during CADEncounterModerateOrSevereLVSD.period
        and HeartRate.value as Quantity < 50 '/min'
        and PriorHeartRate.value as Quantity < 50 '/min'
  )
/*
* @code: Heart rate - 8867-4
* @profile: http://hl7.org/fhir/StructureDefinition/heartrate 
*/


define "Consecutive Heart Rates Less than 50 with Qualifying CAD Encounter and Prior MI":
  ( from
      ["observation-heartrate"] HeartRate,
      "Qualifying CAD Encounter and Prior MI" CADEncounterMI
      let PriorHeartRate: Last(["observation-heartrate"] MostRecentPriorHeartRate
          where MostRecentPriorHeartRate.effective.toInterval() during CADEncounterMI.period
            and MostRecentPriorHeartRate.status in { 'final', 'amended', 'corrected' }
            and MostRecentPriorHeartRate.effective.toInterval() before HeartRate.effective.toInterval()
          sort by start of effective.toInterval()
      )
      where HeartRate.effective.toInterval ( ) during CADEncounterMI.period
        and HeartRate.status in { 'final', 'amended', 'corrected' }
        and HeartRate.value as Quantity < 50 '/min'
        and PriorHeartRate.value as Quantity < 50 '/min'
  )

define "Diagnosis of Allergy or Intolerance to Beta Blocker Therapy with Qualifying CAD Encounter and History of Moderate or Severe LVSD":
  ( ( [Condition: "Allergy to Beta Blocker Therapy"]
      union [Condition: "Intolerance to Beta Blocker Therapy"] ) BetaBlockerAllergyOrIntoleranceDiagnosis
      where BetaBlockerAllergyOrIntoleranceDiagnosis.overlapsAfterDayOfEncounter ( "Qualifying CAD Encounter and History of Moderate or Severe LVSD" )
  )

define "Diagnosis of Allergy or Intolerance to Beta Blocker Therapy with Qualifying CAD Encounter and Prior MI":
  ( ( [Condition: "Allergy to Beta Blocker Therapy"]
      union [Condition: "Intolerance to Beta Blocker Therapy"] ) BetaBlockerAllergyOrIntoleranceDiagnosis
      where BetaBlockerAllergyOrIntoleranceDiagnosis.overlapsAfterDayOfEncounter ( "Qualifying CAD Encounter and Prior MI" )
  )

define "Diagnosis of Cardiac Pacer in Situ with Qualifying CAD Encounter and History of Moderate or Severe LVSD":
  ( [Condition: "Cardiac Pacer in Situ"] CardiacPacerDiagnosis
      where CardiacPacerDiagnosis.overlapsDayOfEncounter ( "Qualifying CAD Encounter and History of Moderate or Severe LVSD" )
  )

define "Diagnosis of Cardiac Pacer in Situ with Qualifying CAD Encounter and Prior MI":
  ( [Condition: "Cardiac Pacer in Situ"] CardiacPacerDiagnosis
      where CardiacPacerDiagnosis.overlapsDayOfEncounter ( "Qualifying CAD Encounter and Prior MI" )
  )

define "History of Cardiac Surgery Prior to Encounter":
  "Outpatient Encounter During Measurement Period" ValidQualifyingEncounter
    with [Procedure: "Cardiac Surgery"] CardiacSurgery
      such that CardiacSurgery.performed.toInterval ( ) starts before end of ValidQualifyingEncounter.period
        and CardiacSurgery.status = 'completed'

define "Hypotension with Qualifying CAD Encounter and History of Moderate or Severe LVSD":
  ( [Condition: "Hypotension"] HypotensionDiagnosis
      where HypotensionDiagnosis.overlapsDayOfEncounter ( "Qualifying CAD Encounter and History of Moderate or Severe LVSD" )
  )

define "Hypotension with Qualifying CAD Encounter and Prior MI":
  ( [Condition: "Hypotension"] HypotensionDiagnosis
      where HypotensionDiagnosis.overlapsDayOfEncounter ( "Qualifying CAD Encounter and Prior MI" )
  )

define "Medical or Patient Reason for Not Ordering Beta Blocker for LVSD":
  ( [MedicationNotRequested: medication in "Beta Blocker Therapy for LVSD"] NoBetaBlockerForLVSDOrdered
      with "Qualifying CAD Encounter and History of Moderate or Severe LVSD" LVSDVisit
        such that NoBetaBlockerForLVSDOrdered.authoredOn during day of LVSDVisit.period
      where NoBetaBlockerForLVSDOrdered.status in { 'active', 'completed' }
        and NoBetaBlockerForLVSDOrdered.intent in { 'order', 'original-order', 'reflex-order', 'filler-order', 'instance-order' }
        and exists ( NoBetaBlockerForLVSDOrdered.reasonCode reasonNotGiven
            where reasonNotGiven in "Medical Reason"
              or reasonNotGiven in "Patient Reason"
        )
  )
 
//Issue: https://github.com/cqframework/cql-execution/issues/296 


define "Medical or Patient Reason for Not Ordering Beta Blocker Therapy":
  ( [MedicationNotRequested: medication in "Beta Blocker Therapy for LVSD"] NoBetaBlockerForLVSDOrdered
      with "Qualifying CAD Encounter and Prior MI" PriorMIVisit
        such that NoBetaBlockerForLVSDOrdered.authoredOn during day of PriorMIVisit.period
      where NoBetaBlockerForLVSDOrdered.status in { 'active', 'completed' }
        and NoBetaBlockerForLVSDOrdered.intent in { 'order', 'original-order', 'reflex-order', 'filler-order', 'instance-order' }
        and exists ( NoBetaBlockerForLVSDOrdered.reasonCode reasonNotGiven
            where reasonNotGiven in "Medical Reason"
              or reasonNotGiven in "Patient Reason"
        )
  )

define "Currently Taking Beta Blocker Therapy":
  ( [MedicationRequest: medication in "Beta Blocker Therapy"] ActiveBetaBlocker
      with "Qualifying CAD Encounter and Prior MI" CADEncounterMI
        such that First((collapse(ActiveBetaBlocker.dosageInstruction.timing.repeat.bounds DoseTime
              return DoseTime.toInterval()
          )) DrugPeriod
            sort by start of $this
        ) overlaps after day of CADEncounterMI.period
      where ActiveBetaBlocker.status in { 'active', 'completed' }
        and ActiveBetaBlocker.intent in { 'order', 'original-order', 'reflex-order', 'filler-order', 'instance-order' }
        and ActiveBetaBlocker.doNotPerform is not true
  )

define "Currently Taking Beta Blocker Therapy for LVSD":
  ( [MedicationRequest: medication in "Beta Blocker Therapy"] ActiveBetaBlocker
      with "Qualifying CAD Encounter and History of Moderate or Severe LVSD" CADEncounterModerateOrSevereLVSD
        such that First((collapse(ActiveBetaBlocker.dosageInstruction.timing.repeat.bounds DoseTime
              return DoseTime.toInterval()
          )) DrugPeriod
            sort by start of $this
        ) overlaps after day of CADEncounterModerateOrSevereLVSD.period
      where ActiveBetaBlocker.status in { 'active', 'completed' }
        and ActiveBetaBlocker.intent in { 'order', 'original-order', 'reflex-order', 'filler-order', 'instance-order' }
  )

define "Outpatient Encounter During Measurement Period":
  ( [Encounter: "Office Visit"]
    union [Encounter: "Outpatient Consultation"]
    union [Encounter: "Care Services in Long-Term Residential Facility"]
    union [Encounter: "Home Healthcare Services"]
    union [Encounter: "Nursing Facility Visit"] 
    union [Encounter: "Clinic"] ) QualifyingEncounter
    where QualifyingEncounter.period during day of "Measurement Period"
      and QualifyingEncounter.status = 'finished'

define "Qualifying CAD Encounter":
  "Coronary Artery Disease Encounter"
    union "History of Cardiac Surgery Prior to Encounter"

define "Qualifying CAD Encounter and History of Moderate or Severe LVSD":
  "Qualifying CAD Encounter" EncounterWithCADProxy
    with AHA."Moderate or Severe LVSD Findings" LVSDFindings
      such that Coalesce(LVSDFindings.prevalenceInterval(), LVSDFindings.effective.toInterval()) starts before end of EncounterWithCADProxy.period

define "Qualifying CAD Encounter and Prior MI":
  "Qualifying CAD Encounter" EncounterWithCADProxy
    with [Condition: "Myocardial Infarction"] MyocardialInfarction
      such that MyocardialInfarction.prevalenceInterval ( ) starts 3 years or less before day of start of EncounterWithCADProxy.period
        and not exists AHA."Moderate or Severe LVSD Findings"

define "Qualifying Encounter During Measurement Period":
  ( [Encounter: "Office Visit"]
    union [Encounter: "Outpatient Consultation"]
    union [Encounter: "Nursing Facility Visit"]
    union [Encounter: "Care Services in Long-Term Residential Facility"]
    union [Encounter: "Home Healthcare Services"]
    union [Encounter: "Patient Provider Interaction"]
    union [Encounter: "Clinic"] ) ValidEncounter
    where ValidEncounter.period during day of "Measurement Period"
      and ValidEncounter.status = 'finished'


define fluent function overlapsDayOfEncounter(Diagnosis Condition, EncounterList List<Encounter>):
  AnyTrue(EncounterList Visit
      where Diagnosis.isActive()
      return Diagnosis.prevalenceInterval() overlaps day of Visit.period
  )

define fluent function overlapsDayOfEncounter(Diagnosis Condition, TheEncounter Encounter):
  TheEncounter Visit
    where Diagnosis.isActive ( )
      and not ( Diagnosis.verificationStatus ~ QICoreCommon."unconfirmed"
          or Diagnosis.verificationStatus ~ QICoreCommon."refuted"
          or Diagnosis.verificationStatus ~ QICoreCommon."entered-in-error"
      )
    return Diagnosis.prevalenceInterval ( ) overlaps day of Visit.period

define fluent function overlapsAfterDayOfEncounter(Event Choice<AllergyIntolerance, Condition, MedicationRequest>, EncounterList List<Encounter>):
  AnyTrue(EncounterList Visit
      return case
        when(Event is AllergyIntolerance) then(Interval[start of Event.onset.toInterval(), Event.lastOccurrence]overlaps after day of Visit.period
            and(Event.clinicalStatus is null
                or Event.clinicalStatus ~ QICoreCommon."allergy-active"
            )
        )
        when(Event is Condition) then(Event.isActive()
            and Event.prevalenceInterval() overlaps after day of Visit.period
            and not(Event.verificationStatus ~ QICoreCommon."unconfirmed"
                or Event.verificationStatus ~ QICoreCommon."refuted"
                or Event.verificationStatus ~ QICoreCommon."entered-in-error"
            )
        ) 
        else false 
      end
  )

define fluent function authoredDuringDayOfEncounter(Order Choice<MedicationRequest, MedicationNotRequested>, EncounterList List<Encounter>):
  AnyTrue(EncounterList Visit
      return case
        when(Order is MedicationRequest) then(Order.authoredOn during day of Visit.period
            and Order.status in { 'active', 'completed' }
            and Order.intent in { 'order', 'original-order', 'reflex-order', 'filler-order', 'instance-order' }
            and Order.doNotPerform is not true
        )
        when(Order is MedicationNotRequested) then(Order.authoredOn during day of Visit.period
            and Order.intent in { 'order', 'original-order', 'reflex-order', 'filler-order', 'instance-order' }
        ) 
        else false 
      end
  )