
Alias: $CodingOPS = http://fhir.de/StructureDefinition/CodingOPS
Alias: $ops = http://fhir.de/ValueSet/bfarm/ops

Profile: MII_PR_ImagingStudy_ImagingStudy
Parent: ImagingStudy
Id: mii-pr-imagingstudy-imagingstudy
Title: "MII PR ImagingStudy ImagingStudy"
Description: "Dieses Profil beschreibt die Medikation, die angesetzt, geplant oder verabreicht wird. Es kann sich um ein Fertigarzneimittel oder eine Rezeptur handeln. Auch die Angabe nur des Wirkstoffes ist möglich. Die Angabe mindestens eines Wirkstoffes wird verlangt."
* ^url = "https://www.medizininformatik-initiative.de/fhir/ext/modul-bildgebung/StructureDefinition/ImagingStudy"
* insert Translation(^name, en-US, MII_PR_Medikation_Medication)
* insert Translation(^title, en-US, MII PR Medikation Medication)
* insert Translation(^description, en-US, The profile describes a prepackaged drug or formulation.)
* insert PR_CS_VS_Version




* procedureCode ^constraint.source = "https://www.medizininformatik-initiative.de/fhir/core/StructureDefinition/ImagingStudy"
* procedureCode.coding 1.. MS
* procedureCode.coding ^slicing.discriminator.type = #pattern
* procedureCode.coding ^slicing.discriminator.path = "$this"
* procedureCode.coding ^slicing.rules = #open
* procedureCode.coding contains
    ops 0..1 MS and
    sct 0..1 MS
* code.coding[ops] only $CodingOPS
* code.coding[ops] from $ops (required)


* reasonReference only Reference(Condition or Observation or DiagnosticReport or DocumentReference)
* endpoint 1..1
* basedOn only Reference(CarePlan or ServiceRequest or Appointment)
