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
PImage objective;
PImage background;
PImage name;

String typing = "";
String player1Name = "";
String player2Name = "";
String test = "polygon";

int state=0;
float player1Score = 0;
float player2Score = 0;
int savedTime;
int totalTime = 20000;

boolean timeHasBeenReset = false;



void setup () {
  size(1280, 720, P3D);
  minim = new Minim(this);
  accessMic = minim.getLineIn();
  rectMode(CENTER);
  avenirBlack = loadFont("AvenirNext-Bold-48.vlw");
  avenirLight = loadFont("Avenir-Light-48.vlw");
  pacifico = loadFont("Pacifico-48.vlw");
  title= loadImage("title.jpg");
  objective = loadImage("objective.jpg");
  background =loadImage("background.jpg");
  name =loadImage("name.jpg");
  //  savedTime = millis();
}

void draw() {

  if (state==0) {
    image(title, 0, 0);
  }

  if (state == 1) {
    image(objective, 0, 0);
  }

  if (state==2) {
    image(name, 0, 0);
    textFont(avenirBlack);
    textAlign(CENTER);
    text("PLAYER 1: " + typing, width/2, height/2);
  }

  if (state==3) {
    image(name, 0, 0);
    textFont(avenirBlack);
    textAlign(CENTER);
    text("PLAYER 2: " + typing, width/2, height/2);
  }

  if (state==4) {
    if (timeHasBeenReset == false) {
      savedTime = millis();
      timeHasBeenReset = true;
    }
    image(background, 0, 0);
    boxSize = 1000*accessMic.left.level();
    player1Score = player1Score + boxSize;

    stroke(255);
    println(boxSize);
    fill(255);
    if (boxSize > 5) {
      rect(width/2, height/2, boxSize, boxSize);
    } else {
      rect(width/2, height/2, 5, 5);
    }
    int passedTime = millis() - savedTime;
    // Has five seconds passed?
    if (passedTime > totalTime) {
      savedTime = millis(); // Save the current time to restart the timer!
    }
    textSize(24);
    textAlign(RIGHT);
    text("Time remaining: " + (20000-passedTime)/1000, width/4*3, height/2 + 200);
    textAlign(LEFT);

    text("Player 1 Score: " + player1Score, width/4, height/2 + 200);
  }
}

void keyPressed() {
  if (state==0) {
    if (key == '\n' ) {
      state++;
    }
  } else if (state ==1) {
    if (key == '\n' ) {
      state++;
    }
  } else if (state==2) {
    // If the return key is pressed, save the String and clear it
    if (key == '\n' ) {
      player1Name = typing;
      // A String can be cleared by setting it equal to ""
      typing = "";
      state++;
    } else {
      // Otherwise, concatenate the String
      // Each character typed by the user is added to the end of the String variable.
      if (keyCode==BACKSPACE) {
        typing = removeLastChar(typing);
        println(typing);
        //typing = typing + key;
      } else {
        typing = typing + key;
      }
    }
  } else if (state == 3) {
    // If the return key is pressed, save the String and clear it
    if (key == '\n' ) {
      player2Name = typing;
      // A String can be cleared by setting it equal to ""
      typing = "";
      state++;
    } else {
      // Otherwise, concatenate the String
      // Each character typed by the user is added to the end of the String variable.
      if (keyCode==BACKSPACE) {
        typing = removeLastChar(typing);
        println(typing);
        //typing = typing + key;
      } else {
        typing = typing + key;
      }
    }
  }
  println(key);
}

public static String removeLastChar(String str) {
  if (str.length() > 0) {
    return str.substring(0, str.length()-1);
  } else {
    println ("nothing to delete");
    return str;
  }
}


//Works Cited
//Mic example provided below
//http://stackoverflow.com/questions/23863091/find-volume-of-mic-input-using-minim-lib-in-processing

