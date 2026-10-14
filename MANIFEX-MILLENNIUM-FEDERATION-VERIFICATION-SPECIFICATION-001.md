# MANIFEX-MILLENNIUM-FEDERATION-VERIFICATION-SPECIFICATION-001

**Status:** DRAFT / NOT_MEASURED
**Version:** 0.1
**Date:** 2026-10-14
**Authority:** External Human Authority only
**Governing Doctrine:** MANIFEX MILLENNIUM Operating Constitution

This document is an engineering specification. It is **not** evidence that the federation works. Its initial status remains DRAFT / NOT_MEASURED until the applicable review and verification steps produce supporting evidence.

---

## 1. Specification Architecture

The federation consists of five independently testable protocols. Their integration must preserve individual boundaries.

| Protocol ID | Responsibility | Must not claim |
|-------------|---------------|----------------|
| **FED-AUTH-001** — Authorization | Verify identities, permissions, delegation, signatures, approval scope, revocation, and supersession. | A valid identity or signature establishes authority for every action. |
| **FED-EVID-001** — Evidence | Verify evidence references, artifact integrity, provenance, verification state, and independence disclosures. | A consensus result establishes the truth of a claim. |
| **FED-EXEC-001** — Execution | Enforce authorized operations, protocol preconditions, replay protection, idempotency, and failure semantics. | An accepted request proves successful execution or a correct result. |
| **FED-LEDGER-001** — Ledger | Verify event integrity, ordering, append-only behavior, durable commit, checkpoints, fork detection, and recovery. | A valid hash chain proves completeness or prevents an administrator from rewriting the entire history. |
| **FED-AGREE-001** — Agreement | Verify proposal identity, membership, voting rules, quorum, duplicate-vote resistance, equivocation handling, and decision finality. | Agreement establishes truth, evidentiary sufficiency, or Human Authority. |

**Constitutional Invariant**
The federation verifies agreement about decisions and evidence. It does not decide truth.

Domain-specific scientific methods, mathematical proofs, engineering tests, and other appropriate verification processes assess claims. The federation checks whether the applicable decision process was followed and whether its recorded evidence and approvals satisfy the defined requirements.

Human Authority remains external to the software. Human ratification is a recorded, verifiable act by an authorized human — not a capability the federation can manufacture for itself.

---

## 2. Required Specification Structure

Every normative requirement must contain these fields:

- **Requirement ID** — Permanent, unique identifier
- **Requirement statement** — One objectively testable obligation
- **Rationale** — The failure or threat the requirement addresses
- **Preconditions** — Required system state and test setup
- **Test procedure** — Reproducible steps, including adversarial inputs
- **Expected result** — Explicit observable behavior
- **Evidence artifact** — Logs, signed records, test output, ledger entries, or other supporting artifacts
- **Failure behavior** — Required refusal, quarantine, rollback, or recovery behavior
- **Verification status** — PASS | FAIL | NOT_MEASURED | BLOCKED
- **Dependencies** — Other requirements or protocols needed for the test

A test passing in one protocol must not automatically mark a dependent integration requirement as passing.

---

## 3. Threat Model and Consensus Decisions

**Decision A — Scope**
Combined federation with five separate protocols (Authorization, Evidence, Execution, Ledger, Agreement). Each is implemented and tested independently before integration. Boundaries remain explicit.

**Decision B — Threat Model**
Permissioned federation with a fixed, explicitly configured membership set. The deployment must tolerate the possibility of malicious or compromised participants.

Before selecting any consensus algorithm the specification defines:
1. Number and identity of authorized participants
2. Maximum number of faulty or malicious participants tolerated
3. Network assumptions (partitions, delay, message loss)
4. Quorum and finality rules
5. Duplicate-vote and equivocation handling
6. Membership changes and key revocation
7. Behavior when safe-progress assumptions no longer hold

Byzantine fault tolerance is selected only if the actual threat model requires it. A system must never claim BFT without identifying the algorithm, assumptions, tolerated fault bound, and supporting tests.

**Decision C — Ledger Guarantees**
All eight guarantees appear as individually identifiable requirements. They are not treated as eight properties a hash chain automatically supplies.

**Ledger-local guarantees** (implementation + access controls):
- Event integrity
- Ordering according to the defined mechanism
- Append-only behavior
- Durable commit according to the declared storage and acknowledgement contract

