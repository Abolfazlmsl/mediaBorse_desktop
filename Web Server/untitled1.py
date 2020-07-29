# -*- coding: utf-8 -*-
"""
Created on Wed Jul 29 11:02:10 2020

@author: Developer 01
"""

from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import time

driver = webdriver.Chrome()
driver.get("http://www.varzesh3.com/")

time.sleep(5)
#open tab
driver.execute_script('''window.open("http://bings.com","_blank");''')

