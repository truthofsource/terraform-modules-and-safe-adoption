# Reusable Terraform Modules and Safe Infrastructure Adoption

**Reuse the infrastructure pattern without replacing the resources that already run the business.**

[Business problem](#the-business-problem) · [Solution](#the-solution) · [Strengths](#engineering-strengths) · [Proof](#proof-it-works) · [Commands](docs/COMMANDS.md)

![Local implementation reference](docs/images/01-overview.png)

## The Business Problem

Production and nonproduction definitions had repeated network/storage patterns. Moving them into reusable modules needed to preserve names, resource IDs, access controls and state ownership while unrelated drift remained visible.

## The Solution

Extract explicit module inputs/outputs, compose the same modules with distinct environment values, retain reviewed address-move declarations and compare plans against a baseline. Validate the public reference with mocked providers rather than applying it.

**Business outcome:** The actual adoption work kept existing resource identities and separated module-address changes from preexisting worker drift. The public example demonstrates two environments using the actual network/storage modules without reading or changing live state.

## Engineering Strengths

| Strength | Practical value |
| --- | --- |
| **Consistent controls** | The same module supplies network delegation, storage privacy and diagnostic patterns across selected environments. |
| **Explicit contracts** | Inputs identify names, ranges, groups and destinations; outputs connect consumers without copying resource internals. |
| **Safer refactoring** | Reviewed address mapping and moved declarations help preserve resource identity when code layout changes. |

## Architecture

```mermaid
flowchart LR
  Inputs[Environment inputs / tags / identities] --> Root[Owning root and provider]
  Root --> NP[Nonproduction module instances]
  Root --> Prod[Production module instances]
  NP --> Modules[Actual network / storage modules]
  Prod --> Modules
  Moves[Reviewed moved-address map] --> Adoption[Existing resource identity preserved]
  Tests[Mocks / plan comparison] --> Adoption
```

This project is derived from actual workforce-platform implementation. Identifying labels/targets use examples. The local viewer and demonstration are new reference code; [source mapping](docs/SOURCE-MAP.md) identifies the copied/extracted files and limitations.

## What Was Built

| Component | Purpose | Implementation |
| --- | --- | --- |
| Actual network module | VNet, integration delegation, endpoint subnet and outputs | [Module](infra/modules/network/) |
| Actual storage module | Keyless/private configuration, containers, diagnostics and role inputs | [Module](infra/modules/storage/) |
| Two-environment public root | Reuse with different names/ranges under a default-Off wrapper | [Root](infra/main.tf) |
| Actual adoption references | Original address mapping and retained moved declarations | [Reference](reference/adoption/) |
| Local demonstration | Exercise actual rule/evaluation code using fictional data | [Demo](scripts/demo.py) |
| Dated context | Keep recorded implementation separate from new local evidence | [Context](data/history.json) |

## Proof It Works

### 1. Run focused checks

```bash
python -B -m unittest discover -s scripts -p 'test_*.py' -v
terraform -chdir=infra init -backend=false -input=false
terraform -chdir=infra validate
terraform -chdir=infra test
```

**Observed:** Four Python reference checks and two Terraform mock cases passed. The mock composition keeps production/nonproduction instances distinct. [Validation](docs/VALIDATION.md) records the exact scope and distinguishes pure/mock checks from hosted integration.

### 2. Inspect the decision output

![Working reference example](docs/images/02-example.png)

The output is explicitly fictional and exercises the included logic. A successful rule/mock result is not a completed real-world operation. The public two-environment composition is a reference. Real environments retain their own roots/state and commissioned inputs; no live state or cloud resource was accessed.

### 3. Open the reference viewer

```bash
python -B scripts/preview.py --port 8139
```

Open [the local reference](http://127.0.0.1:8139). Switch between Overview, Working example and Implementation context. Ctrl+C stops it. Screenshots are genuine local captures, not hosted application/Azure Portal screenshots.

## Modules, State and Existing Resources

A module is a reusable configuration boundary, not a separate state automatically. The owning root/backend determines state ownership. A resource moves in Terraform's address space when code moves under a module; its Azure identity can remain unchanged if the reviewed mapping preserves it.

The actual adoption references include moved declarations and an old-to-new address map. They are kept outside the executable public root: this repository has no matching live state, imports or commissioned values. Do not copy them into an unrelated environment and expect adoption to occur safely.

The recorded portal candidate showed two moved resources with no-op actions and unchanged Azure IDs. Preexisting worker drift was kept separate. A later reviewed state operation also recorded module addresses; that historical lesson is why state writes, source changes and resource mutations must be described separately. None was repeated here.

The same module definition does not mean production and nonproduction should share secrets, administrators or storage accounts. The reference passes explicit names/ranges/groups and reuses a fictional observation workspace only for mock composition. Real roots/providers/state remain separately owned.

[HashiCorp modules overview](https://developer.hashicorp.com/terraform/language/modules) explains reuse; [module refactoring](https://developer.hashicorp.com/terraform/language/modules/develop/refactoring) covers address moves.


## Operations, Limits and Growth

Keep the target, owning state/identity and evidence boundary explicit. Validate expected failures as well as success; do not let an incomplete result become a green indicator. Preserve private inputs and unrelated changes. Proposed scaling needs measured bottlenecks, cost review, downstream limits and repeated denied/recovery checks. [Operations and scaling](docs/OPERATIONS-AND-SCALING.md).

## Project Guides

| Guide | Purpose |
| --- | --- |
| [Implementation](docs/IMPLEMENTATION.md) | Rules, boundaries and actual source design |
| [Commands](docs/COMMANDS.md) | Local tests, expected output and inspection |
| [Operations and scaling](docs/OPERATIONS-AND-SCALING.md) | Strengths, weaknesses, costs and growth |
| [Source map](docs/SOURCE-MAP.md) | Actual files and public adaptations |
| [Validation](docs/VALIDATION.md) | Observed local evidence and remaining integration scope |

No Azure service, business record or live state was changed. The public validation workflow is manual-only and was not dispatched, conserving hosted Actions minutes.
