library SevereObstetricComplicationsFHIR version '0.1.000'

using QICore version '4.1.1'

include CQMCommon version '2.2.000' called CQMCommon
include FHIRHelpers version '4.4.000' called FHIRHelpers
include SupplementalDataElements version '3.5.000' called SDE
include PCMaternal version '5.19.000' called PCMaternal
include QICoreCommon version '2.1.000' called QICoreCommon

codesystem "LOINC": 'http://loinc.org'
codesystem "SNOMEDCT": 'http://snomed.info/sct'

code "Heart rate": '8867-4' from "LOINC" display 'Heart rate'
code "Systolic blood pressure": '8480-6' from "LOINC" display 'Systolic BP'

valueset "20 to 42 Plus Weeks Gestation": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1110.67'
valueset "Acute Heart Failure": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.233'
valueset "Acute Myocardial Infarction": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.666.5.623'
valueset "Acute or Persistent Asthma": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.271'
valueset "Acute Renal Failure": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1110.53'
valueset "Acute Respiratory Distress Syndrome": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.214'
valueset "Air and Thrombotic Embolism": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.243'
valueset "Amniotic Fluid Embolism": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.217'
valueset "Anemia": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.323'
valueset "Aortic Aneurysm": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.219'
valueset "Autoimmune Disease": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.311'
valueset "Bariatric Surgery": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.317'
valueset "Bleeding Disorder": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.287'
valueset "Blood Transfusion": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.213'
valueset "Cardiac Arrest Ventricular Fibrillation": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.221'
valueset "Cardiac Disease": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.341'
valueset "Conversion of Cardiac Rhythm": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.357'
valueset "COVID 19 Confirmed": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.373'
valueset "Delivery Procedures": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1045.59'
valueset "Disseminated Intravascular Coagulation": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.223'
valueset "Eclampsia": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.225'
valueset "Economic Housing Instability": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.292'
valueset "ED Visit and OB Triage": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.369'
valueset "Encounter Inpatient": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.666.5.307'
valueset "Estimated Gestational Age at Delivery": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1045.26'
valueset "Ethnicity": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.114222.4.11.837'
valueset "Gastrointestinal Disease": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.338'
valueset "Gestational Diabetes": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.269'
valueset "Heart Failure Cardiac Arrest Related to Procedure or Surgery": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.227'
valueset "Hematocrit lab test": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1045.114'
valueset "HIV in Pregnancy Childbirth and Puerperium": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.272'
valueset "Hypertension": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.332'
valueset "Hysterectomy": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.358'
valueset "Long Term Anticoagulant Use": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.366'
valueset "Mental Health Disorder": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.314'
valueset "Mild or Moderate Preeclampsia": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.329'
valueset "Morbid or Severe Obesity": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.290'
valueset "Multiple Pregnancy": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.284'
valueset "Neuromuscular Disease": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.308'
valueset "Observation Services": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1111.143'
valueset "ONC Administrative Sex": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1'
valueset "Patient Expired": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.309'
valueset "Payer Type": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.114222.4.11.3591'
valueset "Placenta Accreta": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.302'
valueset "Placenta Increta or Percreta": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.388'
valueset "Placenta Previa": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1110.78'
valueset "Placental Abruption": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.305'
valueset "Placental Accreta Spectrum": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.302'
valueset "Preexisting Diabetes": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.275'
valueset "Present on Admission is No or Unable To Determine": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.370'
valueset "Present On Admission is Yes or Exempt": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1110.63'
valueset "Preterm Birth": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.299'
valueset "Previous Cesarean": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.278'
valueset "Puerperal Cerebrovascular Disorder": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.229'
valueset "Pulmonary Edema": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.231'
valueset "Pulmonary Hypertension": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.281'
valueset "Race": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.114222.4.11.836'
valueset "Renal Disease": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.335'
valueset "Respiratory Conditions Related to COVID 19": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.376'
valueset "Respiratory Support Procedures Related to COVID 19": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.379'
valueset "Sepsis": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.237'
valueset "Severe Anesthesia Complications": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.235'
valueset "Severe Maternal Morbidity Diagnoses": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.255'
valueset "Severe Maternal Morbidity Procedures": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.256'
valueset "Severe Preeclampsia": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.327'
valueset "Shock": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.239'
valueset "Sickle Cell Disease with Crisis": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.241'
valueset "Substance Abuse": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.320'
valueset "Thyrotoxicosis": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.296'
valueset "Tracheostomy": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.359'
valueset "Venous Thromboembolism in Pregnancy": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.363'
valueset "Ventilation": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.360'
valueset "White blood cells count lab test": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1045.129'