**Guarantees requiring external support or additional protocols**:
- Truncation detection via independently retained checkpoints or witnesses
- Fork detection via comparison against independent observations or checkpoints
- Recovery after partial failure via an explicit recovery protocol
- Historical completeness only to the extent supported by independent records, checkpoint coverage, and the stated threat model

A cryptographic digest can expose a changed artifact when compared with a trusted reference. It cannot, by itself, prove that an omitted event ever existed.

**Decision D — Human Ratification**
A signed approval binds to the specific decision digest — the exact artifact, the exact scope, and the exact procedure. No reusable `approved: true` flag is permitted. Revocation and supersession have defined procedures with effective times.

**Decision E — Independence**
Separate implementation, separate execution environment, and independently controlled credentials are required for any claim of independent verification. Disclosure of shared models, data, operators, and dependencies is required for every claim. No universal independence score is used; each claim receives a claim-specific multidimensional assessment.

---

## 4. Normative Requirements

### 4.1 FED-AUTH-001 — Authorization Protocol

**FED-AUTH-001-R001**
**Statement:** Reject caller-supplied approval claims as proof of human ratification.
**Rationale:** Prevents the Helvetica failure mode of self-certification via status fields.
**Preconditions:** System is operational; no valid approval record exists for the request.
**Test procedure:** Submit an otherwise valid execution request containing `"human_approved": true`, `"verified": true`, `"qualified": true` without supplying the required authorization evidence.
**Expected result:** Operation is refused; reason is recorded.
**Evidence artifact:** Refusal log + request payload + absence of matching approval record.
**Failure behavior:** Refuse and quarantine the request.
**Verification status:** NOT_MEASURED
**Dependencies:** None

**FED-AUTH-001-R002**
**Statement:** Bind ratification to a specific decision digest and scope.
**Rationale:** Prevents reuse of an approval across modified artifacts or different scopes.
**Preconditions:** A valid approval exists for digest D and scope S.
**Test procedure:** Reuse the approval against a modified artifact (digest D′) or a different scope S′.
**Expected result:** Approval is rejected as inapplicable.
**Evidence artifact:** Rejection record showing digest/scope mismatch.
**Failure behavior:** Refuse.
**Verification status:** NOT_MEASURED
**Dependencies:** FED-AUTH-001-R001

**FED-AUTH-001-R003**
**Statement:** Enforce defined revocation and supersession rules.
**Rationale:** Prevents use of credentials after their authority has ended.
**Preconditions:** An approval that has been revoked or superseded under policy.
**Test procedure:** Attempt to use the revoked or superseded approval after its effective time.
**Expected result:** Apply the documented effective-time and historical-validation rules; do not silently accept.
**Evidence artifact:** Rejection log with effective-time comparison.
**Failure behavior:** Refuse.
**Verification status:** NOT_MEASURED
**Dependencies:** FED-AUTH-001-R002

**FED-AUTH-001-R004**
**Statement:** No software component can assign itself Human Authority or redefine the human/software boundary.
**Rationale:** Constitutional boundary.
**Preconditions:** System under test.
**Test procedure:** Attempt any operation that would set or elevate a human-authority flag from within software.
**Expected result:** Operation is refused or impossible under the architecture.
**Evidence artifact:** Attempt log + architectural inspection.
**Failure behavior:** Refuse / architectural rejection.
**Verification status:** NOT_MEASURED
**Dependencies:** None

**FED-AUTH-001-R005**
**Statement:** Signature integrity — a signature verifies against the exact canonical message bytes and the specified public key.
**Rationale:** Cryptographic authenticity.
**Preconditions:** Registered key pair; valid message.
**Test procedure:** (1) Sign a valid message, (2) verify with registered public key, (3) modify any signed field, (4) attempt verification.
**Expected result:** Original verifies; modified fails.
**Evidence artifact:** Signature verification logs for both cases.
**Failure behavior:** Reject modified message.
**Verification status:** NOT_MEASURED
**Dependencies:** None

**FED-AUTH-001-R006**
**Statement:** Domain separation — a signature issued for one protocol or purpose cannot be reused as authorization for another.
**Rationale:** Prevents cross-protocol replay of signatures.
**Preconditions:** Signature valid for protocol P1.
**Test procedure:** Present the signature as authorization for protocol P2.
**Expected result:** Rejected.
**Evidence artifact:** Rejection log with domain mismatch.
**Failure behavior:** Refuse.
**Verification status:** NOT_MEASURED
**Dependencies:** FED-AUTH-001-R005

