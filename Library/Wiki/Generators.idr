module Wiki.Generators

import public QuickCheck
import Compound.MolecularBonding
import Compound.ChemistryScaleTransforms
import Core.BoxInt

%default total

public export
natToElement : Nat -> Element
natToElement 0 = Hydrogen
natToElement 1 = Carbon
natToElement 2 = Nitrogen
natToElement _ = Oxygen

public export
Arbitrary Element where
  arbitrary = map natToElement arbitrary

  coarbitrary Hydrogen gen = coarbitrary (the Nat 0) gen
  coarbitrary Carbon   gen = coarbitrary (the Nat 1) gen
  coarbitrary Nitrogen gen = coarbitrary (the Nat 2) gen
  coarbitrary Oxygen   gen = coarbitrary (the Nat 3) gen

public export
qc : (Arbitrary a, Show a, Testable prop) => (a -> prop) -> QCRes
qc f = quickCheck (MkFn f)

public export
qc2 : (Arbitrary a, Show a, Arbitrary b, Show b, Testable prop) => (a -> b -> prop) -> QCRes
qc2 f = quickCheck (MkFn (\x => MkFn (f x)))
