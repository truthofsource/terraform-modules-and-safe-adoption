# Implementation and boundaries

## Modules, State and Existing Resources

A module is a reusable configuration boundary, not a separate state automatically. The owning root/backend determines state ownership. A resource moves in Terraform's address space when code moves under a module; its Azure identity can remain unchanged if the reviewed mapping preserves it.

The actual adoption references include moved declarations and an old-to-new address map. They are kept outside the executable public root: this repository has no matching live state, imports or commissioned values. Do not copy them into an unrelated environment and expect adoption to occur safely.

The recorded portal candidate showed two moved resources with no-op actions and unchanged Azure IDs. Preexisting worker drift was kept separate. A later reviewed state operation also recorded module addresses; that historical lesson is why state writes, source changes and resource mutations must be described separately. None was repeated here.

The same module definition does not mean production and nonproduction should share secrets, administrators or storage accounts. The reference passes explicit names/ranges/groups and reuses a fictional observation workspace only for mock composition. Real roots/providers/state remain separately owned.

[HashiCorp modules overview](https://developer.hashicorp.com/terraform/language/modules) explains reuse; [module refactoring](https://developer.hashicorp.com/terraform/language/modules/develop/refactoring) covers address moves.


The public two-environment composition is a reference. Real environments retain their own roots/state and commissioned inputs; no live state or cloud resource was accessed.