parameter "Measurement Period" Interval<DateTime>

context Patient

define "Initial Population":
  PCMaternal."Delivery Encounter with Age Range"

define "SDE Ethnicity":
  SDE."SDE Ethnicity"

define "SDE Payer":
  SDE."SDE Payer"

define "SDE Race":
  SDE."SDE Race"

define "SDE Sex":
  SDE."SDE Sex"

define "SDE Delivery Encounters with Severe Obstetric Complication Diagnosis":
  ( "Delivery Encounters with Severe Obstetric Complications"
    except "SOC with Hysterectomy or Blood Transfusion with Placenta Increta or Placenta Percreta Without Additional SOC" ) Encounter
    where Encounter.pOAIsNoOrUTD ( ) in "Severe Maternal Morbidity Diagnoses"

define "SDE Delivery Encounters with Severe Obstetric Complication Procedures":
  ( "Delivery Encounters with Severe Obstetric Complications"
    except "SOC with Hysterectomy or Blood Transfusion with Placenta Increta or Placenta Percreta Without Additional SOC" ) Encounter
    where exists ( ["Procedure": "Severe Maternal Morbidity Procedures"]
      union ["Procedure": "Blood Transfusion"] ) SMMProcedures
      where SMMProcedures.status = 'completed'
        and SMMProcedures.performed.toInterval ( ) starts during day of Encounter.hospitalizationWithEDOBTriageObservation ( )

define "SDE SOC Diagnoses Detail":
  "SDE Delivery Encounters with Severe Obstetric Complication Diagnosis" Encounter
    let complication: Encounter.pOAIsNoOrUTD ( )
    return {
      id: Encounter.id,
	  //  code: Encounter.type,
      
      complications: complication C
        where C in "Severe Maternal Morbidity Diagnoses"
        return {
          code: C,
          SOCDxCategory: C.sOCDxCategory ( )
        }
    }

define "SDE SOC Procedure Detail":
  "SDE Delivery Encounters with Severe Obstetric Complication Procedures" Encounter
    let procedure: Encounter.sOCProcedures ( )
    return {
      id: Encounter.id,
 //   code: Encounter.code,
      
      procedures: procedure P
        return {
          code: P,
          SOCProcedureCategory: P.sOCProcedureCategory ( )
        }
    }

define "SOC with Hysterectomy or Blood Transfusion with Placenta Increta or Placenta Percreta Without Additional SOC":
  ( "Delivery Encounters with Severe Obstetric Complications" SOCEncounter
      where exists ( ( SOCEncounter.encounterDiagnosis ( ) ) EncounterDiagnosis
          where EncounterDiagnosis.code in "Placenta Increta or Percreta"
      )
        and ( exists "Delivery Encounters with Blood Transfusion"
            or exists "Delivery Encounters with Hysterectomy"
        )
  )
	//The following logic keeps encounter in the numerator if there is an additional SOC besides Blood Transfusion or Hysterectomy
    
    except ( ( "Delivery Encounters with Severe Obstetric Complications" SOCEncounter
          where ( SOCEncounter.pOAIsNoOrUTD ( ) in "Severe Maternal Morbidity Diagnoses" )
      )
        union "Delivery Encounters with Cardiac Conversion, Tracheostomy or Ventilation Procedures"
        union "Delivery Encounters with Expiration"
    )

define "Stratification Encounter":
  "Numerator"
    except "Denominator Exclusion"

define "Denominator Exclusion":
  "Delivery Encounters with COVID and Respiratory Condition or Procedure"

define "Stratum 1":
  //This logic identifies a subset of the numerator population with severe obstetric complications excluding cases where transfusion was the only severe obstetric complication.
  
  "Stratification Encounter"
    intersect "Delivery Encounters with Severe Obstetric Complications Excluding Blood Transfusions"

define "Delivery Encounters with Severe Obstetric Complications Excluding Blood Transfusions":
  "Delivery Encounters with Severe Obstetric Complications Diagnosis or Procedure Excluding Blood Transfusion"
    union "Delivery Encounters with Expiration"

