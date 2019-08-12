#!/usr/bin/python
import time
import RPi.GPIO as GPIO
GPIO.setmode(GPIO.BCM)
GPIO.setup(18, GPIO.OUT)

p = GPIO.PWM(18, 1000)
p.start(100)
t = 0
pwm=[0,8,20,35,60,100]
bl=5
GPIO.setup(26, GPIO.IN, pull_up_down=GPIO.PUD_UP)
try:
 while 1:
   if GPIO.input(26):
     time.sleep(0.05)
     t=0
     #print('Input was HIGH')
   else:
     while 1:
       time.sleep(0.02)
       if GPIO.input(26):
         break
       else:
         t=t+1
       if t>3:
         t=0
         if bl:
           bl=bl-1
         else:
           bl=5
         p.ChangeDutyCycle(pwm[bl])
         #print('Input was LOW')
         while not GPIO.input(26):
           time.sleep(0.05)
         break
except KeyboardInterrupt:
  pass
p.stop()
GPIO.cleanup()
