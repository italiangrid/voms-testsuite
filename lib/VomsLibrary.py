import re
import unittest

valid_fqan_regexp = re.compile(r"^(/[a-zA-Z0-9_-]+)+|((/[a-zA-Z0-9_-]+)+/)(Role=[\w-]+)$")

valid_fqan2_regexp = re.compile(r"^(/[a-zA-Z0-9_\-.]+?)(/Role=[a-zA-Z0-9_\-.]+)??$", re.DEBUG)

extract_vo_name_regexp = re.compile(r"^\/([\wx.-]+)\/?")

def is_valid_fqan(fqan):
	## Strip null stuff
	fqan=re.sub(r'/Capability=.*$','',fqan)
	print fqan
	fqan=re.sub(r'/Role=NULL','',fqan)
	
	starts_with_role = re.compile(r"^/Role=.*$").match(fqan)
	
	if starts_with_role:
		return False
		

	match = valid_fqan2_regexp.match(fqan)
	if match:
		return True
	return False

def voms_get_group_from_fqan(fqan):
	## Strip junk from fqan
	fqan=fqan.replace("/Role=NULL/Capability=NULL","")
	
	matches_role = re.compile("(^/.*)(/Role=[\w.-]+)(/Capability=.*)?$").match(fqan)
	if matches_role:
		return matches_role.group(1)
	
	matches_group = re.compile("^(/[\w.-]+)+$").match(fqan)
	if matches_group:
		return matches_group.group(0)
		
	return None

	
def voms_get_vo_name_from_fqan(fqan):
	regexp = re.compile("^\/([\wx.-]+)\/?")
 	m = regexp.match(fqan)
	if m:
		return m.group(1)
	return None
	

def build_voms_proxy_init_role_params(roles):
	args = []
	for r in roles:
		vo=voms_get_vo_name_from_fqan(r)
		args.append("-voms %s:%s" % (vo, r))
	return " ".join(args)
	

class TestFQANMatching(unittest.TestCase):
	
	def test_is_valid_fqan(self):
		valid_fqans = [
			"/ciccio.paglia/camaghe",
			"/atlas/production/Role=NULL/Capability=NULL",
			"/atlas-production/myTestVo1231/Role=porenghi",
			"/vo",
			"/123vo/vo123"]
		
		invalid_fqans = [
			"//vo",
			"/Role=ciccio/vo/test",
			"/=dasd/production",
			"myFqan/ciccio",
			"/vo&defense/cama.ghe"
			]
			
		for f in valid_fqans:
			self.assertTrue(is_valid_fqan(f), '%s is a valid fqan but was considered invalid' % f)
		
		for f in invalid_fqans:
			self.assertFalse(is_valid_fqan(f), '%s is an invalid fqan but was considered valid' % f)
		

	
def main():
	unittest.main()
	

	
if __name__ == '__main__':
	main()
		