define "Numerator":
  "Delivery Encounters with Severe Obstetric Complications"

define "Delivery Encounters with Calculated Gestational Age Greater than or Equal to 20 Weeks":
  PCMaternal."Delivery Encounter with Age Range" DeliveryEncounter
    where DeliveryEncounter.calculatedGestationalAge ( ) >= 20

define "Delivery Encounters with Estimated Gestational Age Assessment Greater than or Equal to 20 Weeks":
  PCMaternal."Delivery Encounter with Age Range" DeliveryEncounter
    where DeliveryEncounter.calculatedGestationalAge ( ) is null
      and ( DeliveryEncounter.lastEstimatedGestationalAge ( ) >= 20 weeks )

define "SDE Variable Calculated Gestational Age":
  //This definition establishes a variable of CGA (Calculated Gestational Age).  CGA is a supplemental data element to store the calculated gestational age result from the "CalculatedGestationalAge" function.  The data element enables the capturing and saving of the CGA for data analysis post data receipt. Hospitals do not need to submit any additional data to comply with this definition. 
  
  PCMaternal."Variable Calculated Gestational Age"

define "Cardiac Conversion, Tracheostomy or Ventilation Procedures":
  ["Procedure": "Conversion of Cardiac Rhythm"]
    union ["Procedure": "Tracheostomy"]
    union ["Procedure": "Ventilation"]

define "Delivery Encounters with Cardiac Conversion, Tracheostomy or Ventilation Procedures":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    with "Cardiac Conversion, Tracheostomy or Ventilation Procedures" ConvTrachVentProcedures
      such that ConvTrachVentProcedures.status = 'completed'
        and ConvTrachVentProcedures.performed.toInterval ( ) starts during day of TwentyWeeksPlusEncounter.hospitalizationWithEDOBTriageObservation ( )

define "Denominator":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation"

define "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation":
  "Delivery Encounters with Calculated Gestational Age Greater than or Equal to 20 Weeks"
    union "Delivery Encounters with Estimated Gestational Age Assessment Greater than or Equal to 20 Weeks"
    union "Delivery Encounters with Gestational Age Greater than or Equal to 20 Weeks Based on Coding"

define "Delivery Encounters with Hysterectomy":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    with ["Procedure": "Hysterectomy"] Hysterectomy
      such that Hysterectomy.status = 'completed'
        and Hysterectomy.performed.toInterval ( ) starts during day of TwentyWeeksPlusEncounter.hospitalizationWithEDOBTriageObservation ( )

define "Delivery Encounters with Expiration":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where TwentyWeeksPlusEncounter.hospitalization.dischargeDisposition in "Patient Expired"

define "Delivery Encounters with Gestational Age Greater than or Equal to 20 Weeks Based on Coding":
  PCMaternal."Delivery Encounter with Age Range" DeliveryEncounter
    let CGA: DeliveryEncounter.calculatedGestationalAge ( ),
    EGA: DeliveryEncounter.lastEstimatedGestationalAge ( )
    where CGA is null
      and EGA is null
      and exists ( ( DeliveryEncounter.encounterDiagnosis ( ) ) EncounterDiagnosis
          where EncounterDiagnosis.code in "20 to 42 Plus Weeks Gestation"
      )

define "Delivery Encounters with Severe Obstetric Complications":
  "Delivery Encounters with Severe Obstetric Complications Diagnosis or Procedure Excluding Blood Transfusion"
    union "Delivery Encounters with Expiration"
    union "Delivery Encounters with Blood Transfusion"

define "Delivery Encounters with Severe Obstetric Complications Diagnosis or Procedure Excluding Blood Transfusion":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where TwentyWeeksPlusEncounter.pOAIsNoOrUTD ( ) in "Severe Maternal Morbidity Diagnoses"
      or exists ( ["Procedure": "Severe Maternal Morbidity Procedures"] SMMProcedures
          where SMMProcedures.status = 'completed'
            and SMMProcedures.performed.toInterval ( ) starts during day of TwentyWeeksPlusEncounter.hospitalizationWithEDOBTriageObservation ( )
      )

define "Delivery Encounters with Severe Obstetric Complications Excluding Blood Transfusions Only":
  "Delivery Encounters with Severe Obstetric Complications"
    intersect "Delivery Encounters with Severe Obstetric Complications Excluding Blood Transfusions"

