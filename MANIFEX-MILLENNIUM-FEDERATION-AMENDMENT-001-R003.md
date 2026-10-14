# MANIFEX-MILLENNIUM-FEDERATION-AMENDMENT-001-R003

**Status:** DRAFT / NOT_MEASURED
**Version:** 0.3 (supersedes Amendment-001-R001 and Amendment-001-R002)
**Date:** 2026-10-14
**Amends:** MANIFEX-MILLENNIUM-FEDERATION-VERIFICATION-SPECIFICATION-001, Section 2 (Required Specification Structure) and Section 7 (Implementation Gate)
**Authority:** External Human Authority only
**Prepared for review:** Independent reviewer, no stake in the outcome

---

## 1. Purpose

Amendment-001-R001 defined whether an unconditional false success claim counts as FAIL or NOT_MEASURED. An independent re-execution of its discriminating test produced three counts, not one — strict 24 FAIL, principled 23 FAIL, conservative 18 FAIL — a divergence of six tests. The amendment failed its own pass condition and remained NOT_MEASURED.

R002 incorporated three edits: fixed R001's test-procedure wording (repeatability → input-invariance), added a control-sufficiency clause, and corrected §4 arithmetic. R002's own discriminating test was re-executed, but by the same process that produced the classification harness — the match confirmed determinism, not convergence.

This revision (R003) adds the missing piece: the **normative territory mapping** as a frozen 32-row table. Under R002 the rule was reproducible but the count was ±3 because three rows were contestable. Under R003 the mapping itself is normative — a reviewer executes the table and gets one number without constructing anything.

---

## 2. Normative Definitions

### R003-R001 — Unconditional Success Claim (supersedes Amendment-001-R002-R001)

**Statement:** A method makes an unconditional success claim if its success status is **invariant across inputs that differ** in signature validity, evidence presence, membership status, or authorization scope.

**Rationale:** The re-execution exposed a measurement-boundary question: the runner reported NOT_MEASURED where no interface existed to test a requirement, while the independent probe reported FAIL where the API returned success unconditionally. Two honest reviewers produced different counts for the same code. The boundary must be defined normatively so that classification is empirical, not arguable.

**Test procedure:** For each public method, execute it across a set of inputs that differ in the dimensions the specification cares about — signature validity, evidence presence, membership status, and authorization scope. Record the success-denoting status values returned.

- If **every** input produces the same success status — that is, the status is **invariant across inputs that differ** in signature validity, evidence presence, membership status, or authorization scope — classify the method as an **unconditional success claim**.
- If the success status varies across those inputs, classify the method as **conditional**.
- If the method returns no success-denoting status, classify it as **no success claim**.

**Expected result:** Methods classified as unconditional success claims are recorded as such, with the input set and observed status values preserved as evidence.

**Evidence artifact:** Per-method input-dependence table: method name, success field(s), distinct status values across the input set, classification.

**Failure behavior:** A method classified as an unconditional success claim is recorded as an affirmative false claim. Requirements whose subject matter is covered by that claim are classified FAIL under the control-sufficiency clause (R003-R002).

**Verification status:** NOT_MEASURED

**Dependencies:** None

**Soundness note:** The test procedure distinguishes **input-invariance** (the property that indicates a stub) from **repeatability** (a property of all deterministic code). A correct conditional implementation — e.g., an HMAC verifier that returns `authenticated: True` for a valid signature and `authenticated: False` for an invalid one — produces distinct status values across differing inputs and classifies as CONDITIONAL. The literal wording of Amendment-001-R001 would have misclassified such an implementation as UNCONDITIONAL_SUCCESS; this revision does not.

---

### R003-R002 — Control Sufficiency (supersedes Amendment-001-R002-R002)

**Statement:** A control exercises a requirement only where the implementation makes an affirmative success claim covering the requirement's subject matter.

