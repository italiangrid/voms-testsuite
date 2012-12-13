import unittest
from datetime import datetime,timedelta,time


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
		
		print "*DEBUG* Input date 0 string: %s"  % date0
		print "*DEBUG* Input date 1 string: %s" % date1
		print "*DEBUG* Parsed dates: %s, %s" % (d0, d1)
		
		if d0 < d1:
			return -1
		elif d0 == d1:
			return 0
		else:
			return 1



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

if __name__ == '__main__':
	unittest.main()	