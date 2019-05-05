#!/usr/bin/python  

import os
import time
import RPi.GPIO as GPIO  
 
GPIO.setmode(GPIO.BOARD)  
GPIO.setup(35, GPIO.OUT)  
      
p = GPIO.PWM(35, 150)  
p.start(50)  

try:  
	while 1:
		temp = os.popen('vcgencmd measure_temp').readline()
		tempfloat = float(temp.replace('temp=','').replace('\'C\n',''))
		print ('CPU Temperature is now %.1f Centigrade' %tempfloat)
		if tempfloat > 60:
			print ('CPU Temperature is too high, pls cool it down')
		if tempfloat < 43:
			dc=0
		else:
			dc=(tempfloat-43)*20
			if dc > 100:
				dc=100
			p.ChangeDutyCycle(dc) 
			print ('DutyCycle is now %.1f percent' %dc)
		time.sleep(2)  
except KeyboardInterrupt:
	pass  
p.stop()  
GPIO.cleanup()  
