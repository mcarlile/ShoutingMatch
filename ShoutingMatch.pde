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
PImage player2Prompt;
PImage carnageReport;

String typing = "";
String player1Name = "";
String player2Name = "";

int state=0;
float player1Score = 0;
float player2Score = 0;
int savedTime;
int totalTime = 5000;
int passedTime;

boolean timeHasBeenReset;
boolean timeHasBeenReset2;




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
  player2Prompt = loadImage("player2prompt.jpg");
  carnageReport = loadImage("carnage-report.jpg");
  state=0;
  savedTime=0;
  passedTime=0;
  totalTime = 5000;
  float player1Score = 0;
  float player2Score = 0;
  timeHasBeenReset = false;
  timeHasBeenReset2 = false;


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





  //Player 2 turn
  if (state==4) {
    if (timeHasBeenReset == false) {
      savedTime = millis();
      timeHasBeenReset = true;
    }
    image(background, 0, 0);
    boxSize = 1000*accessMic.left.level();
    player1Score = player1Score + boxSize;

    stroke(255);
    fill(255);
    if (boxSize > 5) {
      rect(width/2, height/2, boxSize, boxSize);
    } else {
      rect(width/2, height/2, 5, 5);
    }
    passedTime = millis() - savedTime;
    // Has five seconds passed?
    if (passedTime > totalTime) {
      state++;
      println("called new scene");
    }
    textSize(24);
    textAlign(RIGHT);
    text("time remaining: " + (5000-passedTime)/1000, width/4*3, height/2 + 200);
    textAlign(LEFT);

    text(player1Name + "'s score: " + player1Score, width/4, height/2 + 200);
  }

  if (state==5) {
    image(player2Prompt, 0, 0);
    textFont(avenirBlack);
    textAlign(CENTER);
    text(player1Name + "'s score: " + player1Score, width/2, height/2);
  }

  //Player 2 turn
  if (state==6) {
    if (timeHasBeenReset2 == false) {
      savedTime = millis();
      timeHasBeenReset2 = true;
    }
    image(background, 0, 0);
    boxSize = 1000*accessMic.left.level();
    player2Score = player2Score + boxSize;

    stroke(255);
    fill(255);
    if (boxSize > 5) {
      rect(width/2, height/2, boxSize, boxSize);
    } else {
      rect(width/2, height/2, 5, 5);
    }
    int passedTime = millis() - savedTime;
    // Has five seconds passed?
    if (passedTime > totalTime) {
      state++;
      println("called new scene");
    }
    textSize(24);
    textAlign(RIGHT);
    text("time remaining: " + (5000-passedTime)/1000, width/4*3, height/2 + 200);
    textAlign(LEFT);

    text(player2Name + "'s score: " + player2Score, width/4, height/2 + 200);
  }

  if (state==7) {
    image(carnageReport, 0, 0);
    textFont(avenirBlack);
    textAlign(CENTER);
    textSize(72);
    if (player1Score > player2Score) {
      text(player1Name + " wins!", width/2, height/4);
    } else {
      text(player2Name + " wins!", width/2, height/4);
    }
    textSize(24);
    text(player1Name + "'s score: " + player1Score, width/2, height/2);
    text(player2Name + "'s score: " + player2Score, width/2, height/2+24);
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
      if (typing == "") {
        player1Name= "Player 1";
        state++;
      } else {
        player1Name = typing;
        // A String can be cleared by setting it equal to ""
        typing = "";
        state++;
      }
    } else {
      // Otherwise, concatenate the String
      // Each character typed by the user is added to the end of the String variable.
      if (keyCode==BACKSPACE) {
        typing = removeLastChar(typing);
        //typing = typing + key;
      } else {
        typing = typing + key;
      }
    }

    //Get Player 2 Name
  } else if (state == 3) {
    // If the return key is pressed, save the String and clear it
    if (key == '\n' ) {
      if (typing == "") {
        player2Name="Player 2";
        state++;
      } else {
        player2Name = typing;
        // A String can be cleared by setting it equal to ""
        typing = "";
        state++;
      }
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
  } else if (state == 5) {
    if (key == '\n' ) {
      state++;
    }
  } else if (state==7) {
    if (key == '\n' ) {
      setup();
    }
  }
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

