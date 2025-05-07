// Aliases
Alias: $MyCs = http://example.org/CodeSystem/my-additional-codesystem-for-marital-status
Alias: $MyVs = http://example.org/CodeSystem/my-additional-codes-for-marital-status


// Defino nuevo value set
ValueSet: MyAdditionalCodesForMaritalStatus
Id: my-additional-codes-for-marital-status
Title: "My additional valueset for marital status"
Description: "Test para valueset en codes de estados civiles"

* include codes from system http://hl7.org/fhir/ValueSet/marital-status
//* include codes from system MyAdditionalCodeSystemForMaritalStatus // equivalente al alias usado abajo
* include codes from system $MyCs

// Defino nuevo codesystem para estado civil (extend)
CodeSystem: MyAdditionalCodeSystemForMaritalStatus
Id: my-additional-codesystem-for-marital-status
Title: "My additional codesystem for marital status"
Description: "Test para extender los code de estados civiles"

* ^status = #active
* ^date = "2025-05-06"

* #ghosting "Ghosting" "Cuando alguien corta contacto con vos sin dar una explicación"

* #zombieing "Zombieing" "Cuando una persona te hizo ghosting y vuelve a aparecer"

* #situationship "Situationship" "Una relación romántica no oficializada como noviazgo"


// Declaration (del Artifact)
Profile:      MyPatientProfile

// Metadata (sobre el Artifact)
Parent:       Patient
Id:           my-patient-profile
Title:        "My Patient Profile"
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
// * maritalStatus from MyAdditionalCodesForMaritalStatus (extensible) // equivalente al alias usado abajo
* maritalStatus from $MyVs (extensible)


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
InstanceOf: MyPatientProfile
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
  * system = "http://example.org/CodeSystem/my-additional-codesystem-for-marital-status"
  * code = #ghosting

// codigos
// CodeSystem (SNOMED-CT, RxNorm, ICD-10, ...) -> generalmente externos

// lista de valores válidos, que pueden venir de uno o más CodeSystem
// ValueSet (Ethnicity, Antibiotics, ...)

// mapeos entre terminologías (cómo se relacionan los códigos de un sistema con otro)
// ConceptMaps (ICD-10 to SNOMED-CT, NDC to RxNorm, ...)

// $ -> comienzo de un alias
// # -> valor de un code