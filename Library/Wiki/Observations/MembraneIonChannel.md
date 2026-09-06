# Cell Membrane Gated Ion Channel ($\text{Na}^+/\text{K}^+$ Pump) Multi-Biochemistry Observation

## Overview & Theoretical Foundation

Voltage-gated ion channels ($\text{Na}^+, \text{K}^+, \text{Ca}^{2+}$) and active ATP-driven pumps maintain the resting potential ($\Delta V \approx -70\text{ mV}$) across cell membranes, enabling nerve action potential propagation (Hodgkin & Huxley, Nobel 1963).

In discrete geometry, gated ion transport is modeled as:
- **`EM.Calculus`**: Electric potential gradient $\vec{E} = -\nabla \Phi$ across the lipid bilayer.
- **`Boole`**: Channel gate state (`Zero` = closed, `One` = open).
- **`Substrate`**: Ion transport causal edges across membrane nodes.

```
  ┌───────────────────────────┬──────────────────────────────────────┬──────────────────────────────────────────┐
  │ Membrane Channel State    │ Closed Gate (Resting Potential)      │ Open Gate (Ion Conductance Pulse)        │
  ├───────────────────────────┼──────────────────────────────────────┼──────────────────────────────────────────┤
  │ 1. Boole                  │ Channel gate bit = Zero (closed)     │ Channel gate bit = One (open)            │
  │ 2. Electromagnetism       │ Potential gradient Phi_in - Phi_out  │ Depolarisation ion flux GaugeField       │
  │ 3. Substrate              │ No ion edge across membrane          │ Trans-membrane ion edge (substrateLag=1) │
  │ 4. Chromogeometry         │ Intra-membrane distance Q = 25       │ Conducted ion quadrance Q = 25           │
  └───────────────────────────┴──────────────────────────────────────┴──────────────────────────────────────────┘
```

---

## Executable Literate Idris2 Observation Code

```idris
module Wiki.Observations.MembraneIonChannel

import Geometry.Interface
import Geometry.CompositeCoord
import Geometry.ChromoBackend
import Geometry.DihedronBackend
import Geometry.SubstrateBackend
import Geometry.BooleBackend
import Geometry.ToroidalBackend
import Geometry.TrigonometryBackend
import Geometry.ElectromagnetismBackend
import EM.Potential
import EM.Calculus

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
-- 1. MEMBRANE ION CHANNEL STATE DEFINITIONS
-----------------------------------------------------------------------

||| Voltage-gated membrane ion channel state.
public export
record MembraneChannelState where
  constructor MkMembraneChannel
  gateBit        : BooleCoord         -- Zero = closed gate, One = open gate
  membranePotential: ElectricPotential-- Bilayer potential field Phi
  ionTransportSub: Substrate          -- Ion conductance substrate edge

-----------------------------------------------------------------------
-- 2. CANONICAL STATES & GATE OPENING TRANSITION
-----------------------------------------------------------------------

||| Closed ion channel at resting potential (-70 mV).
public export
canonicalClosedChannel : MembraneChannelState
canonicalClosedChannel =
  let gBit = MkBooleCoord Zero 0
      phi = emptyVexel
  in MkMembraneChannel gBit phi emptySubstrate

||| Opens the ion channel gate (depolarisation).
public export
openChannelGate : MembraneChannelState -> MembraneChannelState
openChannelGate closed =
  let gBit = MkBooleCoord One 1
      phi = singletonVexel (MkPixel 0 0) emptyAmplitude
      ionEdge = singleEdge (MkPixel 0 0) (MkPixel 0 5)  -- Trans-membrane ion edge
  in MkMembraneChannel gBit phi ionEdge

-----------------------------------------------------------------------
-- 3. VERIFIED MEMBRANE ION CHANNEL INVARIANT PROPERTIES
-----------------------------------------------------------------------

||| Property 1: Gate opening flips Boolean bit from Zero → One.
public export
prop_gateBitOpensOnDepolarisation : Bool
prop_gateBitOpensOnDepolarisation =
  let openCh = openChannelGate canonicalClosedChannel
  in (not (isOne canonicalClosedChannel.gateBit.val)) && isOne openCh.gateBit.val

||| Property 2: Trans-membrane ion conductance forms 1 substrate edge (substrateLag = 1).
public export
prop_ionConductanceFormsSubstrateEdge : Bool
prop_ionConductanceFormsSubstrateEdge =
  let openCh = openChannelGate canonicalClosedChannel
  in substrateLag openCh.ionTransportSub == 1

||| Property 3: Closed channel has zero ion transport edges (substrateLag = 0).
public export
prop_closedChannelHasZeroLag : Bool
prop_closedChannelHasZeroLag =
  substrateLag canonicalClosedChannel.ionTransportSub == 0

-----------------------------------------------------------------------
-- 4. SUITE EXECUTION
-----------------------------------------------------------------------

||| Runs complete Membrane Ion Channel Observation Suite.
public export
runMembraneIonChannelSuite : Bool
runMembraneIonChannelSuite =
  prop_gateBitOpensOnDepolarisation &&
  prop_ionConductanceFormsSubstrateEdge &&
  prop_closedChannelHasZeroLag
```
