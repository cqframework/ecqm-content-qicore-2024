library TestMedicationNotRequested

using QICore version '4.1.1'

include FHIRHelpers version '4.3.000' called FHIRHelpers
include CQMCommon version '1.4.000' called CQMCommon
include QICoreCommon version '1.5.000' called QICoreCommon

valueset "Antithrombotic Therapy for Ischemic Stroke": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1110.62'
valueset "Medical Reason For Not Providing Treatment": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.473'
valueset "Patient Refusal": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.93'

parameter "Measurement Period" Interval<DateTime>
  default Interval[@2024-01-01T00:00:00.0, @2025-01-01T00:00:00.0)

context Patient

define PatientName: Patient.name.first().family // + ', ' + Combine(Patient.name.first().given, ' ')

define "Reason for Not Giving Antithrombotic at Discharge":
  ["MedicationNotRequested": "Antithrombotic Therapy for Ischemic Stroke"] NoAntithromboticDischarge
    where NoAntithromboticDischarge.reasonCode in "Medical Reason For Not Providing Treatment"

