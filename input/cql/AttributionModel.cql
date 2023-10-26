library AttributionModel version '0.1.0'

using QICore version '4.1.1'

include FHIRHelpers version '4.3.000'

parameter "Measurement Period" Interval<DateTime> default Interval[@2023-01-01T00:00:00.0Z, @2023-12-31T23:59:59.999Z]
parameter "Provider" String

context Patient

define fluent function isAttributable(patient Patient):
  "Provider" is not null implies Patient.managingOrganization.reference.endsWith("Provider")

define fluent function isAttributable(encounter Encounter):
  encounter.period during "Measurement Period"
    and "Provider" is not null implies encounter.serviceProvider.reference.endsWith("Provider")



