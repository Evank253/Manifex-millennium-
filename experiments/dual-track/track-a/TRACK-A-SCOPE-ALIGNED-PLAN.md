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
3. The ten rows cited by R003 but absent from the frozen matrix are excluded from Track A's frozen-scope denominator and recorded as amendment-derived scope. They are not described as nonexistent.
4. Missing interfaces are NOT_MEASURED unless the observed API behavior itself violates an explicit acceptance criterion. Unsupported affirmative claims such as verified, authenticated, SUCCESS, or IN_SYNC are FAIL only where the applicable requirement prohibits that claim without supporting evidence.
5. Harness/environment failure is BLOCKED, not a product FAIL.

## R003 artifact inventory status
R003 is a separate amendment artifact on branch `amendment-001-r002`, commit `ea31e0b751702d5412f9fb705e1323a12068a53e`, blob `19b37de08a6a4a55893b2a0dc154044e985b93bc`. Its 42-row normative table includes all 32 frozen matrix IDs plus ten amendment-derived IDs. The frozen `Python-3` commit does not contain R003; that is a branch/provenance distinction, not evidence that R003 does not exist. The inventory and harness audit checklist records the exact ten-row set difference. Track A uses only the pinned frozen 32-row matrix as its conformance denominator.

## Required outputs
- Per-row observed status and evidence pointer.
- Requirement-to-test traceability table.
- Explicit inventory of the ten R003-only rows and their amendment provenance.
- Counts by status, with denominator and test population stated.
- Independent reproduction status, initially NOT_MEASURED.

## Current state
**No Track A test execution is claimed by this setup commit.** The baseline is inventoried; executable measurement remains pending runner coverage and evidence capture.