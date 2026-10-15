# Dual-Track Federation Experiment — Independent Measurement Audit

**Status:** PLAN / NOT_MEASURED  
**Base commit:** 0fdb465382a0104ed7ae9870b0a5df4325575fbf  
**Audit independence:** NOT YET ESTABLISHED; this document does not claim independent execution.

## Audit question
Which test design produces more valid, traceable, uncertainty-preserving, reproducible measurements—without confusing expanded scope with conformance to the frozen baseline?

## Inputs to pin
- Frozen spec: MANIFEX-MILLENNIUM-FEDERATION-VERIFICATION-SPECIFICATION-001, blob a1d16c557b447c60ea40575f94d202721800b781.
- Frozen matrix: MANIFEX-MILLENNIUM-FEDERATION-TEST-MATRIX-001, blob 5568396eb0e39ab5c927bd80051f701aa3bd3aeb.
- Primordial rule: MANIFEX-PRIMORDIAL-001-HUMAN-AUTHORITY-SUPREMACY, blob b7114eaccd9c6e3bb0beaf70f744d7bd9cde52af.
- Federation implementation baseline: Evank253/Global-Intelligence commit 754fb1ff22da0de58ec4db525f137d09a06ae75a.
- Runner revision and complete environment metadata: must be captured per execution; do not treat a branch name as an immutable revision.
- R003 amendment: `Evank253/Manifex-millennium-`, branch `amendment-001-r002`, commit `ea31e0b751702d5412f9fb705e1323a12068a53e`, blob `19b37de08a6a4a55893b2a0dc154044e985b93bc`. It is separate from the frozen `Python-3` baseline.

## Audit dimensions
1. Traceability: each test maps to an existing frozen requirement/invariant or a clearly marked proposed requirement.
2. Measurement validity: status follows from observed behavior and explicit acceptance criteria.
3. Coverage: actual behavior exercised, not merely a row parsed or interface inspected.
4. Uncertainty preservation: NOT_MEASURED and BLOCKED remain distinct from FAIL.
5. Scope integrity: frozen and proposed populations are reported separately.
6. Reproducibility: independent process reruns the pinned artifacts and compares raw evidence.
7. Unsupported-success detection: affirmative claims are evaluated against explicit requirements and evidence preconditions.
8. Human Authority: no track, runner, or report self-approves or self-certifies.

## Decision rule
Do not choose a winner based on raw FAIL count. Compare traceability defects, exercised coverage, false-success detection, uncertainty preservation, and independent reproducibility. Track B's ten amendment-derived formalizations must be reported as a separate denominator; do not describe them as newly invented because R003 already cites them.

## Harness-execution audit dimension

The audit must distinguish behavioral execution from table parsing. Each row must state one execution mode: `BEHAVIORAL_EXECUTION` (method actually invoked, raw input/output captured), `SOURCE_INSPECTION` (source/API inspected without runtime call), `TABLE_DERIVATION` (status/count derived by walking table cells), or `BLOCKED` (valid execution prevented by environment). A table loop, parsed row, or generated test label does not prove implementation execution. For every claimed behavioral test, require method name, pinned source revision/hash, input fixture, invocation trace/counter, raw response/exception, timestamp/runtime/dependencies, and status-to-criterion rationale. Missing invocation evidence is a measurement-system defect even if counts match.

## Execution gate
The current baseline runner has only three explicit behavioral probes and routes most matrix rows to NOT_MEASURED. It cannot be treated as a 32-test behavioral executor. Before claiming the planned comparison, implement or independently provide test procedures for each row, preserving a NOT_MEASURED outcome where a behavior cannot be exercised.

## Current disposition
Setup only. No execution, qualification, human approval, or independent verification is claimed.