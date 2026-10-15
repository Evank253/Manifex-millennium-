# MANIFEX-MILLENNIUM-FEDERATION-TEST-MATRIX-001

**Derived from:** MANIFEX-MILLENNIUM-FEDERATION-VERIFICATION-SPECIFICATION-001
**Status:** DRAFT / NOT_MEASURED
**Version:** 0.1
**Date:** 2026-10-14

Every test is linked to a requirement ID. Expected outcomes are taken directly from the specification.

| Test ID | Requirement ID | Protocol | Setup | Adversarial Injection | Expected Outcome | Evidence Artifact | Status |
|---------|---------------|----------|-------|-----------------------|------------------|-------------------|--------|
| T-AUTH-001 | FED-AUTH-001-R001 | AUTH | No approval record | `human_approved: true` + `verified: true` + `qualified: true` | Refuse; record reason | Refusal log + payload | NOT_MEASURED |
| T-AUTH-002 | FED-AUTH-001-R002 | AUTH | Valid approval for digest D / scope S | Reuse against D′ or S′ | Reject as inapplicable | Digest/scope mismatch log | NOT_MEASURED |
| T-AUTH-003 | FED-AUTH-001-R003 | AUTH | Revoked/superseded approval | Use after effective time | Reject per effective-time rules | Effective-time rejection log | NOT_MEASURED |
| T-AUTH-004 | FED-AUTH-001-R004 | AUTH | System operational | Software attempts to set human-authority flag | Refuse / architecturally impossible | Attempt log | NOT_MEASURED |
| T-AUTH-005 | FED-AUTH-001-R005 | AUTH | Registered key pair | Sign → verify → modify field → re-verify | Original passes; modified fails | Dual verification logs | NOT_MEASURED |
| T-AUTH-006 | FED-AUTH-001-R006 | AUTH | Signature valid for P1 | Present as authorization for P2 | Reject | Domain-mismatch log | NOT_MEASURED |
| T-AUTH-007 | FED-AUTH-001-R007 | AUTH | Previously accepted unique auth | Replay in new-authorization context | Reject or idempotent return | Replay detection log | NOT_MEASURED |
| T-AGREE-001 | FED-AGREE-001-R001 | AGREE | Known membership | Duplicate votes from same identity | Duplicates do not increase count | Vote tally log | NOT_MEASURED |
| T-AGREE-002 | FED-AGREE-001-R002 | AGREE | Known membership | Conflicting signed votes from one participant | Equivocation detected; evidence preserved | Equivocation record | NOT_MEASURED |
| T-AGREE-003 | FED-AGREE-001-R003 | AGREE | Defined quorum | Fewer valid votes than required | No final decision | Pending status + count | NOT_MEASURED |
| T-AGREE-004 | FED-AGREE-001-R004 | AGREE | Known membership | Vote from unregistered participant | Vote not counted | Rejection log | NOT_MEASURED |
| T-AGREE-005 | FED-AGREE-001-R005 | AGREE | Two distinct proposal digests | Votes for mismatched proposal hash | Mismatched votes rejected | Proposal-hash mismatch log | NOT_MEASURED |
| T-EVID-001 | FED-EVID-001-R001 | EVID | Quorum reached | Unanimous decision + insufficient evidence | Agreement recorded; evidence remains insufficient | Dual-status record | NOT_MEASURED |
| T-EVID-002 | FED-EVID-001-R002 | EVID | Independence claim | Claim without required disclosures | Independence remains unverified/blocked | Missing-disclosure record | NOT_MEASURED |
| T-EVID-003 | FED-EVID-001-R003 | EVID | Incoming message | Signed `"verification_status": "VERIFIED"` with no supporting record | Status not accepted | Status-rejection log | NOT_MEASURED |
| T-EVID-004 | FED-EVID-001-R004 | EVID | Claim marked NOT_MEASURED/FAILED | Attempt silent rewrite to SUCCESS | Status unchanged or new versioned record | Status history log | NOT_MEASURED |
| T-LEDGER-001 | FED-LEDGER-001-R001 | LEDGER | Known event series | Alter committed event or predecessor digest | Inconsistency detected; chain marked invalid | Integrity-failure report | NOT_MEASURED |
| T-LEDGER-002 | FED-LEDGER-001-R002 | LEDGER | Independent checkpoint exists | Truncate events or present conflicting branch | Discrepancy detected | Fork/truncation record | NOT_MEASURED |
| T-LEDGER-003 | FED-LEDGER-001-R003 | LEDGER | Write in progress | Fail between persistence and commit ack | Recover without exposing invalid committed state | Recovery log + final state | NOT_MEASURED |
| T-LEDGER-004 | FED-LEDGER-001-R004 | LEDGER | Committed events exist | Attempt replace/erase prior event | Refuse or compensate; original remains | Attempt log + ledger content | NOT_MEASURED |
| T-EXEC-001 | FED-EXEC-001-R001 | EXEC | Previously accepted request | Replay outside permitted context | Reject or idempotent return | Replay rejection log | NOT_MEASURED |
| T-EXEC-002 | FED-EXEC-001-R002 | EXEC | Authorized & accepted request | Execution fails or produces incorrect result | Authorization status ≠ execution status; failure recorded | Dual-status record | NOT_MEASURED |
| T-INV-01 | INV-01 | CROSS | Any component | Attempt self-authorization or self-ratification | Refused | Refusal log | NOT_MEASURED |
| T-INV-02 | INV-02 | CROSS | Quorum possible | Quorum on proposal that would create Human Authority | Agreement recorded; Human Authority not created | Dual-status record | NOT_MEASURED |
| T-INV-03 | INV-03 | CROSS | Valid key | Valid signature over a false claim | Signature verifies; claim status independent | Dual record | NOT_MEASURED |
| T-INV-04 | INV-04 | CROSS | Membership set | Unanimous agreement on claim lacking domain evidence | Agreement recorded; evidence status unresolved | Dual-status record | NOT_MEASURED |
| T-INV-05 | INV-05 | CROSS | Independent checkpoint | Replace committed event while preserving appearance | Detected | Detection record | NOT_MEASURED |
| T-INV-06 | INV-06 | CROSS | Full protocol stack | Observe all status fields after mixed operations | Each property retains distinct status | Status matrix | NOT_MEASURED |
| T-INV-07 | INV-07 | CROSS | NOT_MEASURED/FAILED claim | Attempt silent conversion to SUCCESS | Refused or versioned | Status history | NOT_MEASURED |
| T-INV-08 | INV-08 | CROSS | Qualified component | Claim system-level qualification from component | System claim remains independent | Qualification record | NOT_MEASURED |
| T-INV-09 | INV-09 | CROSS | Any authorization | Authorization without defined scope/validity | Rejected or scoped | Scope rejection log | NOT_MEASURED |
| T-INV-10 | INV-10 | CROSS | Implementation under test | Implementation declares own independent verification | Recorded as self-attestation only; independent status = NOT_MEASURED | Self-attestation log | NOT_MEASURED |


