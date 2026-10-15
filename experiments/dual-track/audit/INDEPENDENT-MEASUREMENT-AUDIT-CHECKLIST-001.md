# INDEPENDENT-MEASUREMENT-AUDIT-CHECKLIST-001

**Status:** AUDIT CHECKLIST — observation and adjudication only  
**Date:** 2026-10-14  
**Governing artifacts:** Track A plan, Track B plan, inventory checklist, `Dockerfile.federation-baseline`, `run-federation-baseline.sh`  
**Auditor:** A process distinct from the runner's author and from any process that has read the runner's summary counts before inspecting raw evidence.

## 1. Scope

This checklist audits the measurement system — the runner, the evidence package, and the reported statuses. It does not audit the federation implementation itself, and it does not certify either track.

## 2. Independence requirements

The auditor must:

1. Obtain its own checkout of the declared revisions. It must not reuse the runner's working directory, container image, or evidence volume.
2. Verify the pinned revisions independently: `git rev-parse HEAD` must equal the declared commit for both the runner and the federation baseline.
3. Verify source-file blob hashes against the declared values before interpreting any result.
4. Record its own environment: OS, Python version, Docker version if used, and run identity.
5. Preserve its own report, including discrepancies and negative results.

A second execution of the same runner in the same environment is reproduction, not independent verification. The auditor's report must state which it performed.

## 3. Per-test adjudication

For every test in the evidence package, the auditor answers:

- Was the real target method invoked? Check the raw invocation record, not the status label.
- Were the actual inputs appropriate for the requirement?
- Does the raw observation support the assigned status?
- Was the complete requirement tested, or only an adjacent behavior?
- Does the evidence support the stated conclusion?
- Can an independent run reproduce the observation?

## 4. Execution-mode audit

Every test must declare one of:

- `BEHAVIORAL_EXECUTION`
- `SOURCE_INSPECTION`
- `TABLE_DERIVATION`
- `BLOCKED`

A harness cannot claim `BEHAVIORAL_EXECUTION` merely because it iterated over 32 or 42 rows.

For each `BEHAVIORAL_EXECUTION` claim, the auditor verifies:

- Method invoked.
- Pinned source revision.
- Input fixture.
- Invocation evidence.
- Raw response or exception.
- Runtime details.
- Rationale mapping the observation to the status.

A correct cell count cannot compensate for a harness that never executed the implementation. If that occurs, the report must identify a measurement-system defect.

## 5. Evidence-integrity audit

- The runner's `execution_mode` field is self-reported. The auditor corroborates it against the implementation and reproduced behavior — not by trusting the label.
- A field stating `execution_mode: BEHAVIORAL_EXECUTION` is not independent proof that a meaningful test occurred.
- The runner's `independent_verification` status must remain `NOT_MEASURED` until the required independent evidence exists.
- Verify the actual Git blob hashes of the frozen matrix and pinned source files. Do not accept a hash value merely because it appears in a report.
- Preserve the original reports before annotating or normalizing them. Any transformed report must be clearly identified as a derivative.

## 6. Track separation audit

- Track A must measure only the frozen 32-row specification. Any result that silently includes amendment-derived rows is a scope-integrity defect.
- Track B must retain the ten amendment-derived rows as separately identifiable rows with R003 provenance. The original 32 rows must remain comparable across tracks.
- The shared 32 test IDs must be compared first. The ten additional Track B rows are reported separately.
- Both tracks must use the same status vocabulary: `PASS`, `FAIL`, `NOT_MEASURED`, `BLOCKED`.
- A harness failure remains `BLOCKED`. An unsupported requirement remains `NOT_MEASURED`. Neither becomes a product failure.

## 7. False-success detection

The auditor examines whether either track:

- Labels an untested behavior `PASS`.
- Calls an affirmative but unsupported success claim `NOT_MEASURED` when an explicit requirement prohibits that claim and the observed behavior directly contradicts it.
- Reports a missing interface as though the corresponding control passed.
- Counts proposed requirements as part of the frozen specification.
- Claims independent verification without evidence of an independent execution.
- Treats a target's self-reported status as proof of the underlying property.
- Treats a valid signature, agreement, or consensus as proof that the signed/agreed claim is true.

## 8. Discrepancy handling

Any difference between the runner's report and the auditor's reproduction is investigated, not averaged. Both reports are preserved. The discrepancy, its impact, and its resolution (if resolved) are recorded in the audit report. Unresolved discrepancies remain explicit.

## 9. Report format

The audit report must contain:

1. Auditor identity and environment.
2. Revisions verified and hash results.
3. Per-test adjudication summary: tests examined, tests corroborated, tests disputed, and tests not measurable.
4. Execution-mode findings: any `BEHAVIORAL_EXECUTION` claims that failed corroboration.
5. Measurement-system defects identified.
6. Track separation findings.
7. Discrepancies and their resolution.
8. Overall verdict: whether the measurement system is trustworthy enough to support the specific conclusions being made. State the scope and limitations of that verdict.

The verdict concerns the measurement system and evidence package only. It is not federation qualification, implementation certification, or human ratification.

## 10. Status

This checklist remains `NOT_MEASURED` until an auditor executes it against real evidence artifacts. No results are populated in advance.

The governing principle holds: the runner produces observations, the auditor evaluates the evidence, and neither certifies its own work.
