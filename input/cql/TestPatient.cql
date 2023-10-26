library TestPatient

using USCore version '3.1.1'

include FHIRHelpers

context Patient

define TestPatient:
  Patient.name.given
