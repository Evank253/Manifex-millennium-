# Dual-Track Federation Experiment — Track A

**Status:** EXPERIMENTAL / NOT_MEASURED  
**Base commit:** 0fdb465382a0104ed7ae9870b0a5df4325575fbf  
**Frozen matrix Git blob:** 5568396eb0e39ab5c927bd80051f701aa3bd3aeb  
**Baseline population:** 32 rows (22 protocol-specific tests + 10 cross-protocol invariant tests)

## Purpose
Measure the federation against the frozen specification and its actual 32-row matrix without expanding normative scope.

## Preservation rule
The frozen specification, frozen matrix, and primordial rule are not edited. The exact matrix is copied to experiments/dual-track/track-a/FROZEN-MATRIX-COPY.md. All corrections exist only in this experimental branch.

## Scope rule
1. The baseline population is exactly the 32 rows in the pinned matrix.
2. Every test must trace to one of the frozen requirement IDs or invariant IDs already named by the matrix.
3. Any row appearing in the R003 amendment but lacking a traceable match to the frozen 32-row population is excluded from Track A's conformance count and recorded as a scope discrepancy; it is not silently deleted from the source artifact.
4. Missing interfaces are NOT_MEASURED unless the observed API behavior itself violates an explicit acceptance criterion. Unsupported affirmative claims such as verified, authenticated, SUCCESS, or IN_SYNC are FAIL only where the applicable requirement prohibits that claim without supporting evidence.
5. Harness/environment failure is BLOCKED, not a product FAIL.

## R003 artifact inventory status
The frozen repository at the base commit contains the specification, the 32-row matrix, and the primordial rule. It does not contain an artifact named R003 or a ten-row amendment table. Therefore this branch does not pretend to have made a line-for-line correction of an unseen R003 file. Before classifying any specific R003 rows, add the exact R003 artifact and its hash to the inventory. Until then, Track A's baseline population is defined by the pinned 32-row matrix only.

## Required outputs
- Per-row observed status and evidence pointer.
- Requirement-to-test traceability table.
- Explicit inventory of R003-only rows once the artifact is supplied.
- Counts by status, with denominator and test population stated.
- Independent reproduction status, initially NOT_MEASURED.

## Current state
**No Track A test execution is claimed by this setup commit.** The baseline is inventoried; executable measurement remains pending runner coverage and evidence capture.