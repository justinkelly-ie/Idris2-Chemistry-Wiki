# 🧪 Chemistry ScaleTransform Specification

Documents and verifies the open `ScaleTransform` typeclass properties for Chemical Elements mapped to Atomic Numbers ($Z$).

```idris
module Wiki.ChemistryScaleTransformSpec

import Core.ScaleTransform
import Compound.MolecularBonding
import Compound.ChemistryScaleTransforms
import Wiki.Generators

%default total

||| Property 1: Element ScaleTransform Atomic Number Positivity (Z > 0)
public export
prop_elementAtomicNumberPositivity : Element -> Bool
prop_elementAtomicNumberPositivity el =
  let z : Nat = scaleTransform el
  in z > 0

||| Property 2: ScaleTransform Match with atomicNumber Function
public export
prop_elementScaleTransformMatch : Element -> Bool
prop_elementScaleTransformMatch el =
  let z : Nat = scaleTransform el
      iZ : Integer = cast {from=Nat} z
      iEmp : Integer = cast {from=Nat} (atomicNumber el)
  in iZ == iEmp

||| Property 3: ScaleTransform Reflects Element Distinctness
public export
prop_elementScaleTransformDistinctness : Element -> Element -> Bool
prop_elementScaleTransformDistinctness e1 e2 =
  let z1 : Nat = scaleTransform e1
      z2 : Nat = scaleTransform e2
      i1 : Integer = cast {from=Nat} z1
      i2 : Integer = cast {from=Nat} z2
      eEq = e1 == e2
      zEq = i1 == i2
  in eEq == zEq

||| QuickCheck execution runner for Chemistry ScaleTransform Spec
public export
auditChemistryScaleTransformSpecProof : IO Bool
auditChemistryScaleTransformSpecProof = do
  let r1 = qc prop_elementAtomicNumberPositivity
  let r2 = qc prop_elementScaleTransformMatch
  let r3 = qc2 prop_elementScaleTransformDistinctness
  pure (r1.pass == Just True && r2.pass == Just True && r3.pass == Just True)
```