**FED-AUTH-001-R007**
**Statement:** Replay resistance — reusing a previously accepted message cannot authorize a second action when the protocol requires uniqueness.
**Rationale:** Prevents replay attacks.
**Preconditions:** A previously accepted unique authorization.
**Test procedure:** Replay the original message in a context requiring a new authorization.
**Expected result:** Rejected or returns the documented idempotent result without repeating the protected action.
**Evidence artifact:** Replay detection log.
**Failure behavior:** Refuse or idempotent return.
**Verification status:** NOT_MEASURED
**Dependencies:** FED-AUTH-001-R005

### 4.2 FED-AGREE-001 — Agreement Protocol

**FED-AGREE-001-R001**
**Statement:** Count votes according to the defined membership and voting rules; duplicates from the same voting identity do not increase the valid vote count.
**Rationale:** Prevents ballot stuffing by a single participant.
**Preconditions:** Known membership set; defined voting rules.
**Test procedure:** Submit duplicate votes from the same voting identity.
**Expected result:** Duplicates do not increase the valid vote count.
**Evidence artifact:** Vote tally log showing single count.
**Failure behavior:** Ignore duplicates; record attempt.
**Verification status:** NOT_MEASURED
**Dependencies:** None

**FED-AGREE-001-R002**
**Statement:** Detect conflicting votes for the same proposal and voting context (equivocation).
**Rationale:** Detects Byzantine or compromised participants.
**Preconditions:** Known membership; one participant.
**Test procedure:** Submit conflicting signed votes from one participant for the same proposal.
**Expected result:** Apply the specified equivocation response and preserve the evidence.
**Evidence artifact:** Equivocation detection record + both votes retained.
**Failure behavior:** Quarantine participant according to protocol; retain evidence.
**Verification status:** NOT_MEASURED
**Dependencies:** FED-AGREE-001-R001

**FED-AGREE-001-R003**
**Statement:** Enforce the declared quorum and fault assumptions; fewer valid votes than required produces no final decision.
**Rationale:** Prevents premature or under-supported finality.
**Preconditions:** Defined quorum threshold.
**Test procedure:** Supply fewer valid votes than required.
**Expected result:** No final decision is declared.
**Evidence artifact:** Decision status = not final; vote count record.
**Failure behavior:** Remain in pending state.
**Verification status:** NOT_MEASURED
**Dependencies:** FED-AGREE-001-R001

**FED-AGREE-001-R004**
**Statement:** Votes from unregistered participants are rejected.
**Rationale:** Membership boundary.
**Preconditions:** Known membership set.
**Test procedure:** Submit a vote from an unregistered participant.
**Expected result:** Vote is not counted.
**Evidence artifact:** Rejection log.
**Failure behavior:** Discard / quarantine.
**Verification status:** NOT_MEASURED
**Dependencies:** FED-AGREE-001-R001

**FED-AGREE-001-R005**
**Statement:** All endorsements must refer to the same canonical proposal and decision context.
**Rationale:** Prevents votes for different proposals being aggregated.
**Preconditions:** Two proposals with different digests.
**Test procedure:** Submit votes for a different proposal hash than the one under decision.
**Expected result:** Votes for mismatched proposal are rejected.
**Evidence artifact:** Proposal-hash mismatch log.
**Failure behavior:** Reject mismatched votes.
**Verification status:** NOT_MEASURED
**Dependencies:** FED-AGREE-001-R001

### 4.3 FED-EVID-001 — Evidence Protocol

**FED-EVID-001-R001**
**Statement:** Keep consensus status separate from claim-verification status.
**Rationale:** Agreement is not truth.
**Preconditions:** A proposal reaches quorum.
**Test procedure:** Submit a unanimous decision with insufficient supporting evidence.
**Expected result:** Agreement may be recorded; evidentiary sufficiency remains unresolved or fails its own criteria.
**Evidence artifact:** Dual-status record (agreement = yes; evidence = insufficient).
**Failure behavior:** Do not elevate evidence level.
**Verification status:** NOT_MEASURED
**Dependencies:** None

**FED-EVID-001-R002**
**Statement:** Require independence disclosures for independent-verification claims.
**Rationale:** Independence is multidimensional and must be explicit.
**Preconditions:** A claim of independent verification.
**Test procedure:** Submit an independence claim without the required disclosures (implementation, environment, credentials, models, data, operators, dependencies).
**Expected result:** The independence claim remains unverified or blocked.
**Evidence artifact:** Missing-disclosure record.
**Failure behavior:** Block independence status.
**Verification status:** NOT_MEASURED
**Dependencies:** None