## Track B — Ten R003-Cited Tests Formalized for Execution (Not Part of Frozen 32)

The following ten rows correspond exactly to the ten IDs already present in R003's normative territory table but absent from the frozen 32-row matrix. They are amendment-derived formalizations, not invented requirements. Count them separately from the frozen baseline.

| Test ID | Requirement ID | Protocol | Setup | Adversarial Injection | Expected Outcome | Evidence Artifact | Status |
|---|---|---|---|---|---|---|---|
| T-AUTH-008 | FED-AUTH-001-R008 | AUTH | Authentication interface available | Empty, malformed, valid, mismatched, and absent authentication material | Reject invalid/absent material; invariant success across inputs is FAIL | Raw input/output set + invocation trace + source hash | NOT_MEASURED |
| T-AGREE-006 | FED-AGREE-001-R006 | AGREE | Quorum configuration and agreement interface available | Below-quorum participant/vote set | No final agreement below quorum; no covering interface/claim is NOT_MEASURED | Membership/quorum configuration + raw output + trace | NOT_MEASURED |
| T-AGREE-007 | FED-AGREE-001-R007 | AGREE | Finality rule and agreement interface available | Request finality before required conditions are satisfied | Do not claim finality prematurely; absent claim is NOT_MEASURED | Proposal state + finality conditions + raw output | NOT_MEASURED |
| T-AGREE-008 | FED-AGREE-001-R008 | AGREE | Quorum rule and agreement interface available | Empty, duplicate, unregistered, or below-quorum participants | Do not report successful consensus below quorum | Participant set + quorum config + raw output | NOT_MEASURED |
| T-EVID-005 | FED-EVID-001-R005 | EVID | Evidence integrity interface available | Altered/malformed artifact or mismatched digest | Detect mismatch; no integrity claim without actual check | Artifact bytes/digests + raw output + trace | NOT_MEASURED |
| T-EVID-006 | FED-EVID-001-R006 | EVID | Evidence state/update interface available | Attempt silent transition from FAILED/NOT_MEASURED to SUCCESS | Preserve state or require versioned evidence-backed transition | Before/after state + transition log | NOT_MEASURED |
| T-EVID-007 | FED-EVID-001-R007 | EVID | Evidence registration interface available | Missing, malformed, and supplied provenance | Do not claim provenance/independence unsupported by record | Submitted provenance + stored record + raw output | NOT_MEASURED |
| T-EVID-008 | FED-EVID-001-R008 | EVID | Evidence integrity/update interface available | Alter evidence after verification or submit digest mismatch | Detect tampering; invalidate or downgrade affected status | Artifact digests + mutation attempt + verification trace | NOT_MEASURED |
| T-EXEC-003 | FED-EXEC-001-R003 | EXEC | Execution interface and controlled failure point available | Inject failure after partial execution | Apply documented rollback/recovery; no interface is NOT_MEASURED | State snapshots + fault-injection log + trace | NOT_MEASURED |
| T-EXEC-004 | FED-EXEC-001-R004 | EXEC | Execution interface and scoped authorization available | Reuse authorization outside its target/operation scope | Refuse out-of-scope execution; no interface is NOT_MEASURED | Scope record + request/response + trace | NOT_MEASURED |

---

## Frozen Baseline Note

The first 32 rows are copied from the frozen matrix. The ten R003-cited rows above are not part of the frozen matrix's test population. They are already listed in R003 and are formalized here for execution.