define "Delivery Encounters with COVID and Respiratory Condition or Procedure":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where exists ( ( TwentyWeeksPlusEncounter.encounterDiagnosis ( ) ) EncounterDiagnosis
        where EncounterDiagnosis.code in "COVID 19 Confirmed"
    )
      and ( exists ( ( TwentyWeeksPlusEncounter.encounterDiagnosis ( ) ) EncounterDiagnosis
            where EncounterDiagnosis.code in "Respiratory Conditions Related to COVID 19"
        )
          or exists ( ["Procedure": "Respiratory Support Procedures Related to COVID 19"] COVIDRespiratoryProcedure
              where COVIDRespiratoryProcedure.status = 'completed'
                and COVIDRespiratoryProcedure.performed.toInterval ( ) starts during day of TwentyWeeksPlusEncounter.hospitalizationWithEDOBTriageObservation ( )
          )
      )

define "SOC Excluding Blood Transfusions Only with Hysterectomy or Blood Transfusion with Placenta Increta or Placenta Percreta Without Additional SOC":
  ( "Delivery Encounters with Severe Obstetric Complications Excluding Blood Transfusions Only" SOCExcludingTransfusion
      where exists ( ( SOCExcludingTransfusion.encounterDiagnosis ( ) ) EncounterDiagnoses
          where EncounterDiagnoses.code in "Placenta Increta or Percreta"
      )
        and ( exists "Delivery Encounters with Blood Transfusion"
            or exists "Delivery Encounters with Hysterectomy"
        )
  )
	
	//The following logic keeps encounter in the numerator if there is an additional SOC besides Blood Transfusion or Hysterectomy
    
    except ( ( "Delivery Encounters with Severe Obstetric Complications Excluding Blood Transfusions Only" SOCExcludingTransfusion
          where SOCExcludingTransfusion.pOAIsNoOrUTD ( ) in "Severe Maternal Morbidity Diagnoses"
      )
        union "Delivery Encounters with Cardiac Conversion, Tracheostomy or Ventilation Procedures"
        union "Delivery Encounters with Expiration"
    )

define "Risk Variable Anemia":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where TwentyWeeksPlusEncounter.pOAIsYesOrExempt ( ) in "Anemia"

define "Risk Variable Asthma":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where TwentyWeeksPlusEncounter.pOAIsYesOrExempt ( ) in "Acute or Persistent Asthma"

define "Risk Variable Autoimmune Disease":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where TwentyWeeksPlusEncounter.pOAIsYesOrExempt ( ) in "Autoimmune Disease"

define "Risk Variable Bariatric Surgery":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where TwentyWeeksPlusEncounter.pOAIsYesOrExempt ( ) in "Bariatric Surgery"

define "Risk Variable Bleeding Disorder":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where TwentyWeeksPlusEncounter.pOAIsYesOrExempt ( ) in "Bleeding Disorder"

define "Risk Variable Morbid Obesity":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where TwentyWeeksPlusEncounter.pOAIsYesOrExempt ( ) in "Morbid or Severe Obesity"

define "Risk Variable Cardiac Disease":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where TwentyWeeksPlusEncounter.pOAIsYesOrExempt ( ) in "Cardiac Disease"

define "Risk Variable Economic Housing Instability":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where TwentyWeeksPlusEncounter.pOAIsYesOrExempt ( ) in "Economic Housing Instability"

define "Risk Variable Gastrointestinal Disease":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where TwentyWeeksPlusEncounter.pOAIsYesOrExempt ( ) in "Gastrointestinal Disease"

define "Risk Variable Gestational Diabetes":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where TwentyWeeksPlusEncounter.pOAIsYesOrExempt ( ) in "Gestational Diabetes"

define "Risk Variable HIV":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where TwentyWeeksPlusEncounter.pOAIsYesOrExempt ( ) in "HIV in Pregnancy Childbirth and Puerperium"

define "Risk Variable Hypertension":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where TwentyWeeksPlusEncounter.pOAIsYesOrExempt ( ) in "Hypertension"

define "Risk Variable Long Term Anticoagulant Use":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where TwentyWeeksPlusEncounter.pOAIsYesOrExempt ( ) in "Long Term Anticoagulant Use"

