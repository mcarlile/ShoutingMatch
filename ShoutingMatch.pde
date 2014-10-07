import ddf.minim.analysis.*;
import ddf.minim.*;

Minim       minim;
AudioInput  accessMic;
FFT         fft;
float boxSize;

void setup () {
  size(512, 200, P3D);
  minim = new Minim(this);
  accessMic = minim.getLineIn();
  rectMode(CENTER);
}

void draw() {
  background(255);
  boxSize = 1000*accessMic.left.level();
  stroke(255);
  println(boxSize);
  fill(0);
  rect(width/2, height/2, boxSize, boxSize);
}

//Works Cited
//Mic example provided below
//http://stackoverflow.com/questions/23863091/find-volume-of-mic-input-using-minim-lib-in-processing

