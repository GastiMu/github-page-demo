Alias: $hrr = http://www.intersystems.com/hrr
Alias: $ct = http://terminology.hl7.org/CodeSystem/observation-category
Alias: $sct = http://snomed.info/sct

//---------------------------------------------------------------

ValueSet: HeartRateRecovery
Id: heart-rate-recovery
Title: "HeartRateRecovery"
Description: "Códigos para recuperación de frecuencia cardíaca"

* include codes from system $hrr
* $hrr#001 "Heart Rate Recovery after 10 seconds"
* $hrr#002 "Heart Rate Recovery after Exercise 20 seconds"
* $hrr#003 "Heart Rate Recovery after Exercise 30 seconds"
* $hrr#004 "Heart Rate Recovery after 40 Exercise seconds"
* $hrr#005 "Heart Rate Recovery after 50 Exercise seconds"
* $hrr#006 "Heart Rate Recovery after 60 Exercise seconds"


//---------------------------------------------------------------

Profile:      HRRProfile
Parent:       Observation
Id:           hrr-fsh
Title:        "HRR Observation Profile"
Description:  "Tiempo de recuperación de frecuencia cardíaca"

* subject and category and value[x] MS
* subject only Reference(Patient)
* subject 1..1
* code from HeartRateRecovery (required)
* value[x] only Quantity

//---------------------------------------------------------------

Profile:      HrrProfile
Parent:       Observation
Id:           hrr-profile
Description:  "Perfil para registrar observación de recuperación de frecuencia cardíaca"

* subject and category and code and value[x] MS
* subject only Reference(Patient)
* subject 1..1
* code from HeartRateRecovery (required)
* value[x] only Quantity
* interpretation 1..1
* extension contains InterpretationCertainty named interpretationCert 0..1
* extension[interpretationCert].valueCodeableConcept from InterpretationConfidence (required)

// Es muy importante el orden. antes de la cardinalidad va el contains o da error al compilar
// * extension[interpretationCert] 0..1
// * extension contains InterpretationCertainty named interpretationCert
// * extension[interpretationCert].valueCodeableConcept from InterpretationConfidence (required)

//---------------------------------------------------------------

ValueSet: InterpretationConfidence
Id: interpretation-confidence
Title: "Interpretation Confidence Value Set"
Description: "Grado de confianza de que una condición está presente"

* $sct#415584804 "Suspected (qualifier value)"
* $sct#410592001 "Probably Present (qualifier value)"
* $sct#410535003 "Confirmed Present (qualifier value)"

//---------------------------------------------------------------

Extension: InterpretationCertainty
Id: interpretation-certainty
Title: "Interpretation Certainty"
Description: "Certeza de que interpretación es correcta"

* value[x] only CodeableConcept
* value[x] from InterpretationConfidence

//---------------------------------------------------------------

Instance: ThomasHeart
InstanceOf: Patient
* name.family = "Heart"
* name.given = "Thomas"

//---------------------------------------------------------------

Instance: HeartRateRecoveryExample
InstanceOf: HrrProfile
* subject = Reference(GastonMuzas)
* code = $hrr#001
* status = #final
* valueQuantity.value = 45
* valueQuantity.unit = "beats/min"
* interpretation = #abnormal
* extension[+].url = "http://hl7.org/fhir/StructureDefinition/interpretation-certainty"
* extension[=].valueCodeableConcept = $sct#410592001