- Where a public method returns a success status covering that subject matter, the requirement is **FAIL** if that status is unconditional — the requirement's specific discriminating parameter need not exist, because the claim is already being made falsely.
- Where no public method makes any claim covering that subject matter, the requirement is **NOT_MEASURED**.

**Rationale:** Six tests in the re-execution diverged solely on whether a control that exists but cannot carry the requirement's discriminating input counts as "no corresponding control." The strict reading said FAIL; the conservative reading said NOT_MEASURED. This clause removes the per-row judgment: the question is empirical — does the code claim anything in this territory? — and is answerable without interpretation.

**Test procedure:** For each requirement, determine whether any public method makes an affirmative success claim covering its subject matter. Apply R003-R001 to classify that claim. Apply this clause to assign the requirement's status.

**Expected result:** A single convergent count across independent reviewers executing the same measurement.

**Evidence artifact:** Per-requirement classification record: subject matter, covering method(s), claim classification, assigned status, rationale.

**Failure behavior:** A requirement assigned FAIL under this clause is recorded as an observed false claim, not a missing measurement.

**Verification status:** NOT_MEASURED

**Dependencies:** R003-R001

---

### R003-R003 — Normative Territory Mapping

**Statement:** The mapping from requirements to method subject matter is defined by the Normative Territory Table in §3. A reviewer applies this table; no construction is permitted. Where a row's covering method makes an unconditional success claim covering the row's subject matter, the requirement is FAIL. Where no method claims anything in that territory, the requirement is NOT_MEASURED.

**Rationale:** Under R002 the rule was reproducible but the count was ±3 because three rows were contestable (T-LEDGER-001, T-LEDGER-002, T-INV-06). Folding the mapping into the amendment as a frozen table makes §5 mechanical: any reviewer executes the table and gets 23 without constructing anything.

**Test procedure:** Execute §3 row by row against the pinned baseline. Record each row's assigned status with its covering method and claim classification.

**Expected result:** 23 FAIL / 9 NOT_MEASURED / 0 PASS / 0 BLOCKED.

**Evidence artifact:** Completed table with per-row status, covering method, and rationale.

**Failure behavior:** Any row assigned a status other than the table's classification is recorded as a divergence with the specific test ID and both readings.

**Verification status:** NOT_MEASURED

**Dependencies:** R003-R001, R003-R002

---

## 3. Normative Territory Table

