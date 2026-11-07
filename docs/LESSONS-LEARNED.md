# Troubleshooting lessons from the actual platform

These are historical engineering incidents summarized from maintained internal records. They are not newly reproduced tests, a fresh cloud inventory or instructions to repeat a consumed operation. Names, resource identifiers, private payloads and credentials are excluded.

## A failed Terraform apply had already created resources

**What happened.** The first production foundation apply partially succeeded before reporting failure.

**What the evidence showed.** The recovery record distinguished completed resource addresses from concrete failed blockers. The original saved plan no longer represented an untouched starting point.

**What changed and how it was checked.** Operators inspected achieved state, removed temporary privilege when safe and produced a fresh read-only reconciliation plan. They corrected the actual blockers and continued from the resulting state rather than recreating successful resources or replaying a consumed plan.

**What to carry forward.** A failing local command does not prove that no mutation happened. Preserve state and receipts, reconcile the achieved result, and separate unrelated drift from the remaining approved change.

Source record: `docs/troubleshooting/layer-42k-production-foundation-recovery.md — Partial apply; historical foundation record`. These internal paths identify provenance; they are not public file links.

## A narrow apply introduced an unrelated legacy setting

**What happened.** A settings reconciliation added a plain AzureWebJobsStorage setting that was absent before the operation.

**What the evidence showed.** The unexpected addition was established by comparing the actual before/after runtime settings. A normalized Terraform view alone was not enough to establish that the keyless runtime configuration had been preserved.

**What changed and how it was checked.** A separately scoped restoration removed only the proven addition and read back the keyless values while preserving the approved changes and other settings. The recorded response did not use a broad apply, account-key fallback or expanded runtime permissions.

**What to carry forward.** Validate achieved service state as well as the proposed plan. Preserve exact preimages and distinguish absent, empty, false and unknown values according to the specific field; do not generalize a one-field repair into blanket ignores.

Source record: `docs/troubleshooting/employee-badge-photos.md — Production preparation and rollback; docs/troubleshooting/stage2-processor-host-storage-authentication.md`. These internal paths identify provenance; they are not public file links.

## Evidence and project boundaries

The local examples and screenshots in this repository remain separate from the dated hosted incidents above. A new documentation summary does not establish another successful deployment, restore, security scan or business transaction. Follow the repository’s existing validation guide for the commands and limits of the runnable reference.

The practical sequence is: identify the failing boundary, preserve safe correlation evidence, reconcile any uncertain result, apply only the relevant repair and verify the resulting state. A completed local command is not interchangeable with a completed cloud operation.
