# Enzyme Active Site Catalysis & Substrate Recognition Multi-Biochemistry Observation

## Overview & Theoretical Foundation

Enzyme catalysis (Emil Fischer 1894 lock-and-key, Daniel Koshland 1958 induced fit) accelerates biochemical reactions by factors of $10^6$ to $10^{17}$.

In discrete geometry, substrate-active site molecular recognition is represented as **Boolean XOR bit complementarity** paired with a **ChargeGate coordinate lock**:
- **Active Site Complementarity**: Substrate bit $b_S$ matches enzyme binding pocket bit $b_E$ iff $b_S \oplus b_E = \text{One}$.
- **Coordinate Lock**: Substrate binds at exact $Q = 25$ ChargeGate² quadrance distance from catalytic residues.
- **Catalytic Transition**: Lowers reaction barrier by forming an intermediate enzyme-substrate substrate graph edge.

```
  ┌───────────────────────────┬──────────────────────────────────────┬──────────────────────────────────────────┐
  │ Biochemical System        │ Unbound Enzyme + Substrate           │ Catalytic Enzyme-Substrate Complex       │
  ├───────────────────────────┼──────────────────────────────────────┼──────────────────────────────────────────┤
  │ 1. Boole                  │ Active site bit = One, Substrate = Zero│ Complementary pair XOR b_S ⊕ b_E = One │
  │ 2. Chromogeometry         │ Distance Q > 25 (unbound)            │ Active site lock Q = 25 (bound)          │
  │ 3. Substrate              │ Disjoint enzyme & substrate DAGs     │ Joined ES complex edge (substrateLag = 1)│
  │ 4. Trigonometry           │ Unconstrained substrate spread       │ Induced-fit transition spread s = 1/2    │
  └───────────────────────────┴──────────────────────────────────────┴──────────────────────────────────────────┘
```

---

## Executable Literate Idris2 Observation Code

```idris
module Wiki.Observations.EnzymeCatalysis

import Geometry.Interface
import Geometry.CompositeCoord
import Geometry.ChromoBackend
import Geometry.DihedronBackend
import Geometry.SubstrateBackend
import Geometry.BooleBackend
import Geometry.ToroidalBackend
import Geometry.TrigonometryBackend

import Substrate.Core
import Math.Vexel.Vexel
import Math.Singleton.Sing
import Math.Pixel
import Math.BoxInt
import Math.Fraction
import Math.Multiset
import Math.Singleton.Bit
import Data.Nat
import QuickCheck

%default total

-----------------------------------------------------------------------
-- 1. ENZYME CATALYSIS STATE DEFINITIONS
-----------------------------------------------------------------------

||| Enzyme active site and substrate complex state.
public export
record EnzymeComplexState where
  constructor MkEnzymeComplex
  activeSiteBit  : Bit              -- Active site binding pocket bit
  substrateBit   : Bit              -- Substrate key bit
  bindingQ       : Nat              -- Distance quadrance to active site (Q = 25 bound)
  esSubstrate    : Substrate        -- Enzyme-Substrate complex DAG graph

-----------------------------------------------------------------------
-- 2. CANONICAL STATES & CATALYTIC BINDING
-----------------------------------------------------------------------

||| Unbound enzyme and substrate.
public export
canonicalUnboundEnzyme : EnzymeComplexState
canonicalUnboundEnzyme =
  let eBit = One
      sBit = Zero
      qFar = 100
  in MkEnzymeComplex eBit sBit qFar emptySubstrate

||| Binds substrate to active site: forms induced-fit ES complex.
public export
bindEnzymeSubstrate : EnzymeComplexState -> EnzymeComplexState
bindEnzymeSubstrate unbound =
  let p1Nat : Pixel Blue Nat = MkPixel 0 0
      p2Nat : Pixel Blue Nat = MkPixel 4 3
      p1Box : Geometry = MkPixel 0 0
      p2Box : Geometry = MkPixel 4 3
      qBound = quadrance p1Nat p2Nat                  -- Q = 25 ChargeGate² lock
      esEdge = singleEdge p1Box p2Box                  -- Catalytic ES bond edge
  in MkEnzymeComplex unbound.activeSiteBit unbound.substrateBit qBound esEdge

-----------------------------------------------------------------------
-- 3. VERIFIED ENZYME CATALYSIS INVARIANT PROPERTIES
-----------------------------------------------------------------------

||| Property 1: Substrate recognition is Boolean XOR complementary (eBit ⊕ sBit = One).
public export
prop_activeSiteXORComplementary : EnzymeComplexState -> Bool
prop_activeSiteXORComplementary es =
  isOne (addBit es.activeSiteBit es.substrateBit)

||| Property 2: Bound ES complex locks at exact Q = 25 ChargeGate² quadrance.
public export
prop_esComplexLocksAtQ25 : EnzymeComplexState -> Bool
prop_esComplexLocksAtQ25 unbound =
  let bound = bindEnzymeSubstrate unbound
  in bound.bindingQ == 25

||| Property 3: ES complex forms 1 catalytic substrate edge (substrateLag = 1).
public export
prop_esComplexFormsSubstrateEdge : EnzymeComplexState -> Bool
prop_esComplexFormsSubstrateEdge unbound =
  let bound = bindEnzymeSubstrate unbound
  in substrateLag bound.esSubstrate == 1

-----------------------------------------------------------------------
-- 4. SUITE EXECUTION
-----------------------------------------------------------------------

||| Runs complete Enzyme Catalysis Observation Suite.
public export
runEnzymeCatalysisSuite : Bool
runEnzymeCatalysisSuite =
  let unbound = canonicalUnboundEnzyme
  in prop_activeSiteXORComplementary unbound &&
     prop_esComplexLocksAtQ25 unbound &&
     prop_esComplexFormsSubstrateEdge unbound
```
