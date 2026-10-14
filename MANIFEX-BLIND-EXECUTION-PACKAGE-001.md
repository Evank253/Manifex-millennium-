# MANIFEX-BLIND-EXECUTION-PACKAGE-001

**Status:** BLIND EXECUTION PACKAGE
**Date:** 2026-10-14
**Governing document:** Amendment-001-R004 (amendment-001-r002 branch, supersedes R001–R003)
**Prepared for:** Independent reviewer, no stake in the outcome

---

## Instructions to the executing process

1. **Do NOT read any expected count before writing or running your harness.** No expected count appears in this document. Deriving the count is your job, not your input.
2. Apply the Normative Territory Table in §3 as written. No construction, no judgment calls beyond the table.
3. Include the **soundness check**: R004-R001's input-invariance wording must classify a correct HMAC verifier as **CONDITIONAL** and the stub as **UNCONDITIONAL_SUCCESS**. Under R001's repeatability wording, the correct verifier would have been misclassified — confirm R004 fixes that.
4. Report your count, your harness, and whether you had access to any expected count before execution. Access to an expected count means the run does **not** satisfy §5, regardless of the count it produces.
5. Do not merge anything. Do not modify the frozen Python-3 baseline. Your output is observation only — not certification, not ratification.

---

## 1. Purpose

This package executes Amendment-001-R004's discriminating test (§5) without contaminating the reviewer with the expected answer. R003's table contained 42 rows while asserting 23/9 — a self-contradiction Arena AI's execution exposed. R004 corrects the expected count and makes blind execution normative (R004-R004).

---

## 2. Normative Definitions

### R004-R001 — Unconditional Success Claim (supersedes R003-R001)

**Statement:** A method makes an unconditional success claim if its success status is **invariant across inputs that differ** in signature validity, evidence presence, membership status, or authorization scope.

**Rationale:** This tests input-invariance, not repeatability — a property of all deterministic code. A correct conditional implementation — e.g., an HMAC verifier that returns `authenticated: True` for a valid signature and `authenticated: False` for an invalid one — produces distinct status values across differing inputs and classifies as CONDITIONAL.

**Test procedure:** For each public method, execute it across a set of inputs that differ in the dimensions the specification cares about — signature validity, evidence presence, membership status, and authorization scope. Record the success-denoting status values returned.

- If **every** input produces the same success status — that is, the status is **invariant across inputs that differ** in signature validity, evidence presence, membership status, or authorization scope — classify the method as an **unconditional success claim**.
- If the success status varies across those inputs, classify the method as **conditional**.
- If the method returns no success-denoting status, classify the method as **no success claim**.

**Expected result:** Methods classified as unconditional success claims are recorded as such, with the input set and observed status values preserved as evidence.

**Evidence artifact:** Per-method input-dependence table: method name, success field(s), distinct status values across the input set, classification.

**Failure behavior:** A method classified as an unconditional success claim is recorded as an affirmative false claim. Requirements whose subject matter is covered by that claim are classified FAIL under the control-sufficiency clause (R004-R002).

**Verification status:** NOT_MEASURED

**Dependencies:** None

**Soundness note:** The test procedure distinguishes **input-invariance** (the property that indicates a stub) from **repeatability** (a property of all deterministic code). The literal wording of Amendment-001-R001 would have misclassified a correct conditional implementation as UNCONDITIONAL_SUCCESS; this revision does not.

---

### R004-R002 — Control Sufficiency (supersedes R003-R002)

**Statement:** A control exercises a requirement only where the implementation makes an affirmative success claim covering the requirement's subject matter.

- Where a public method returns a success status covering that subject matter, the requirement is **FAIL** if that status is unconditional — the requirement's specific discriminating parameter need not exist, because the claim is already being made falsely.
- Where no public method makes any claim covering that subject matter, the requirement is **NOT_MEASURED**.

**Rationale:** Six tests in the re-execution diverged solely on whether a control that exists but cannot carry the requirement's discriminating input counts as "no corresponding control." The strict reading said FAIL; the conservative reading said NOT_MEASURED. This clause removes the per-row judgment: the question is empirical — does the code claim anything in this territory? — and is answerable without interpretation.