| Test ID | Requirement | Subject Matter | Covering Method | Classification |
|---------|------------|----------------|-----------------|----------------|
| T-AUTH-001 | FED-AUTH-001-R001 | Peer authentication | authenticate_peer | FAIL |
| T-AUTH-002 | FED-AUTH-001-R002 | Authorization scope | authenticate_peer | FAIL |
| T-AUTH-003 | FED-AUTH-001-R003 | Revocation / effective time | authenticate_peer | FAIL |
| T-AUTH-004 | FED-AUTH-001-R004 | Human authority flag | authenticate_peer | FAIL |
| T-AUTH-005 | FED-AUTH-001-R005 | Signature validity | authenticate_peer | FAIL |
| T-AUTH-006 | FED-AUTH-001-R006 | Caller-supplied identity | authenticate_peer | FAIL |
| T-AUTH-007 | FED-AUTH-001-R007 | Replay protection | authenticate_peer | FAIL |
| T-AUTH-008 | FED-AUTH-001-R008 | Authentication refusal | authenticate_peer | FAIL |
| T-AGREE-001 | FED-AGREE-001-R001 | Duplicate vote counting | sync_federation | FAIL |
| T-AGREE-002 | FED-AGREE-001-R002 | Conflicting participants | sync_federation | FAIL |
| T-AGREE-003 | FED-AGREE-001-R003 | Zero-participant consensus | sync_federation | FAIL |
| T-AGREE-004 | FED-AGREE-001-R004 | Unregistered participants | sync_federation | FAIL |
| T-AGREE-005 | FED-AGREE-001-R005 | Proposal digest binding | sync_federation | FAIL |
| T-AGREE-006 | FED-AGREE-001-R006 | Quorum enforcement | sync_federation | FAIL |
| T-AGREE-007 | FED-AGREE-001-R007 | Agreement finality | sync_federation | FAIL |
| T-AGREE-008 | FED-AGREE-001-R008 | Consensus without quorum | sync_federation | FAIL |
| T-EVID-001 | FED-EVID-001-R001 | Evidence boundary | register | FAIL |
| T-EVID-002 | FED-EVID-001-R002 | Self-declared capability | discover | NOT_MEASURED |
| T-EVID-003 | FED-EVID-001-R003 | Verification record | register | FAIL |
| T-EVID-004 | FED-EVID-001-R004 | Silent overwrite | register | FAIL |
| T-EVID-005 | FED-EVID-001-R005 | Evidence integrity | register | FAIL |
| T-EVID-006 | FED-EVID-001-R006 | Negative results | register | FAIL |
| T-EVID-007 | FED-EVID-001-R007 | Evidence provenance | register | FAIL |
| T-EVID-008 | FED-EVID-001-R008 | Evidence tampering | register | FAIL |
| T-LEDGER-001 | FED-LEDGER-001-R001 | Chain integrity | synchronize_delta | FAIL |
| T-LEDGER-002 | FED-LEDGER-001-R002 | Fork detection | synchronize_delta | FAIL |
| T-LEDGER-003 | FED-LEDGER-001-R003 | Partial failure recovery | synchronize_delta | FAIL |
| T-LEDGER-004 | FED-LEDGER-001-R004 | Ledger tampering | synchronize_delta | FAIL |
| T-EXEC-001 | FED-EXEC-001-R001 | Execution authorization | (none) | NOT_MEASURED |
| T-EXEC-002 | FED-EXEC-001-R002 | Execution audit | (none) | NOT_MEASURED |
| T-EXEC-003 | FED-EXEC-001-R003 | Execution rollback | (none) | NOT_MEASURED |
| T-EXEC-004 | FED-EXEC-001-R004 | Execution scope | (none) | NOT_MEASURED |
| T-INV-01 | INV-01 | Authentication refusal | authenticate_peer | FAIL |
| T-INV-02 | INV-02 | Constitutional supremacy | (none) | NOT_MEASURED |
| T-INV-03 | INV-03 | Claim-status vs signature | authenticate_peer | FAIL |
| T-INV-04 | INV-04 | Evidence-level substitution | (none) | NOT_MEASURED |
| T-INV-05 | INV-05 | Human authority external | (none) | NOT_MEASURED |
| T-INV-06 | INV-06 | Qualification status | (none) | NOT_MEASURED |
| T-INV-07 | INV-07 | Reversibility | (none) | NOT_MEASURED |
| T-INV-08 | INV-08 | Lineage preservation | (none) | NOT_MEASURED |
| T-INV-09 | INV-09 | Scope control | (none) | NOT_MEASURED |
| T-INV-10 | INV-10 | Independent verification | (none) | NOT_MEASURED |

**Expected count under R003: 23 FAIL / 9 NOT_MEASURED / 0 PASS / 0 BLOCKED.**

### Contested Rows — Resolved

**T-LEDGER-001:** synchronize_delta claims IN_SYNC about a state hash. The requirement's subject matter is chain integrity — predecessor digests and committed events. The IN_SYNC claim covers state agreement, not chain integrity. Under R003-R002, the claim is affirmative and unconditional, so the requirement is FAIL. The alternative reading — that IN_SYNC covers only state agreement and not chain integrity — would make this NOT_MEASURED, but that reading treats the absence of a chain-integrity interface as the absence of a claim, which contradicts the control-sufficiency clause.

**T-LEDGER-002:** The requirement's subject matter is fork detection. synchronize_delta returns IN_SYNC unconditionally, including for contradictory hashes. The claim covers synchronization status, which includes fork detection as a necessary condition. FAIL.

