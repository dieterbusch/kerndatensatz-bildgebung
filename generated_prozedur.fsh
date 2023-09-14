Alias: $ProzedurDokumentationsdatum = http://fhir.de/StructureDefinition/ProzedurDokumentationsdatum
Alias: $Durchfuehrungsabsicht = https://www.medizininformatik-initiative.de/fhir/core/modul-prozedur/StructureDefinition/Durchfuehrungsabsicht
Alias: $CodingOPS = http://fhir.de/StructureDefinition/CodingOPS
Alias: $MII-Reference = https://www.medizininformatik-initiative.de/fhir/core/StructureDefinition/MII-Reference
Alias: $procedures-category-sct = https://www.medizininformatik-initiative.de/fhir/core/modul-prozedur/ValueSet/procedures-category-sct
Alias: $ops = http://fhir.de/ValueSet/bfarm/ops
Alias: $procedures-sct = https://www.medizininformatik-initiative.de/fhir/core/modul-prozedur/ValueSet/procedures-sct

Profile: SD_MII_Prozedur_Procedure
Parent: Procedure
Id: sd-mii-prozedur-procedure
Title: "SD MII Prozedur Procedure"
Description: "Dieses Profil beschreibt eine Prozedur in der Medizininformatik-Initiative."
* ^url = "https://www.medizininformatik-initiative.de/fhir/core/modul-prozedur/StructureDefinition/Procedure"
* ^version = "2.0.0-ballot"
* ^status = #active
* obeys proc-mii-1
// WARNING: The constraint index in the following rule (e.g., constraint[0]) may be incorrect.
// Please compare with the constraint array in the original definition's snapshot and adjust as necessary.
* . ^constraint.source = "https://www.medizininformatik-initiative.de/fhir/core/StructureDefinition/Procedure"
* id MS
* meta MS
* meta.source MS
* meta.profile MS
* extension MS
* extension ^slicing.discriminator.type = #value
* extension ^slicing.discriminator.path = "url"
* extension ^slicing.rules = #open
* extension contains
    $ProzedurDokumentationsdatum named Dokumentationsdatum 0..1 MS and
    $Durchfuehrungsabsicht named durchfuehrungsabsicht 0..1 MS
* status MS
* category MS
* category.coding ^slicing.discriminator.type = #pattern
* category.coding ^slicing.discriminator.path = "$this"
* category.coding ^slicing.rules = #open
* category.coding ^min = 0
* category.coding contains sct 0..1 MS
* category.coding[sct] from $procedures-category-sct (preferred)
* category.coding[sct] ^patternCoding.system = "http://snomed.info/sct"
* category.coding[sct].system 1.. MS
* category.coding[sct].code 1.. MS
* code 1.. MS
* code obeys sct-ops-1
// WARNING: The constraint index in the following rule (e.g., constraint[0]) may be incorrect.
// Please compare with the constraint array in the original definition's snapshot and adjust as necessary.
* code ^constraint.source = "https://www.medizininformatik-initiative.de/fhir/core/StructureDefinition/Procedure"
* code.coding 1.. MS
* code.coding ^slicing.discriminator.type = #pattern
* code.coding ^slicing.discriminator.path = "$this"
* code.coding ^slicing.rules = #open
* code.coding contains
    ops 0..1 MS and
    sct 0..1 MS
* code.coding[ops] only $CodingOPS
* code.coding[ops] from $ops (required)
* code.coding[ops].extension ^slicing.discriminator.type = #value
* code.coding[ops].extension ^slicing.discriminator.path = "url"
* code.coding[ops].extension ^slicing.rules = #open
* code.coding[ops].extension[Seitenlokalisation] ^sliceName = "Seitenlokalisation"
* code.coding[ops].extension[Seitenlokalisation] ^mustSupport = true
* code.coding[ops].system MS
* code.coding[ops].version MS
* code.coding[ops].code MS
* code.coding[sct] from $procedures-sct (required)
* code.coding[sct].system 1.. MS
* code.coding[sct].code 1.. MS
* subject 1..1 MS
* subject only $MII-Reference
* performed[x] 1.. MS
* performed[x] only dateTime or Period
* bodySite MS
* bodySite ^binding.extension.url = "http://hl7.org/fhir/StructureDefinition/elementdefinition-bindingName"
* bodySite ^binding.extension.valueString = "BodySite"
* bodySite ^binding.strength = #extensible
* note MS

Invariant: proc-mii-1
Description: "Falls die Prozedur per OPS kodiert wird, muss eine SNOMED-CT kodierte Category abgebildet werden"
Severity: #error
Expression: "code.coding.where(system = 'http://fhir.de/CodeSystem/bfarm/ops').exists() implies category.coding.where(system = 'http://snomed.info/sct').exists()"

Invariant: sct-ops-1
Description: "Entweder wird die Prozedur mit OPS oder SNOMED-CT kodiert."
Severity: #error
Expression: "coding.where(system = 'http://snomed.info/sct').exists() or coding.where(system = 'http://fhir.de/CodeSystem/bfarm/ops').exists()"
