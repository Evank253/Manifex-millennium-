# MANIFEX-MILLENNIUM-FEDERATION-SPECIFICATION-AMENDMENT-001-R002

**Status:** DRAFT / NOT_MEASURED
**Version:** 0.2 (supersedes Amendment-001-R001)
**Date:** 2026-10-14
**Amends:** MANIFEX-MILLENNIUM-FEDERATION-VERIFICATION-SPECIFICATION-001, Section 2 (Required Specification Structure) and Section 7 (Implementation Gate)
**Authority:** External Human Authority only
**Prepared for review:** Independent reviewer, no stake in the outcome

---

## 1. Purpose

Amendment-001-R001 defined whether an unconditional false success claim counts as FAIL or NOT_MEASURED. An independent re-execution of its discriminating test (§5) produced three counts, not one — strict 24 FAIL, principled 23 FAIL, conservative 18 FAIL — a divergence of six tests. The amendment failed its own pass condition and remained NOT_MEASURED.

This revision (R002) incorporates the three edits identified by that re-execution:

1. **Fix R001's test-procedure wording** — the literal wording classified every deterministic function as an unconditional success claim, including correct implementations. This would have failed correct code and could not serve as a gate.
2. **Add a control-sufficiency clause** — resolves the six-test divergence by making the classification empirical rather than a per-row judgment.
3. **Correct §4 arithmetic errors** — unit-mixing and misreported probe tallies.

With these edits, the amendment's own discriminating test becomes reproducible by construction: a single convergent count of **23 FAIL / 9 NOT_MEASURED / 0 PASS / 0 BLOCKED**.

---

## 2. Normative Definition — Unconditional Success Claims

### Amendment-001-R002-R001 (supersedes Amendment-001-R001)

**Statement:** A method that returns a success-denoting status — including but not limited to `authenticated: true`, `status: verified`, `sync_status: SUCCESS`, `network_consensus: UNIFIED_GLOBAL_STATE`, or `IN_SYNC` — without consulting any input-dependent condition, evidence record, or authorization check, is making an affirmative claim the specification forbids without evidence.

**Rationale:** The re-execution exposed a measurement-boundary question: the runner reported NOT_MEASURED where no interface existed to test a requirement, while the independent probe reported FAIL where the API returned success unconditionally. Two honest reviewers produced different counts for the same code. The boundary must be defined normatively so that classification is empirical, not arguable.

**Test procedure:** For each public method, execute it across a set of inputs that differ in the dimensions the specification cares about — signature validity, evidence presence, membership status, and authorization scope. Record the success-denoting status values returned.

- If **every** input produces the same success status — that is, the status is **invariant across inputs that differ** in signature validity, evidence presence, membership status, or authorization scope — classify the method as an **unconditional success claim**.
- If the success status varies across those inputs, classify the method as **conditional**.
- If the method returns no success-denoting status, classify it as **no success claim**.

**Expected result:** Methods classified as unconditional success claims are recorded as such, with the input set and observed status values preserved as evidence.

**Evidence artifact:** Per-method input-dependence table: method name, success field(s), distinct status values across the input set, classification.

**Failure behavior:** A method classified as an unconditional success claim is recorded as an affirmative false claim. Requirements whose subject matter is covered by that claim are classified FAIL under the control-sufficiency clause (Amendment-001-R002-R002).

**Verification status:** NOT_MEASURED

**Dependencies:** None

**Soundness note:** The test procedure distinguishes **input-invariance** (the property that indicates a stub) from **repeatability** (a property of all deterministic code). A correct conditional implementation — e.g., an HMAC verifier that returns `authenticated: True` for a valid signature and `authenticated: False` for an invalid one — produces distinct status values across differing inputs and classifies as CONDITIONAL. The literal wording of Amendment-001-R001 would have misclassified such an implementation as UNCONDITIONAL_SUCCESS; this revision does not.

---

