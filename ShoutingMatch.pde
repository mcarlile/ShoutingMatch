import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim;
AudioInput accessMic;
FFT   fft;
float boxSize;
PFont avenirBlack;
PFont avenirLight;
PFont pacifico;

PImage title;
PImage background;

int state=0;
String typing = "";
String player1Name = "";
String player2Name = "";
String test = "polygon";



void setup () {
  size(1280, 720, P3D);
  minim = new Minim(this);
  accessMic = minim.getLineIn();
  rectMode(CENTER);
  avenirBlack = createFont("Avenir-Black-48", 32);
  avenirLight = createFont("Avenir-Light-48", 32);
  pacifico = createFont("Pacifico-48", 32);
  title= loadImage("title.jpg");
  background =loadImage("background.jpg");
}

void draw() {

  if (state==0) {
    image(title, 0, 0);
  }

  if (state==1) {
    image(background, 0, 0);
    textFont(pacifico);
    textAlign(CENTER);
    text("PLayer 1: " + typing, width/2, height/2);
  }

  if (state==2) {
    image(background, 0, 0);
    textFont(pacifico);
    textAlign(CENTER);
    text("PLayer 2: " + typing, width/2, height/2);
  }

  if (state==3) {
    background(255);
    boxSize = 1000*accessMic.left.level();
    stroke(255);
    println(boxSize);
    fill(0);
    rect(width/2, height/2, boxSize, boxSize);
  }
}

void keyPressed() {
  if (state==0) {
    if (key == '\n' ) {
      state++;
    }
  } else if (state==1) {
    // If the return key is pressed, save the String and clear it
    if (key == '\n' ) {
      player1Name = typing;
      // A String can be cleared by setting it equal to ""
      typing = "";
      state++;
    } else {
      // Otherwise, concatenate the String
      // Each character typed by the user is added to the end of the String variable.
      typing = typing + key;
    }
  } else if (state ==2) {
    // If the return key is pressed, save the String and clear it
    if (key == '\n' ) {
      player2Name = typing;
      // A String can be cleared by setting it equal to ""
      typing = "";
      state++;
    } else {
      // Otherwise, concatenate the String
      // Each character typed by the user is added to the end of the String variable.
      typing = typing + key;
      if (key=='m') {
        typing = removeLastChar(typing);
        println(typing);
      }
    }
  }
  println(key);
}

public static String removeLastChar(String str) {
  return str.substring(0, str.length()-1);
}


//Works Cited
//Mic example provided below
//http://stackoverflow.com/questions/23863091/find-volume-of-mic-input-using-minim-lib-in-processing

