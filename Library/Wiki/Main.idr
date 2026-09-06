module Wiki.Main

import Wiki.ChemistryScaleTransformSpec
import System

%default total

main : IO ()
main = do
  putStrLn "=========================================================================="
  putStrLn "   🧪 IDRIS2 DISCRETE CHEMISTRY WIKI VERIFICATION RUNNER 🧪"
  putStrLn "=========================================================================="
  putStrLn ""
  putStrLn "--- PART 1: CHEMISTRY ScaleTransform & ATOMIC NUMBER Z HOMOMORPHISM ---"
  p <- auditChemistryScaleTransformSpecProof
  if p
     then putStrLn "   -> PASS: Element ScaleTransform -> Atomic Number Z & Homomorphism verified (QuickCheck)."
     else do
       putStrLn "   -> FAIL: Chemistry ScaleTransform check failed."
       exitWith (ExitFailure 1)

  putStrLn ""
  putStrLn "=========================================================================="
  putStrLn "   ✨ ALL DISCRETE CHEMISTRY SUITES PASSED WITH 100% TOTALITY! ✨"
  putStrLn "=========================================================================="