## 3. Control-Sufficiency Clause

### Amendment-001-R002-R002

**Statement:** A control exercises a requirement only where the implementation makes an affirmative success claim covering the requirement's subject matter.

- Where a public method returns a success status covering that subject matter, the requirement is **FAIL** if that status is unconditional — the requirement's specific discriminating parameter need not exist, because the claim is already being made falsely.
- Where no public method makes any claim covering that subject matter, the requirement is **NOT_MEASURED**.

**Rationale:** Six tests in the re-execution diverged solely on whether a control that exists but cannot carry the requirement's discriminating input counts as "no corresponding control." The strict reading said FAIL; the conservative reading said NOT_MEASURED. This clause removes the per-row judgment: the question is empirical — does the code claim anything in this territory? — and is answerable without interpretation.

**Test procedure:** For each requirement, determine whether any public method makes an affirmative success claim covering its subject matter. Apply Amendment-001-R002-R001 to classify that claim. Apply this clause to assign the requirement's status.

**Expected result:** A single convergent count across independent reviewers executing the same measurement.

**Evidence artifact:** Per-requirement classification record: subject matter, covering method(s), claim classification, assigned status, rationale.

**Failure behavior:** A requirement assigned FAIL under this clause is recorded as an observed false claim, not a missing measurement.

**Verification status:** NOT_MEASURED

**Dependencies:** Amendment-001-R002-R001

---

## 4. Corrections to Prior Reporting

The following corrections apply to Amendment-001-R001 and to the Federation Handover Review §3 and §4:

1. **"14 additional FAILs" is withdrawn.** It mixed units: 17 counted probe *instances* while 3 counted runner *test IDs*. Measured from the artifacts: runner FAIL test IDs = 3 (T-AUTH-001, T-AGREE-003, T-EVID-003); probe instances = 17; probe distinct test IDs = 15; overlap (runner ∩ probe) = 2 (T-AGREE-003, T-EVID-003); newly-FAIL distinct test IDs = 13; union of distinct FAIL IDs = 16. The correct statement is: **13 additional distinct test IDs, 16 in total** — not 14.

2. **"The probe's 17 FAIL / 15 NOT_MEASURED" is withdrawn.** The probe reported `{"FAIL": 17}` — 17 FAIL, **0 NOT_MEASURED**. The 15 was the count of distinct test IDs those 17 probes spanned, not a NOT_MEASURED tally.

3. **The handover's "32 FAIL" claim remains refuted.** Under all readings — 24 (strict), 23 (principled), 18 (conservative) under R001, and 23 under R002 — none equals 32. The frozen matrix's own wording ("expected to report FAIL or NOT_MEASURED") was correct; the handover's conversion of that disjunction into a single number was not.

---

## 5. Discriminating Test

**Statement:** Any claim that the measurement boundary is now resolved requires an independent execution under the amended definition producing a single convergent count.

**Test procedure:** An independent process, in a separate environment with no stake in the outcome, executes the input-dependence measurement (Amendment-001-R002-R001) and the test-level classification (Amendment-001-R002-R002) against the pinned baseline revision (Global-Intelligence at 754fb1ff22da0de58ec4db525f137d09a06ae75a) and reports the resulting counts.

**Expected result:** A single count of **23 FAIL / 9 NOT_MEASURED / 0 PASS / 0 BLOCKED**, reproducible by construction.

**Evidence artifact:** Independent classification report with per-method input-dependence table and per-requirement classification records.

**Verification status:** NOT_MEASURED — pending independent re-execution by a process distinct from the one that produced the classification harness.

---

## 6. Convergent Count Under R002

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
- The territory mapping between requirements and method subject matter is a construction; a genuinely separate reviewer should attack it first.
- The amendment's own status remains NOT_MEASURED until §5's discriminating test is executed by an independent process.
- No software component, including this amendment's author, may declare this amendment PASS.

---

**End of Amendment-001-R002.**