define "Risk Variable Maternal Age":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    let MaternalAge: AgeInYearsAt(date from start of TwentyWeeksPlusEncounter.period)
    return { TwentyWeeksPlusEncounter, MaternalAge }

define "Risk Variable Mental Health Disorder":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where TwentyWeeksPlusEncounter.pOAIsYesOrExempt ( ) in "Mental Health Disorder"

define "Risk Variable Multiple Pregnancy":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where TwentyWeeksPlusEncounter.pOAIsYesOrExempt ( ) in "Multiple Pregnancy"

define "Risk Variable Neuromuscular":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where TwentyWeeksPlusEncounter.pOAIsYesOrExempt ( ) in "Neuromuscular Disease"

define "Risk Variable Obstetrical VTE":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where TwentyWeeksPlusEncounter.pOAIsYesOrExempt ( ) in "Venous Thromboembolism in Pregnancy"

define "Risk Variable Placenta Previa":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where TwentyWeeksPlusEncounter.pOAIsYesOrExempt ( ) in "Placenta Previa"

define "Risk Variable Placental Abruption":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where TwentyWeeksPlusEncounter.pOAIsYesOrExempt ( ) in "Placental Abruption"

define "Risk Variable Placental Accreta Spectrum":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where TwentyWeeksPlusEncounter.pOAIsYesOrExempt ( ) in "Placenta Accreta"
      or TwentyWeeksPlusEncounter.pOAIsYesOrExempt ( ) in "Placenta Increta or Percreta"

define "Risk Variable Preexisting Diabetes":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where TwentyWeeksPlusEncounter.pOAIsYesOrExempt ( ) in "Preexisting Diabetes"

define "Risk Variable Previous Cesarean":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where TwentyWeeksPlusEncounter.pOAIsYesOrExempt ( ) in "Previous Cesarean"

define "Risk Variable Pulmonary Hypertension":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where TwentyWeeksPlusEncounter.pOAIsYesOrExempt ( ) in "Pulmonary Hypertension"

define "Risk Variable Renal Disease":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where TwentyWeeksPlusEncounter.pOAIsYesOrExempt ( ) in "Renal Disease"

define "Risk Variable Severe Preeclampsia":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where TwentyWeeksPlusEncounter.pOAIsYesOrExempt ( ) in "Severe Preeclampsia"

define "Risk Variable Substance Abuse":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where TwentyWeeksPlusEncounter.pOAIsYesOrExempt ( ) in "Substance Abuse"

define "Risk Variable Thyrotoxicosis":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where TwentyWeeksPlusEncounter.pOAIsYesOrExempt ( ) in "Thyrotoxicosis"

define "Risk Variable Other Preeclampsia":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where TwentyWeeksPlusEncounter.pOAIsYesOrExempt ( ) in "Mild or Moderate Preeclampsia"

define "Risk Variable Preterm Birth":
/*  CGA = Calculated Gestational Age.  EGA = Estimated Gestational Age. */
  
  ( PCMaternal."Delivery Encounter with Age Range" DeliveryEncounter
      let CGA: DeliveryEncounter.calculatedGestationalAge ( ),
      EGA: DeliveryEncounter.lastEstimatedGestationalAge ( )
      where CGA in Interval[20, 36]
        or ( CGA is null
            and ( EGA >= 20 weeks
                and EGA <= 36 weeks
            )
        )
  )
    union ( PCMaternal."Delivery Encounter with Age Range" DeliveryEncounter
        let CGA: DeliveryEncounter.calculatedGestationalAge ( ),
        EGA: DeliveryEncounter.lastEstimatedGestationalAge ( )
        where CGA is null
          and EGA is null
          and DeliveryEncounter.pOAIsYesOrExempt ( ) in "Preterm Birth"
    )

define "Delivery Encounters with Blood Transfusion":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    with ["Procedure": "Blood Transfusion"] BloodTransfusion
      such that BloodTransfusion.status = 'completed'
        and BloodTransfusion.performed.toInterval ( ) starts during day of TwentyWeeksPlusEncounter.hospitalizationWithEDOBTriageObservation ( )


 //First resulted value 24 hours prior to start of encounter and before time of delivery
 //Report hematocrit as %



