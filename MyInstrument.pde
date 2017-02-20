/*
Example instrument for synth workshop.
*/

import processing.serial.*;
import cc.arduino.*;

import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim;
AudioOutput out;

Arduino arduino;

int pin0 = 2;
int pin1 = 3;
int pin2 = 4;

float rad0, rad1, rad2 = 100;

//Store an array list with tones 
String[] cMajorTones = {"C3", "E3", "G3", "C4", "E4", "G4", "C5", "E5", "G5", "C6", "E6"}; 

void setup() {
  println(Arduino.list());
  size(500, 500);

  arduino = new Arduino(this, Arduino.list()[3], 57600);
  arduino.pinMode(pin0, Arduino.INPUT);
  arduino.pinMode(pin1, Arduino.INPUT);
  arduino.pinMode(pin2, Arduino.INPUT);

  minim = new Minim(this);
  out = minim.getLineOut();
}


void draw() {
  //Clean this up
  //Edited this here in github
  fill(255,255,255,50);
  rect(0,0,width, height);
  noFill();
  println(arduino.analogRead(0));

  float totalFrequency = 0;

  out.setGain(map(arduino.analogRead(0), 0, 6, -20, 20));

  if (arduino.digitalRead(pin0) == Arduino.HIGH) {
    if (rad0 < 350) {
      rad0++;
    }
    out.playNote(0, .5, new SineInstrument( Frequency.ofPitch( cMajorTones[4] ).asHz()));
    }
 if (arduino.digitalRead(pin1) == Arduino.HIGH) {
    if (rad1 < 350) {
      rad1++;
    }
    out.playNote(0, .5, new SineInstrument( Frequency.ofPitch( cMajorTones[5] ).asHz()));
  } 
if (arduino.digitalRead(pin2) == Arduino.HIGH) {
    if (rad2 < 350) {
      rad2++;
    }
    out.playNote(0, .5, new SineInstrument( Frequency.ofPitch( cMajorTones[6] ).asHz()));
  }

  if (arduino.digitalRead(pin0) == Arduino.LOW) {
    rad0 = 100;
  }
  if (arduino.digitalRead(pin1) == Arduino.LOW) {
    rad1 = 100;
  }
  if (arduino.digitalRead(pin2) == Arduino.LOW) {
    rad2 = 100;
  }

  ellipse(width/4, height/2, rad0, rad0);
  ellipse(width/2, height/2, rad1, rad1);
  ellipse(width*3/4, height/2, rad2, rad2);


  // delay(500);
}
