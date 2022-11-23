#! /usr/bin/python3
import locale
from datetime import datetime
import sys
import getopt
import string

locale.setlocale(locale.LC_ALL, '')
loc = locale.getlocale()

locale.setlocale(locale.LC_ALL, 'en_CA.UTF-8')

print('%s' % (string.capwords(datetime.now().strftime('%A, %B %d - %k:%M'))))
sys.exit(0)