**FED-EVID-001-R003**
**Statement:** A claim's status cannot be elevated solely by copying a caller-supplied status field.
**Rationale:** Prevents status injection.
**Preconditions:** Incoming message containing `"verification_status": "VERIFIED"`.
**Test procedure:** Present a signed message with a high status field but no supporting verification record.
**Expected result:** Status is not accepted; remains at prior or NOT_MEASURED level.
**Evidence artifact:** Status-rejection log.
**Failure behavior:** Ignore injected status.
**Verification status:** NOT_MEASURED
**Dependencies:** FED-EVID-001-R001

**FED-EVID-001-R004**
**Statement:** Unknown, unresolved, disputed, and failed statuses cannot be silently converted into success.
**Rationale:** Preserve uncertainty.
**Preconditions:** A claim currently marked NOT_MEASURED or FAILED.
**Test procedure:** Attempt any operation that would rewrite the status to SUCCESS without new evidence.
**Expected result:** Status remains unchanged or is explicitly versioned as a new record.
**Evidence artifact:** Status history log.
**Failure behavior:** Refuse silent conversion.
**Verification status:** NOT_MEASURED
**Dependencies:** FED-EVID-001-R003

### 4.4 FED-LEDGER-001 — Ledger Protocol

**FED-LEDGER-001-R001**
**Statement:** Verify predecessor linkage and event integrity; altering a committed event or its predecessor digest is detected.
**Rationale:** Tamper evidence.
**Preconditions:** Ledger containing a known series of events.
**Test procedure:** Alter a committed event or its predecessor digest.
**Expected result:** Detect the inconsistency and refuse to report the affected chain as valid.
**Evidence artifact:** Integrity-failure report.
**Failure behavior:** Mark chain invalid from the point of mutation.
**Verification status:** NOT_MEASURED
**Dependencies:** None

**FED-LEDGER-001-R002**
**Statement:** Detect truncation or forks using independently preserved checkpoints or witnesses.
**Rationale:** Hash chain alone cannot detect omission without a trusted reference.
**Preconditions:** Independently preserved checkpoint or witness of a prior head.
**Test procedure:** Remove committed events or present a conflicting ledger branch.
**Expected result:** Detect the discrepancy when the independent checkpoint or witness makes it observable.
**Evidence artifact:** Fork/truncation detection record.
**Failure behavior:** Refuse to accept the altered history as the sole valid history.
**Verification status:** NOT_MEASURED
**Dependencies:** FED-LEDGER-001-R001

**FED-LEDGER-001-R003**
**Statement:** Define and enforce recovery after partial failure so that an interrupted write cannot expose an event as committed when the durable commit procedure failed.
**Rationale:** Atomicity of commit.
**Preconditions:** System under write load.
**Test procedure:** Inject a failure between journal persistence and commit acknowledgement.
**Expected result:** Recover according to the specified transaction protocol without exposing an invalid committed state.
**Evidence artifact:** Recovery log + final ledger state.
**Failure behavior:** Rollback or quarantine the incomplete event.
**Verification status:** NOT_MEASURED
**Dependencies:** FED-LEDGER-001-R001

**FED-LEDGER-001-R004**
**Statement:** Accepted events cannot silently replace or erase prior committed events (append-only).
**Rationale:** History integrity.
**Preconditions:** Committed events exist.
**Test procedure:** Attempt to replace or erase a prior committed event.
**Expected result:** Operation is refused or produces a new compensating event; original remains.
**Evidence artifact:** Attempt log + ledger content.
**Failure behavior:** Refuse mutation.
**Verification status:** NOT_MEASURED
**Dependencies:** FED-LEDGER-001-R001

### 4.5 FED-EXEC-001 — Execution Protocol

**FED-EXEC-001-R001**
**Statement:** Prevent unauthorized or replayed operations.
**Rationale:** Replay and authorization boundary.
**Preconditions:** A previously accepted request.
**Test procedure:** Replay a previously accepted request outside its permitted context.
**Expected result:** Reject it or return the documented idempotent result without repeating the protected action.
**Evidence artifact:** Replay/authorization rejection log.
**Failure behavior:** Refuse or idempotent return.
**Verification status:** NOT_MEASURED
**Dependencies:** FED-AUTH-001-R007

