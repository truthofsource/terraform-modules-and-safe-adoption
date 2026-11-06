# Commands and expected output

Run from the project root:

```bash
python -B -m unittest discover -s scripts -p 'test_*.py' -v
terraform -chdir=infra init -backend=false -input=false
terraform -chdir=infra validate
terraform -chdir=infra test
```

Four Python reference checks and two Terraform cases using simulated responses passed. The mock composition keeps production/nonproduction instances distinct.

```bash
python -B scripts/preview.py --port 8139
```

Open http://127.0.0.1:8139. Ctrl+C stops the loopback-only viewer. Use Python 3.12.

Use Terraform 1.11 or later. Initialization verifies signed provider packages; tests using simulated cloud responses use fictional inputs and no cloud account/backend/apply. Do not use this composition to reconcile existing state. In Azure Portal, resource IDs and current settings can support a later approved comparison, but the owning Terraform plan/state must still be reviewed; no portal inventory was performed here.