define "Risk Variable First Hematocrit Lab Test":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    let FirstHematocrit: First(["USCoreLaboratoryResultObservationProfile": "Hematocrit lab test"] Hematocrit
        where Hematocrit.issued during Interval[start of TwentyWeeksPlusEncounter.hospitalizationWithEDOBTriageObservation() - 1440 minutes, TwentyWeeksPlusEncounter.lastTimeOfDelivery())
          and Hematocrit.status in { 'final', 'amended', 'corrected' }
          and Hematocrit.value is not null
        sort by issued.earliest()
    )
    return {
      EncounterId: TwentyWeeksPlusEncounter.id,
      FirstHematocritResult: FirstHematocrit.value as Quantity,
      Timing: FirstHematocrit.issued
    }


 //First resulted value 24 hours prior to start of encounter and before time of delivery
 //Report white blood cell count as 10*3/uL



define "Risk Variable First White Blood Cell Count Lab Test":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    let FirstWBC: First(["USCoreLaboratoryResultObservationProfile": "White blood cells count lab test"] WBC
        where WBC.issued during Interval[start of TwentyWeeksPlusEncounter.hospitalizationWithEDOBTriageObservation() - 1440 minutes, TwentyWeeksPlusEncounter.lastTimeOfDelivery())
          and WBC.status in { 'final', 'amended', 'corrected' }
          and WBC.value is not null
        sort by issued.earliest()
    )
    return {
      EncounterId: TwentyWeeksPlusEncounter.id,
      FirstWBCResult: FirstWBC.value as Quantity,
      Timing: FirstWBC.issued
    }



 //First resulted value 24 hours prior to start of encounter and before time of delivery
 //Report heart rate as beats/min
 //Heart rate value cannot be null per QICore profile requirement.




define "Risk Variable Heart Rate":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    let FirstHeartRate: First(["observation-heartrate"] HeartRate
        where HeartRate.effective.earliest() during Interval[start of TwentyWeeksPlusEncounter.hospitalizationWithEDOBTriageObservation() - 1440 minutes, TwentyWeeksPlusEncounter.lastTimeOfDelivery())
          and HeartRate.status in { 'final', 'amended', 'corrected' }
        sort by effective.earliest()
    )
    return {
      EncounterId: TwentyWeeksPlusEncounter.id,
      FirstHRResult: FirstHeartRate.value as Quantity,
      Timing: FirstHeartRate.effective.earliest ( )
    }
      
      
//First resulted value 24 hours prior to start of encounter and before time of delivery
//Report systolic blood pressure as mm[Hg]
//Systolic blood pressure value cannot be null per QICore profile requirement.




define "Risk Variable Systolic Blood Pressure":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    let FirstSystolicBP: First(["observation-bp"] BP
        where BP.effective.earliest() during Interval[start of TwentyWeeksPlusEncounter.hospitalizationWithEDOBTriageObservation() - 1440 minutes, TwentyWeeksPlusEncounter.lastTimeOfDelivery())
          and BP.status in { 'final', 'amended', 'corrected' }
          and BP.component.value is not null
        sort by effective.earliest()
    )
    return {
      EncounterId: TwentyWeeksPlusEncounter.id,
      FirstSBPResult: FirstSystolicBP.component C
        where C.code ~ "Systolic blood pressure"
        return C.value as Quantity,
      Timing: FirstSystolicBP.effective.earliest ( )
    }
 
      