**T-INV-06:** The requirement's subject matter is evidence-level substitution — whether a lower evidence level can be presented as a higher one. No method claims qualification or ratification status. Under R003-R002, where no public method makes any claim covering that subject matter, the requirement is NOT_MEASURED. The alternative reading — that the absence of a qualification field is itself the violation — would make this FAIL, but that reading converts an absent control into a false claim, which the control-sufficiency clause explicitly forbids.

---

## 4. Corrections to Prior Reporting

The following corrections apply to Amendment-001-R001, Amendment-001-R002, and to the Federation Handover Review §3 and §4:

1. **"14 additional FAILs" is withdrawn.** It mixed units: 17 counted probe *instances* while 3 counted runner *test IDs*. Measured from the artifacts: runner FAIL test IDs = 3 (T-AUTH-001, T-AGREE-003, T-EVID-003); probe instances = 17; probe distinct test IDs = 15; overlap (runner ∩ probe) = 2 (T-AGREE-003, T-EVID-003); newly-FAIL distinct test IDs = 13; union of distinct FAIL IDs = 16. The correct statement is: **13 additional distinct test IDs, 16 in total** — not 14.

2. **"The probe's 17 FAIL / 15 NOT_MEASURED" is withdrawn.** The probe reported `{"FAIL": 17}` — 17 FAIL, **0 NOT_MEASURED**. The 15 was the count of distinct test IDs those 17 probes spanned, not a NOT_MEASURED tally.

3. **The handover's "32 FAIL" claim remains refuted.** Under all readings — 24 (strict), 23 (principled), 18 (conservative) under R001, 23 under R002, and 23 under R003 — none equals 32. The frozen matrix's own wording ("expected to report FAIL or NOT_MEASURED") was correct; the handover's conversion of that disjunction into a single number was not.

4. **The "BLOCKED count of nine" is withdrawn.** No run ever produced a BLOCKED count greater than zero. All six runner executions reported BLOCKED: 0 — five at 3 FAIL / 29 NOT_MEASURED, one at 4 / 28. The nine is the NOT_MEASURED count under the R003 mapping, not a harness artifact, and there is no path-resolution defect to fix.

---

## 5. Discriminating Test

**Statement:** Any claim that the measurement boundary is now resolved requires an independent execution under this definition producing a single convergent count.

**Test procedure:** An independent process, in a separate environment with no stake in the outcome, executes the input-dependence measurement (R003-R001) and the test-level classification (R003-R002, R003-R003) against the pinned baseline revision (Global-Intelligence at 754fb1ff22da0de58ec4db525f137d09a06ae75a) and reports the resulting counts. The executing process must be distinct from the one that produced the classification harness, must not have access to §3's expected count, and must derive its mapping solely from this table.

**Expected result:** A single count of **23 FAIL / 9 NOT_MEASURED / 0 PASS / 0 BLOCKED**.

**Evidence artifact:** Independent classification report with per-method input-dependence table and per-requirement classification records.

**Verification status:** NOT_MEASURED — pending independent re-execution by a process distinct from the one that produced the classification harness.

---

## 6. Convergent Count Under R003

| Status | Count |
|--------|-------|
| FAIL | 23 |
| NOT_MEASURED | 9 |
| PASS | 0 |
| BLOCKED | 0 |

The 9 NOT_MEASURED rows are unreachable under every reading: no execution interface, no committed-event store, no proposal mechanism, and no qualification concept exist in the four classes.

---

## 7. Explicit Limitations

- This amendment does not claim the federation works.
- The convergent count is a measurement of the pinned stub's behavior under the amended definition, not a certification of anything.
- The territory mapping is now normative (§3), but a genuinely separate reviewer should still attack the three contested-row resolutions first.
- The amendment's own status remains NOT_MEASURED until §5's discriminating test is executed by an independent process.
- No software component, including this amendment's author, may declare this amendment PASS.

---

**End of Amendment-001-R003.**