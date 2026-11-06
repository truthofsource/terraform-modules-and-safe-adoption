import json,unittest,re
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
class ReferenceTests(unittest.TestCase):
    def test_actual_network_module_has_explicit_inputs(self):
        text=(ROOT/'infra/modules/network/variables.tf').read_text()
        for key in ['address_space','functions_subnet_prefixes','private_endpoints_subnet_prefixes']:self.assertIn('variable "'+key+'"',text)
    def test_storage_keeps_identity_and_network_controls(self):
        text=(ROOT/'infra/modules/storage/main.tf').read_text()
        for key in ['shared_access_key_enabled','allow_nested_items_to_be_public','public_network_access_enabled']:self.assertRegex(text,key+r'\s*=\s*false')
    def test_moves_are_reference_only(self):
        self.assertTrue((ROOT/'reference/adoption/moved.tf').exists());self.assertFalse((ROOT/'infra/moved.tf').exists())
    def test_adoption_map_is_retained(self):self.assertIsInstance(json.loads((ROOT/'reference/adoption/address-map.json').read_text()),dict)
