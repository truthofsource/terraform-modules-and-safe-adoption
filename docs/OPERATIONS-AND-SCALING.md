# Strengths, weaknesses, operations and scaling

Measure plan/refresh duration, module consumer count, changes by environment and provider upgrade friction. Split state by genuine lifecycle/ownership boundaries rather than automatically creating a new state for every module. Pin external module versions/providers and review changelogs, lockfiles and consumer tests together.

Strength: consistent reusable controls and explicit input/output contracts. Weakness: a shared module change can affect many consumers. Tradeoff: too many switches make a module hard to reason about; too few force copy/paste exceptions. Keep deliberate environment differences visible and test representative combinations.

Before adoption, capture a protected state backup and compare current baseline/candidate IDs/actions/output values. A moved declaration is not an Azure rename or copy. A refresh/state write needs its own scope and can record address changes; preserve the exact operation/result. Separate unrelated drift instead of including it in a refactor apply. Never delete old ownership definitions before proving their new state addresses.

No cloud capacity, schedule, rate limit or paid service was changed for this project. Manual-only reference CI avoids automatic hosted-minute use.