/*define function "FirstLabTestWithEncounterId"(LabList List<Observation>, CCDE String ):
     "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
  let FirstLab: First(LabList Lab
  //(first resulted value 24 hours prior to start of encounter and before time of delivery)
      where Lab.issued.earliest() during Interval[start of TwentyWeeksPlusEncounter.hospitalizationWithEDOBTriageObservation()- 1440 minutes, TwentyWeeksPlusEncounter.lastTimeOfDelivery()) 
      and Lab.status in {'final', 'amended', 'corrected'}
      and Lab.value is not null
      sort by issued.earliest())
    return {
    EncounterId: TwentyWeeksPlusEncounter.id,
    FirstResult: FirstLab.value as Quantity,
    Timing: FirstLab.issued
  }

define function "FirstPhysicalExamWithEncounterId"(ExamList List<Observation>, CCDE String):
     "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
  let FirstExam: First(ExamList Exam
    where Exam.effective.earliest() during Interval[start of TwentyWeeksPlusEncounter.hospitalizationWithEDOBTriageObservation()- 1440 minutes, TwentyWeeksPlusEncounter.lastTimeOfDelivery()) 
    and Exam.status in {'final', 'amended', 'corrected'}
    and Exam.value is not null
    sort by effective.earliest() )
       return {
    EncounterId: TwentyWeeksPlusEncounter.id,
    FirstResult: FirstExam.value as Quantity,
    Timing: FirstExam.effective.earliest()
  }
  
define "Risk Variable Lab and Physical Exam Results":
  flatten{
     // First physical exams (vital signs):  Report heart rate as {beats}/min, systolic blood pressure as mm[Hg]
          "FirstPhysicalExamWithEncounterId"([Observation: "Heart rate"], 'FirstHeartRate'),
          "FirstPhysicalExamWithEncounterId"([Observation: "Systolic blood pressure"], 'FirstSystolicBP'),
     //First lab tests:  Report hematocrit as %, white blood cell count as 10*3/uL
          "FirstLabTestWithEncounterId"([Observation: "Hematocrit lab test"], 'FirstHematocrit'),
          "FirstLabTestWithEncounterId"([Observation: "White blood cells count lab test"], 'FirstWhiteBloodCell') 
    }*/


define fluent function pOAIsNoOrUTD(TheEncounter Encounter):
  TheEncounter.diagnosis EncounterDiagnoses
    where EncounterDiagnoses.diagnosisPresentOnAdmission in "Present on Admission is No or Unable To Determine"
    return EncounterDiagnoses.condition.getCondition ( ).code

define fluent function pOAIsYesOrExempt(TheEncounter Encounter):
  TheEncounter.diagnosis EncounterDiagnoses
    where EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission is Yes or Exempt"
    return EncounterDiagnoses.condition.getCondition ( ).code

define fluent function sOCDxCategory(Dx Concept):
  case
    when Dx in "Acute Heart Failure" then 'Acute Heart Failure'
    when Dx in "Acute Myocardial Infarction" then 'Acute Myocardial Infarction'
    when Dx in "Acute Renal Failure" then 'Acute Renal Failure'
    when Dx in "Acute Respiratory Distress Syndrome" then 'Acute Respiratory Distress Syndrome'
    when Dx in "Air and Thrombotic Embolism" then 'Air and Thrombotic Embolism'
    when Dx in "Amniotic Fluid Embolism" then 'Amniotic Fluid Embolism'
    when Dx in "Aortic Aneurysm" then 'Aortic Aneurysm'
    when Dx in "Cardiac Arrest Ventricular Fibrillation" then 'Cardiac Arrest Ventricular Fibrillation'
    when Dx in "Disseminated Intravascular Coagulation" then 'Disseminated Intravascular Coagulation'
    when Dx in "Eclampsia" then 'Eclampsia'
    when Dx in "Heart Failure Cardiac Arrest Related to Procedure or Surgery" then 'Heart Failure Cardiac Arrest Related to Procedure or Surgery'
    when Dx in "Puerperal Cerebrovascular Disorder" then 'Puerperal Cerebrovascular Disorder'
    when Dx in "Pulmonary Edema" then 'Pulmonary Edema'
    when Dx in "Sepsis" then 'Sepsis'
    when Dx in "Severe Anesthesia Complications" then 'Severe Anesthesia Complications'
    when Dx in "Shock" then 'Shock'
    when Dx in "Sickle Cell Disease with Crisis" then 'Sickle Cell Disease with Crisis' 
    else null end

define fluent function sOCProcedureCategory(TheProcedure Procedure):
  case
    when TheProcedure.code in "Blood Transfusion" then 'Blood Transfusion'
    when TheProcedure.code in "Conversion of Cardiac Rhythm" then 'Conversion of cardiac rhythm'
    when TheProcedure.code in "Hysterectomy" then 'Hysterectomy'
    when TheProcedure.code in "Tracheostomy" then 'Tracheostomy'
    when TheProcedure.code in "Ventilation" then 'Ventilation' 
    else null end

define fluent function sOCProcedures(TheEncounter Encounter):
  ( ["Procedure": "Severe Maternal Morbidity Procedures"]
    union ["Procedure": "Blood Transfusion"] ) SMMProcedures
    where SMMProcedures.status = 'completed'
      and SMMProcedures.performed.toInterval ( ) starts during day of TheEncounter.hospitalizationWithEDOBTriageObservation ( )