import unittest
from datetime import datetime,timedelta,time
import os, glob


openssl_date_format = "%b %d %H:%M:%S %Y %Z" 

class VOMSLibrary:
	"""A simple library of helper functions not easily implemented with other Robot keywords"""
	
	ROBOT_LIBRARY_SCOPE = "GLOBAL"
		
	def _parse_date(self, date_str):
		return datetime.strptime(date_str, openssl_date_format)

	def date_difference_in_seconds(self, date0, date1):
		"""Returns the difference in seconds between the two dates, calculated substracting the smaller	date from the bigger one"""
		
		d0 = self._parse_date(date0)
		d1 = self._parse_date(date1)
		
		if d1 > d0:
			diff = d1 - d0
		else:
			diff = d0 - d1
			
		return diff.seconds
		
		
	def compare_dates(self, date0, date1):
		"""Compares two dates passed as strings.
		
		The format used to parse the dates is '%b %d %H:%M:%S %Y %Z', as passed to the datetime.strptime() function.
		This keyword returns 0, if the dates are equal, -1 if the first date argument is less than the second date argument, 
		and 1 otherwise""" 
		
		d0 = self._parse_date(date0)
		d1 = self._parse_date(date1)
		
		if d0 < d1:
			return -1
		elif d0 == d1:
			return 0
		else:
			return 1

	def parse_vomses_files(self, vomses: list = ["/etc/vomses", "~/.glite/vomses"]) -> dict:
		"""Read the files in /etc/vomses and in ~/.glite/vomses, returning a dictionary with the following items:
		vo: [hosts]"""

		vomses_files = []
		for voms in vomses:
			voms_path = os.path.expanduser(voms)
			if os.path.isfile(voms_path):
				vomses_files.append(voms_path)
			elif os.path.isdir(voms_path):
				vomses_files.extend(glob.glob(os.path.join(voms_path,"*")))
		vomses = {}
		
		for vomses_file in vomses_files:
			try:
				with open(vomses_file) as f:
					for line in f.readlines():
						# ignore commented lines
						line = line.split("#")[0].strip()
						if line:
							# extract the first 5 mandatory fields and ignore further optional ones
							alias, host, port, cn, vo = line.split('"')[1:10:2]
							vo = vo.strip()
							if vo not in vomses:
								vomses[vo] = []
							vomses[vo].append(host.strip()+":"+port.strip())
			except Exception:
				pass
		
		return vomses	


class DatesTest(unittest.TestCase):
	def testEqualDates(self):
		l = VOMSLibrary()
		self.assertEqual(0, l.compare_dates("Sep 18 13:04:06 2013 GMT","Sep 18 13:04:06 2013 GMT"))
	
	def testMinorDate(self):
		l = VOMSLibrary()
		self.assertEqual(-1, l.compare_dates("Sep 15 13:04:06 2013 GMT","Sep 18 13:04:06 2013 GMT"))
	
	def testMajorDate(self):
		l = VOMSLibrary()
		self.assertEqual(1, l.compare_dates("Sep 21 13:04:06 2013 GMT","Sep 18 13:04:06 2013 GMT"))
	
	def testParseError(self):
		l = VOMSLibrary()
		caught_exception = False
		try:
			l.compare_dates("camaghe","Sep 18 13:04:06 2013 GMT")
		except ValueError:
			caught_exception = True
		
		self.assertTrue(caught_exception)
		
	def testDateDiff(self):
		l = VOMSLibrary()
		self.assertEqual(1, l.date_difference_in_seconds("Sep 15 13:04:06 2013 GMT","Sep 15 13:04:07 2013 GMT"))
		self.assertEqual(1, l.date_difference_in_seconds("Sep 15 13:04:09 2013 GMT","Sep 15 13:04:08 2013 GMT"))
		self.assertEqual(0, l.date_difference_in_seconds("Sep 15 13:04:08 2013 GMT","Sep 15 13:04:08 2013 GMT"))

class VomsesTest(unittest.TestCase):
	def testParseVomses(self):
		l = VOMSLibrary()
		vomses = l.parse_vomses_files(["../compose/assets/vomses"])
		self.assertIsInstance(vomses, dict)
		self.assertDictEqual(vomses, {"test.vo": ["voms-dev.cloud.cnaf.infn.it:15004"],
									  "vo.0": ["voms.test.example:15000"],
									  "vo.1": ["voms.test.example:15001"]})

if __name__ == '__main__':
	unittest.main()	