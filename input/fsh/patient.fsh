// Aliases
Alias: $ACSMS = http://example.org/CodeSystem/additional-codesystem-for-marital-status //Additional Code System Marital Status
Alias: $AVSMS = http://example.org/CodeSystem/additional-codes-for-marital-status //Additional Valueset Marital Status

// Defino nuevo value set
ValueSet: AdditionalCodesForMaritalStatus
Id: additional-codes-for-marital-status
Title: "Additional valueset for marital status"
Description: "Extensión de Value Set Codes de estados civiles"

* include codes from system http://hl7.org/fhir/ValueSet/marital-status
//* include codes from system AdditionalCodeSystemForMaritalStatus // equivalente al alias usado abajo
* include codes from system $ACSMS

// Defino nuevo codesystem para estado civil (extend)
CodeSystem: AdditionalCodeSystemForMaritalStatus
Id: additional-codesystem-for-marital-status
Title: "Additional codesystem for marital status"
Description: "Test para extender los code de estados civiles"

* ^status = #active
* ^date = "2025-05-06"

* #ghosting "Ghosting" "Cuando alguien corta contacto con vos sin dar una explicación"

* #zombieing "Zombieing" "Cuando una persona te hizo ghosting y vuelve a aparecer"

* #situationship "Situationship" "Una relación romántica no oficializada como noviazgo"


// Declaration (del Artifact)
Profile:      PatientProfile

// Metadata (sobre el Artifact)
Parent:       Patient
Id:           patient-profile
Title:        "Patient Profile"
Description:  "Perfil de ejemplo basado en el recurso Patient para guía de implementación."

// Rules (a cumplir en las instancias)

* identifier 1.. MS
//* identifier.system 1.. MS
//* identifier.value 1.. MS // equivalente a la forma definida abajo
  * system 1.. MS
  * value 1.. MS

* name 1..1 MS
  * given 1..1 MS
  * family 1..1 MS

* telecom // puede o no tener
  * system 1.. MS
  * value 1.. MS

* active 0..1  MS

* maritalStatus 1.. MS
// * maritalStatus from AdditionalCodesForMaritalStatus (extensible) // equivalente al alias usado abajo
* maritalStatus from $AVSMS (extensible)


* deceased[x] only boolean // en la doc de fhir podia ser compuesto por boolean y la fecha, acá se limita a que solo sea bool
* deceased[x] 1.. MS

* gender 1..1 MS
* birthDate 1..1 MS
* address 0..* MS
* address.city 1..1 MS
* address.country = "AR"



// ----------
// Patient example
Instance: GastonMuzas
InstanceOf: PatientProfile
Usage: #example

* birthDate = 1992-08-23

* gender = #male // cuando es CODE se usa #

* identifier.system = "DNI"
* identifier.value = "36871371"

* name.family = "Muzas"
* name.given = "Gastón"

* deceasedBoolean = false

* telecom.system = #email
* telecom.value = "gastonmuzas@gmail.com"

* maritalStatus.coding
  * system = "http://example.org/CodeSystem/additional-codesystem-for-marital-status"
  * code = #ghosting

// codigos
// CodeSystem (SNOMED-CT, RxNorm, ICD-10, ...) -> generalmente externos

// lista de valores válidos, que pueden venir de uno o más CodeSystem
// ValueSet (Ethnicity, Antibiotics, ...)

// mapeos entre terminologías (cómo se relacionan los códigos de un sistema con otro)
// ConceptMaps (ICD-10 to SNOMED-CT, NDC to RxNorm, ...)

// $ -> comienzo de un alias
// # -> valor de un code