**Test procedure:** For each requirement, determine whether any public method makes an affirmative success claim covering its subject matter. Apply R004-R001 to classify that claim. Apply this clause to assign the requirement's status.

**Expected result:** A single convergent count across independent reviewers executing the same measurement.

**Evidence artifact:** Per-requirement classification record: subject matter, covering method(s), claim classification, assigned status, rationale.

**Failure behavior:** A requirement assigned FAIL under this clause is recorded as an observed false claim, not a missing measurement.

**Verification status:** NOT_MEASURED

**Dependencies:** R004-R001

---

### R004-R003 — Normative Territory Mapping

**Statement:** The mapping from requirements to method subject matter is defined by the Normative Territory Table in §3. A reviewer applies this table; no construction is permitted. Where a row's covering method makes an unconditional success claim covering the row's subject matter, the requirement is FAIL. Where no method claims anything in that territory, the requirement is NOT_MEASURED.

**Rationale:** Under R002 the rule was reproducible but the count was ±3 because three rows were contestable. Folding the mapping into the amendment as a frozen table makes §5 mechanical: any reviewer executes the table and gets one number without constructing anything.

**Test procedure:** Execute §3 row by row against the pinned baseline. Record each row's assigned status with its covering method and claim classification.

**Expected result:** (not stated — derive from the table)

**Evidence artifact:** Completed table with per-row status, covering method, and rationale.

**Failure behavior:** Any row assigned a status other than the table's classification is recorded as a divergence with the specific test ID and both readings.

**Verification status:** NOT_MEASURED

**Dependencies:** R004-R001, R004-R002

---

### R004-R004 — Blind Execution

**Statement:** A discriminating test under §5 must be executed by a process that has not read the expected count before writing or running its harness. The harness must be blind by construction — it reads only the table, encodes no expected value. The executing process must disclose whether it had access to the expected count before execution. Access to the expected count means the execution does not satisfy §5, regardless of the count it produces.

---

## 3. Normative Territory Table

| Test ID | Requirement | Subject Matter | Covering Method |
|---------|------------|----------------|-----------------|
| T-AUTH-001 | FED-AUTH-001-R001 | Peer authentication | authenticate_peer |
| T-AUTH-002 | FED-AUTH-001-R002 | Authorization scope | authenticate_peer |
| T-AUTH-003 | FED-AUTH-001-R003 | Revocation / effective time | authenticate_peer |
| T-AUTH-004 | FED-AUTH-001-R004 | Human authority flag | authenticate_peer |
| T-AUTH-005 | FED-AUTH-001-R005 | Signature validity | authenticate_peer |
| T-AUTH-006 | FED-AUTH-001-R006 | Caller-supplied identity | authenticate_peer |
| T-AUTH-007 | FED-AUTH-001-R007 | Replay protection | authenticate_peer |
| T-AUTH-008 | FED-AUTH-001-R008 | Authentication refusal | authenticate_peer |
| T-AGREE-001 | FED-AGREE-001-R001 | Duplicate vote counting | sync_federation |
| T-AGREE-002 | FED-AGREE-001-R002 | Conflicting participants | sync_federation |
| T-AGREE-003 | FED-AGREE-001-R003 | Zero-participant consensus | sync_federation |
| T-AGREE-004 | FED-AGREE-001-R004 | Unregistered participants | sync_federation |
| T-AGREE-005 | FED-AGREE-001-R005 | Proposal digest binding | sync_federation |
| T-AGREE-006 | FED-AGREE-001-R006 | Quorum enforcement | sync_federation |
| T-AGREE-007 | FED-AGREE-001-R007 | Agreement finality | sync_federation |
| T-AGREE-008 | FED-AGREE-001-R008 | Consensus without quorum | sync_federation |
| T-EVID-001 | FED-EVID-001-R001 | Evidence boundary | register |
| T-EVID-002 | FED-EVID-001-R002 | Self-declared capability | discover |
| T-EVID-003 | FED-EVID-001-R003 | Verification record | register |
| T-EVID-004 | FED-EVID-001-R004 | Silent overwrite | register |
| T-EVID-005 | FED-EVID-001-R005 | Evidence integrity | register |
| T-EVID-006 | FED-EVID-001-R006 | Negative results | register |
| T-EVID-007 | FED-EVID-001-R007 | Evidence provenance | register |
| T-EVID-008 | FED-EVID-001-R008 | Evidence tampering | register |
| T-LEDGER-001 | FED-LEDGER-001-R001 | Chain integrity | synchronize_delta |
| T-LEDGER-002 | FED-LEDGER-001-R002 | Fork detection | synchronize_delta |
| T-LEDGER-003 | FED-LEDGER-001-R003 | Partial failure recovery | synchronize_delta |
| T-LEDGER-004 | FED-LEDGER-001-R004 | Ledger tampering | synchronize_delta |
| T-EXEC-001 | FED-EXEC-001-R001 | Execution authorization | (none) |
| T-EXEC-002 | FED-EXEC-001-R002 | Execution audit | (none) |
| T-EXEC-003 | FED-EXEC-001-R003 | Execution rollback | (none) |
| T-EXEC-004 | FED-EXEC-001-R004 | Execution scope | (none) |
| T-INV-01 | INV-01 | Authentication refusal | authenticate_peer |
| T-INV-02 | INV-02 | Constitutional supremacy | (none) |
| T-INV-03 | INV-03 | Claim-status vs signature | authenticate_peer |
| T-INV-04 | INV-04 | Evidence-level substitution | (none) |
| T-INV-05 | INV-05 | Human authority external | (none) |
| T-INV-06 | INV-06 | Qualification status | (none) |
| T-INV-07 | INV-07 | Reversibility | (none) |
| T-INV-08 | INV-08 | Lineage preservation | (none) |
| T-INV-09 | INV-09 | Scope control | (none) |
| T-INV-10 | INV-10 | Independent verification | (none) |

