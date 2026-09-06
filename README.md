# Idris 2 Chemistry-Wiki

[![Idris 2 Verification](https://img.shields.io/badge/Idris_2-0.8.0-blue.svg)](https://www.idris-lang.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Verification suite and literate documentation chapter for **Idris2-Chemistry**, formalizing discrete molecular bonding, enzyme catalysis, and biochemical reaction networks.

## Overview

`Idris2-Chemistry-Wiki` verifies constructive chemical laws using integer multiset tokens:

- **Molecular Bond Maxels**: Covalent bonding networks and electron-pair sharing matrices.
- **Enzyme Catalysis & Kinetics**: Discrete Michaelis-Menten substrate-enzyme kinetics without floating-point drift.
- **Biochemical Reactions**: ATP hydrolysis, membrane ion transport, and stellar/cosmic nucleosynthesis networks.

## Verification & Build

To compile the literate verification suite and execute the test runner binary:

```bash
idris2 --build Idris2-Chemistry-Wiki.ipkg
./build/exec/lbiochemistry-wiki
```

## Related Repositories

- [Idris2-Chemistry](https://github.com/justinkelly-ie/Idris2-Chemistry)
- [Idris2-Biology-Wiki](https://github.com/justinkelly-ie/Idris2-Biology-Wiki)
- [Idris2-Universe-Wiki](https://github.com/justinkelly-ie/Idris2-Universe-Wiki)
