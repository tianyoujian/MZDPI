#!/usr/bin/python
import time
import RPi.GPIO as GPIO
gpio_key=26
GPIO.setwarnings(False)
GPIO.setmode(GPIO.BCM)
GPIO.setup(18, GPIO.OUT)

p = GPIO.PWM(18, 1000)
p.start(100)
t = 0
pwm=[0,8,20,35,60,100]
bl=5
GPIO.setup(gpio_key, GPIO.IN, pull_up_down=GPIO.PUD_UP)
try:
 while 1:
   if GPIO.input(gpio_key):
     time.sleep(0.05)
     t=0
     #print('Input was HIGH')
   else:
     while 1:
       time.sleep(0.02)
       if GPIO.input(gpio_key):
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
         while not GPIO.input(gpio_key):
           time.sleep(0.05)
         break
except KeyboardInterrupt:
  pass
p.stop()
GPIO.cleanup()