### Contested Rows — Flagged for Attack

**T-EVID-002:** `discover` is the only NOT_MEASURED row with a named covering method. Every other NOT_MEASURED row has `(none)`. This is coherent under R004-R002 only if `discover` makes no affirmative claim over self-declared capability — which the absent baseline cannot verify from this table alone. A reviewer should attack this row first.

**T-LEDGER-001:** `synchronize_delta` claims IN_SYNC about a state hash. Does that cover chain integrity (predecessor digests, committed events)?

**T-LEDGER-002:** Does IN_SYNC cover fork detection?

**T-INV-06:** No qualification field exists. Is the *absence* the violation, or is it simply no claim?

---

## 4. Scope Rule

All 42 rows in §3 are in scope. No row is excluded. Any execution that reports a different row count, or that excludes rows without citing a scope rule, is not executing R004.

---

## 5. Discriminating Test

**Statement:** Any claim that the measurement boundary is now resolved requires an independent execution under this definition producing a single convergent count.

**Test procedure:** An independent process, in a separate environment with no stake in the outcome, executes the input-dependence measurement (R004-R001) and the test-level classification (R004-R002, R004-R003) against the pinned baseline revision (Global-Intelligence at 754fb1ff22da0de58ec4db525f137d09a06ae75a) and reports the resulting counts. The executing process must be distinct from the one that produced the classification harness, must not have read the expected count before writing or running its harness, and must derive its mapping solely from this table.

**Evidence artifact:** Independent classification report with per-method input-dependence table and per-requirement classification records.

**Verification status:** NOT_MEASURED — pending independent re-execution by a process distinct from the one that produced the classification harness.

---

## 6. Explicit Limitations

- This package does not claim the federation works.
- The convergent count is a measurement of the pinned stub's behavior under the amended definition, not a certification of anything.
- The territory mapping is normative (§3), but a genuinely separate reviewer should still attack the contested-row resolutions first.
- This package's own status remains NOT_MEASURED until §5's discriminating test is executed by an independent, blind process.
- No software component, including this package's author, may declare this amendment PASS.

---

**End of Blind Execution Package-001.**