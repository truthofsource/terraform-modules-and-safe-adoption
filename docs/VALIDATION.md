# Local validation — November 6, 2026

Four Python reference checks and two Terraform mock cases passed. The mock composition keeps production/nonproduction instances distinct.

The local browser verified three overview cards, all tabs, explicitly fictional demonstration output and a 390px layout. There were zero page errors or external requests. The viewer was closed after capture.

The public two-environment composition is a reference. Real environments retain their own roots/state and commissioned inputs; no live state or cloud resource was accessed.

The ZAP project reuses the actual role-matrix evaluator with an in-memory probe and retains dated hosted context; it does not execute a new ZAP network scan. The Terraform reference uses mocked provider operations, not live state or Azure queries. The business-logic reference runs Node type stripping over pure extracted rules, not a full TypeScript/application build, verified JWT flow, SQL transaction or distributed concurrency test.

Only the relevant boundary applies to each project. No cloud activation, record write, state migration, credentials capture, hosted Actions run or new provider scan was performed. [Machine result](validation-results.json) distinguishes the checks. [Source mapping](SOURCE-MAP.md) records copied/extracted files and adaptations.
