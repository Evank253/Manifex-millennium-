# MANIFEX MILLENNIUM — Federation Inventory and Harness Audit Checklist 001

**Status:** EXECUTABLE AUDIT PLAN / OBSERVATIONS NOT CERTIFICATION  
**Prepared:** 2026-10-14  
**Purpose:** Establish the actual artifact population before Arena or any other evaluator compares Track A and Track B. Explicitly detect table-walking/counting harnesses that never execute implementation methods.

> **Blind-execution warning:** This inventory contains the R003 table's actual classification tally and its printed expected tally. Do **not** give this document to the process intended to perform a blind R004 execution before that process completes and seals its blind report. Use `MANIFEX-BLIND-EXECUTION-PACKAGE-001.md` alone for the blind run. This document is for the subsequent inventory and measurement-system audit; it is not itself a blind package.

## 1. Pinned artifacts and provenance

| Artifact | Ref | SHA / identifier | What it establishes |
|---|---|---|---|
| Frozen baseline | `Python-3` at `0fdb465382a0104ed7ae9870b0a5df4325575fbf` | immutable commit | Baseline scope |
| Frozen test matrix | same frozen commit | Git blob `5568396eb0e39ab5c927bd80051f701aa3bd3aeb` | 32-row baseline matrix |
| Frozen verification specification | same frozen commit | Git blob `a1d16c557b447c60ea40575f94d202721800b781` | Requirement definitions in baseline |
| Primordial rule | same frozen commit | Git blob `b7114eaccd9c6e3bb0beaf70f744d7bd9cde52af` | Human Authority boundary |
| Amendment R003 | `amendment-001-r002` at commit `ea31e0b751702d5412f9fb705e1323a12068a53e` | Git blob `19b37de08a6a4a55893b2a0dc154044e985b93bc` | Normative territory table and disputed expected count |
| Amendment R002 | same amendment branch/commit | Git blob `80794b821067900d10f5ab4f132f1d2e10857037` | Predecessor amendment |
| Blind execution package | same amendment branch/commit | Git blob `84d7b5e474865d06e3457f4ea82b5b17227fca01` | Separate blind execution instructions |
| Federation implementation | `Evank253/Global-Intelligence` at `754fb1ff22da0de58ec4db525f137d09a06ae75a` | pinned commit | Code under test |

These refs are separate on purpose. The existence of R003 on the amendment branch does not mean it was part of the frozen `Python-3` baseline.

## 2. Inventory findings — source-level, not runtime certification

### Frozen matrix
- Actual test rows: **32**.
- IDs: 22 protocol-specific rows plus the 10 invariant rows.
- All 32 matrix IDs also occur in R003's normative territory table.

### R003 normative territory table
- Actual table rows: **42**.
- Of those, **32 IDs overlap** the frozen matrix.
- **10 R003-only IDs** are absent from the frozen matrix.
- No frozen-matrix test ID is absent from R003's table.

| R003-only test ID | Requirement ID cited by R003 | Subject matter in R003 | Covering method in R003 |
|---|---|---|---|
| T-AUTH-008 | FED-AUTH-001-R008 | Authentication refusal | authenticate_peer |
| T-AGREE-006 | FED-AGREE-001-R006 | Quorum enforcement | sync_federation |
| T-AGREE-007 | FED-AGREE-001-R007 | Agreement finality | sync_federation |
| T-AGREE-008 | FED-AGREE-001-R008 | Consensus without quorum | sync_federation |
| T-EVID-005 | FED-EVID-001-R005 | Evidence integrity | register |
| T-EVID-006 | FED-EVID-001-R006 | Negative results | register |
| T-EVID-007 | FED-EVID-001-R007 | Evidence provenance | register |
| T-EVID-008 | FED-EVID-001-R008 | Evidence tampering | register |
| T-EXEC-003 | FED-EXEC-001-R003 | Execution rollback | (none) |
| T-EXEC-004 | FED-EXEC-001-R004 | Execution scope | (none) |

**Interpretation:** These ten rows are not inventions of the dual-track experiment. R003 already cites them, but the frozen 32-row matrix does not contain them and the frozen specification does not fully define these cited R008/R006/R007/R003/R004 requirements as executable requirement bodies. Track B's task is to formalize and test the amendment-cited scope; its additions must be labelled amendment-derived and not part of frozen-baseline conformance.

### R003's internal count contradiction
Counting the literal `Classification` column in R003's 42-row table yields:
- `FAIL`: **29**
- `NOT_MEASURED`: **13**
- `PASS`: **0**
- `BLOCKED`: **0**

The same R003 artifact prints **23 FAIL / 9 NOT_MEASURED / 0 PASS / 0 BLOCKED** as its expected and convergent count. Those values sum to 32, not 42, and do not match the table's row-by-row labels. The 10-row difference is exactly the R003-only row population. This is a document-level arithmetic/scope defect, not a runtime measurement of the federation.

Do not silently choose one tally. Preserve both as distinct observations:
1. **Literal table classification tally:** 29 / 13 / 0 / 0 across 42 rows.
2. **Printed R003 expected tally:** 23 / 9 / 0 / 0 across 32 rows.
The discrepancy must be recorded and resolved through a versioned decision; no frozen source is edited by this checklist.

## 3. Track rules after inventory