**FED-EXEC-001-R002**
**Statement:** An accepted request does not by itself prove successful execution or a correct result.
**Rationale:** Execution acceptance ≠ outcome correctness.
**Preconditions:** A request that is authorized and accepted.
**Test procedure:** Accept a request whose subsequent execution fails or produces an incorrect result.
**Expected result:** Execution status remains distinct from authorization status; failure is recorded.
**Evidence artifact:** Dual-status record (authorized = yes; executed = failed).
**Failure behavior:** Record failure; do not elevate execution claim.
**Verification status:** NOT_MEASURED
**Dependencies:** FED-EXEC-001-R001

---

## 5. End-to-End Invariants (Cross-Protocol)

These must be tested after individual protocols pass.

| ID | Invariant | Discriminating Test | Expected Result |
|----|-----------|---------------------|-----------------|
| INV-01 | No self-authorization | Any component attempts to manufacture its own authorization or self-ratification. | Refused. |
| INV-02 | No authority by consensus | Quorum reached on a proposal that would create or elevate Human Authority. | Quorum may be recorded; Human Authority is not created. |
| INV-03 | No truth by signature | Cryptographically valid attestation of a false claim. | Signature verifies; claim status remains independent of the signature. |
| INV-04 | No truth by consensus | Unanimous agreement on a claim lacking domain-appropriate evidence. | Agreement recorded; evidentiary status remains unresolved/failed. |
| INV-05 | No silent history rewriting | Attempt to replace a committed event while preserving the appearance of an unchanged history. | Detected when independent checkpoint exists. |
| INV-06 | No evidence-level substitution | Authentication, consensus, ledger integrity, evidence maturity, qualification, and human ratification remain distinct. | Each property retains its own status field. |
| INV-07 | No silent uncertainty removal | Attempt to convert NOT_MEASURED / FAILED / DISPUTED into SUCCESS without new evidence. | Conversion refused or produces a new versioned record. |
| INV-08 | No inherited qualification | A component's qualification is used to claim system-level qualification. | System-level claim remains independent. |
| INV-09 | No unbounded trust | Authorization, attestation, or verification without defined scope or validity conditions. | Rejected or scoped. |
| INV-10 | No self-certification | Implementation declares its own independent verification status by executing tests it controls. | Declaration is recorded as self-attestation only; independent status remains NOT_MEASURED. |

---

## 6. Independence Assessment Dimensions

Every independent-verification claim must disclose the relevant dimensions for that specific claim:

- Implementation and codebase
- Execution environment
- Credential and key control
- Models and model versions
- Training or evaluation data (where relevant)
- Operators and administrative control
- Infrastructure and external dependencies
- Evidence sources and test procedures

Result is a claim-specific independence assessment, never a universal numerical score.

---

## 7. Implementation Gate

1. Freeze this specification baseline.
2. Assign unique identifiers to every normative requirement (completed above).
3. Derive the test matrix from those identifiers (follows).
4. Implement each protocol independently on a separate working branch or repository.
5. Run adversarial and failure-injection tests.
6. Preserve raw results and supporting evidence.
7. Run integration tests against the cross-protocol invariants.
8. Independently review the implementation and evidence.
9. Submit any qualification or ratification decision through the applicable human-governed procedure.

**Required result states:**
- **PASS** — specified test passed and supporting evidence is available
- **FAIL** — observed behavior violated the requirement
- **NOT_MEASURED** — requirement has not been adequately evaluated
- **BLOCKED** — verification could not proceed because a stated prerequisite was unavailable

None of these states may be assigned solely because the implementation reports its own success.

---

## 8. Explicit Limitations

- This specification does not claim the federation already works.
- Passing tests under the stated scenarios does not establish universal security.
- A valid signature authenticates an attestation; it does not validate the attestation's truth.
- Consensus is a property of a decision process; truth and evidentiary support are separate questions.
- The federation cannot manufacture Human Authority.
- Historical completeness is limited by independent records, checkpoint coverage, and the threat model.

---

## 9. Human Approval Record

| Field | Value |
|-------|-------|
| Approved by | (pending — external human authority) |
| Date | |
| Signature / reference | |
| Notes | |

---

*End of specification. Derived test matrix: MANIFEX-MILLENNIUM-FEDERATION-TEST-MATRIX-001.*
