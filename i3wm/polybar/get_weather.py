import requests as rq
from sys import exit
from time import sleep
import re

sleep(2)

try:
	req = rq.get('https://p.ya.ru/62', timeout=3)
except Exception:
	print("- ℃", end='')
	exit()

if (req.status_code != 200):
	print("- ℃", end='')
	exit()

html = req.text
temper = re.findall(r'{\"temp\":([-+]*[\d]+)}', html)
temper = int(temper[0])
if temper > 0:
    icon = ""
else:
    icon = ""

print("{} {}󰔄".format(icon, temper), end='')