### Track A — frozen-scope measurement
- Population: exactly the 32 IDs in the frozen matrix.
- R003-only rows are excluded from Track A's frozen-scope denominator, but must be listed as amendment scope not represented in the frozen baseline.
- Do not describe the R003-only rows as nonexistent; they exist in R003.
- Report per-row status and denominator.

### Track B — amendment-derived formalization
- Keep the same 32-row frozen baseline separately identifiable.
- Add the ten R003-only rows listed above as a distinct amendment-derived population.
- Give each a complete operational definition: requirement statement, preconditions, procedure, acceptance criterion, evidence artifact, failure behavior, and status.
- Do not call the ten rows newly invented. State that R003 already cites them, while the experiment formalizes their missing executable detail.
- Report baseline results and amendment-derived results separately. A combined 42-row count may be shown only with both populations and their provenance explicit.

## 4. Harness-execution audit — mandatory

The audit must explicitly detect whether the harness invoked the implementation or merely walked a table.

### Execution-mode vocabulary
Every test result must include one of:
- `BEHAVIORAL_EXECUTION`: the relevant implementation method was invoked with recorded inputs and its return value or exception was captured.
- `SOURCE_INSPECTION`: source/API inspection only; no claim that runtime behavior was exercised.
- `TABLE_DERIVATION`: a result/count was derived by parsing or tallying table cells; this is not a behavioral test.
- `BLOCKED`: the harness attempted valid execution but infrastructure or setup prevented a determination.

### Minimum evidence for a behavioral result
For every row classified as `BEHAVIORAL_EXECUTION`, preserve:
1. Test ID and requirement ID.
2. Exact implementation commit and relevant source blob hashes.
3. Method actually invoked (not merely the method named in a table).
4. Input fixture or a privacy-safe canonical representation/hash.
5. Invocation counter, trace, or equivalent evidence proving the call occurred.
6. Raw return value or exception, captured before classification.
7. Timestamp, runtime version, dependencies, command, and exit code.
8. Mapping from the raw observation to the acceptance criterion and final status.

A parsed row, loop iteration, generated test label, source signature, or hardcoded status does **not** prove that implementation code executed.

### Automatic audit failures
Record a **measurement-system defect** if any of the following occurs:
- The harness reports a behavioral result without a corresponding method invocation record.
- The harness only counts cells, parses prewritten classifications, or assigns statuses from row text.
- It labels a row PASS without exercising the acceptance condition.
- It hardcodes the expected total into the test logic.
- It reports test rows executed when only table rows were iterated.
- It fails to distinguish source inspection from runtime execution.
- It cannot tie a result back to raw input/output evidence.

If the harness itself crashes or the environment prevents valid execution, mark the affected run `BLOCKED`; do not convert infrastructure failure into product FAIL.

## 5. Status adjudication rules

- **FAIL:** Observed behavior violates a stated acceptance criterion, including an affirmative success claim that the governing rule explicitly defines as false/unconditional.
- **NOT_MEASURED:** No adequate behavioral observation supports PASS or FAIL, or no public method makes a claim covering the requirement's subject matter under the applicable control-sufficiency rule. Explain which condition applies.
- **PASS:** The relevant behavior was exercised, the required condition was observed, and the evidence supports the acceptance criterion. Source inspection or table-derived status alone cannot earn PASS.
- **BLOCKED:** A valid determination was prevented by the harness/environment. State the blocking cause.
- A method's lack of an interface may be evidenced by source inspection, but source inspection must not be reported as runtime behavioral execution.
- A status string returned by the implementation is an observation; it is not proof that the status is true.

## 6. Arena execution procedure

1. **Before opening expected-count-bearing material:** If performing R004's blind execution, run only the blind package in a clean, separate environment, do not inspect R003's expected count, and seal the raw report before continuing. This inventory document is not part of the blind input.
2. Fresh-clone both repositories and check out the exact pinned commits listed in §1.
3. Verify source blobs and record all mismatches; do not trust a runner's self-reported hashes without independently computing them.
4. Parse the frozen matrix and R003 table independently. Emit their full ID sets, counts, overlap, and set differences.
5. Reproduce the literal R003 Classification-column tally and separately record the printed expected tally.
6. Inspect the harness source. For every test ID, identify its execution mode and the exact code path it invokes.
7. Run the harness. Capture invocation traces and raw outputs. A run that only walks the table must fail the harness-execution audit even if its arithmetic is correct.
8. Produce per-row results, per-population counts, measurement-system findings, and environment details.
9. Have a separate process independently reproduce the inventory and behavioral results. Record independence limitations; do not claim that a separate process is a separate implementation.
10. Preserve all outputs append-only and leave frozen branches untouched.

## 7. Required Arena report

Arena must return:
- Pinned revisions and independently verified hashes.
- Frozen matrix row count, R003 row count, ID overlap and exact differences.
- Literal R003 table tally and printed R003 expected tally, with the contradiction explicitly preserved.
- For every test: execution mode, method invoked (if any), raw observation pointer, status, and rationale.
- Harness execution proof and any table-walking/cell-counting defect.
- Track A and Track B results with separate denominators.
- Reproduction results and independence disclosures.
- `NOT_MEASURED` for every claim the evidence does not resolve.
- No qualification, certification, or Human Authority claim.

**Current disposition:** Inventory findings above are source-derived and reproducible from the pinned artifacts. The federation behavior has not been re-executed by this document. The experiment remains NOT_MEASURED pending valid behavioral runs and independent reproduction.
