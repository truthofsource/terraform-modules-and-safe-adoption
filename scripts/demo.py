"""Inspect the selected public adoption map, not Terraform state."""
from pathlib import Path
import json
ROOT=Path(__file__).resolve().parents[1]
def demo():
    data=json.loads((ROOT/'reference/adoption/address-map.json').read_text())
    return {'fixture':True,'sourceMapKeys':list(data),'networkModule':'Same module, different environment inputs','storageModule':'Same controls, explicit groups/log destination','adoption':'Moved addresses require exact live-ID and plan evidence','stateRead':False,'cloudApplied':False}
if __name__=='__main__':print(json.dumps(demo(),indent=2))
