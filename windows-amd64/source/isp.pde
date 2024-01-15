import controlP5.*;
import processing.sound.*;

/*
Authors: Jason Cameron & Simon Michetti
 Teachers name: Ms. Basaraba
 Date: Dec 11th - Jan 15th
 Description: This program creates an immersive game in the background for users to learn about the potential dangers of babysitting and provides an outline of what a bad babysitting habits look like. This game takes on a look don't tell form of communication where the player isn't explicitly told about what is going on but can clearly understand the ideas being presented.
 */


/*
Changes from plan:
 - drawRain & drawFire being changed from global varibles to methods
 - renamed slowdownOne to slowdown and removed slowdownTwo
 - renamed playMusic to musicVolume and added musicFile.
 */


ControlP5 bt5;  // variable for the button controller
SoundFile musicFile; // varible to load the sound file into and to be able to change volume globally
PFont text; // varible so we can load in the font.
int musicVolume = 50; // if music should be played: default 50
int sceneNum = 0; // the current scene that the story is on (0-10) (0 being splash 10 being tornado)
int sceneProgress = 0; // the current part of the scene (e.g. 0 is normal but it adds queues for parents walking in)
boolean isPaused = false; // if the game is currently paused
String username = "testing"; // the user's username
boolean parentsMad = false; // whether to draw the parents as mad or not
String sitterEmotion = "unamused"; // the emotion to draw the sitter in
String babyEmotion = "sick"; // the emotion to draw the baby in
float slowdown = 0; // a way to control the animation speed for certain parts of a frame


int momArmX=400; //variables that help animate the mom and dad
int momArmY=232;
int momBodyX=500;
int dadBodyX=675;

int sitterX=150; //variables that animate the babysitter
int sitterArmY=360;
int sitterArmY2=360;
int sitterArmX=210;

int babyX=300; //variables that animate the baby
int babyY=350;

int fireY=281; //variable to animate the fire in scene 3


int vomitX=340; //variables to animate the vomit of the baby in scene 8
int vomitY=250;
int tornadoX=-300; //variable to move the tornado around in the last scene
int tornadoProgress=1; //variable to control tornado movement in the final scene

void setup() {
  text = loadFont("Consolas-48.vlw");
  size(800, 500);
  musicFile = new SoundFile(this, "ruins.mp3"); // load the sound file from the data folder
  musicFile.loop(); // play and loop the sound file
  musicFile.amp(musicVolume / 100); // set it to it's default of 50% volume

  bt5 = new ControlP5(this);
  bt5.addButton("Next")
    .setBroadcast(false)
    .setPosition(width - 60, height - 50)
    .setValue(255)
    .setSize(40, 30)
    .setCaptionLabel(">")
    .setColorForeground(color(0, 0, 0, 255))  // Set regular color with alpha channel to black
    .setColorBackground(color(0, 0, 0, 255))    // Set hover color as transparent
    .setColorActive(color(0, 0, 0, 255))      // Set click color (if needed)
    .setBroadcast(true);

  Story();
}




void Story() {
  print("Going to: " + sceneNum);
  if (sceneNum == 0) {
    momBodyX=500;
    momArmY=232;
    momArmX=400;
    dadBodyX=675;
    splashScreen();
  } else if (sceneNum == 1) {
    if (bt5.getController("SetUsername") == null) { // if it does not already exist
      int middle = (width/2) - 40; // compensate for the fact that controlp5 draws from top corner
      bt5.addButton("SetUsername")
        .setColorBackground(color(0, 0, 0))
        .setPosition(middle - 190, height-125)
        .setColorForeground(color(0, 0, 0, 255))  // Set regular color with alpha channel to black
        .setColorBackground(color(0, 0, 0, 255))    // Set hover color as transparent
        .setColorActive(color(0, 0, 0, 255))      // Set click color (if needed)
        .setSize(80, 50);

      bt5.addButton("Exit")
        .setColorBackground(color(0, 0, 0))
        .setPosition(middle + 190, height-125)
        .setColorForeground(color(0, 0, 0, 255))  // Set regular color with alpha channel to black
        .setColorBackground(color(0, 0, 0, 255))    // Set hover color as transparent
        .setColorActive(color(0, 0, 0, 255))      // Set click color (if needed)
        .setSize(80, 50);


      bt5.addSlider("musicVolume")
        .setPosition(width/2 - 75, height-50)
        .setSize(150, 20)
        .setRange(0, 100)
        .setValue(musicVolume) // default volume
        .setColorBackground(color(0, 0, 0))
        .setColorCaptionLabel(color(20, 20, 20));
    }
    mainMenu();
  } else if (sceneNum == 2) {
    momBodyX=500;
    dadBodyX=675;
    sitterX=150;
    sitterArmX=210;
    sitterArmY=360;
    momArmX=400;
    momArmY=232;
    introScene();
  } else if (sceneNum == 3) {
    sitterX=150;
    sitterArmX=210;
    sitterArmY=360;
    babyX=300;
    babyY=350;
    fireY=281;
    babyFireSlide();
  } else if (sceneNum == 4) {
    sitterX=150;
    sitterArmX=210;
    sitterArmY=360;
    babyX=300;
    babyCribScene();
  } else if (sceneNum == 5) {
    babyX=300;
    babyCrawlScene();
  } else if (sceneNum == 6) {
    babyX=300;
    babyY=350;
    babyFallScene();
  } else if (sceneNum == 7) {
    babyX=300;
    babyY=350;
    sitterX=150;
    sitterArmX=210;
    babyPickupScene();
  } else if (sceneNum == 8) {
    sitterX=150;
    sitterArmX=210;
    sitterArmY=360;
    sitterArmY2=360;
    babyX=300;
    babyY=350;
    vomitX=340;
    vomitY=250;
    momBodyX=500;
    momArmX=400;
    momArmY=232;
    dadBodyX=675;
    babyPizzaScene();
  } else if (sceneNum == 9) {
    sitterX=150;
    sitterArmX=210;
    sitterArmY=360;
    sitterArmY2=360;
    tornadoX=-300;
    tornadoProgress=1;
    tornadoScene();
  }
}


void Next() {
  println("next!!!!!!!!!!");
  if (sceneNum == 1 && sceneProgress == 1) { // don't skin while in instructions
    return;
  }
  sceneProgress = 0;
  boolean goNext = true;
  if (sceneNum == 0 && bt5.getController("Prev") == null ) {
    println("adding prev button");
    bt5.addButton("Prev")
      .setBroadcast(false)
      .setPosition(width - 100, height - 50)
      .setValue(255)
      .setSize(40, 30)
      .setCaptionLabel("<")
      .setColorForeground(color(0, 0, 0, 255))  // Set regular color with alpha channel to black
      .setColorBackground(color(0, 0, 0, 255))    // Set hover color as transparent
      .setColorActive(color(0, 0, 0, 255))      // Set click color (if needed)
      .setBroadcast(true);
  }

  if (sceneNum ==1 ) { // main menu
    if (username == "") { // block continue if username has not been set
      JOptionPane.showMessageDialog(null, "You must set a username in order to play");
      goNext = false;
      mainMenu();
    }
    bt5.getController("SetUsername").remove();
    bt5.getController("Exit").remove();
    bt5.getController("Instructions").remove();
    bt5.getController("musicVolume").remove();
  }

  if (goNext == true) {
    sceneNum = (min(sceneNum +1, 9)); // prevent going over last scene
    Story();
  }
}
void Prev() {
  if (sceneNum == 1 && sceneProgress == 1) { // don't skin while in instructions
    return;
  }
  sceneProgress = 0;
  sceneNum = max(0, sceneNum - 1); // ensure it cannot go below zero
  if (!bt5.getController("Next").isVisible()) {
    bt5.getController("Next").show(); // if it's not visible show it
  }
  if (sceneNum == 0) {
    if (bt5.getController("SetUsername") != null) { // if they didnt spam back and went "past zero"
      bt5.getController("SetUsername").remove();
      bt5.getController("Exit").remove();
      bt5.getController("Prev").remove();
      bt5.getController("Instructions").remove();
      bt5.getController("musicVolume").remove();
    }
  }
  Story();
}

void mainMenu() {
  // other code is added in draw/Story
  bt5.show();
  splashScreen();

  fill(0, 0, 0);
  noStroke();
  int middle = (width/2) - 40; // compensate for the fact that controlp5 draws from top corner
  rect(middle, height-125, 80, 50);
  //  text("Instructions", (width/2), height-(125 + (50/2)));
  if (bt5.getController("Instructions") == null) { // only add it if it doest already exist
    bt5.addTextlabel("Instructions")
      .setText("Instructions")
      .setPosition(middle + 10, height-(125 - (50/2) + 5))

      .setColorValue(0xffffff00);
  }
}

void SetUsername() {
  while (true) {
    String tempusername = getString("Please enter a username (3-15chars)");
    if (tempusername == null) {
      continue;
    }
    if (tempusername.length() > 15) { // if the username is greater than 15 chars
      JOptionPane.showMessageDialog(null, "the max length is 15 chars, you tried to set it to: " + str(tempusername.length()));
    } else if (tempusername.length() < 3) { // if the username is less than 3 chars

      JOptionPane.showMessageDialog(null, "the min length is 3 chars, you tried to set it to: " + str(tempusername.length()));
    } else if (!tempusername.matches("\\p{Alpha}*")) { // if the username does not only contain letters.
      JOptionPane.showMessageDialog(null, "Your username cannot contain non letters. Please try again.");
    } else {
      username = tempusername;
      break;
    }
  }

  JOptionPane.showMessageDialog(null, "Your username is: " + username);
}
void drawRain() {
  if (sceneNum == 9 && sceneProgress >= 0) { // on first part of tornado scene

    ellipseMode(CENTER);
    strokeWeight(1);
    stroke(72, 150, 180);
    fill(72, 150, 180);
    for (int i = 0; i<50; i++) {
      ellipse(random(0, width), random(0, height), 2, 10);
    }
  }
}


void draw() {
  if (sceneNum == 1 || isPaused) {
    musicFile.amp(((float)musicVolume) / 100); // it takes input between 0 and 1 and we want to provide live updates
  }
  //if (sceneNum == 1 && sceneProgress == 1) { // if on main menu and is on instructions
  //  print("hi");
  //  bt5.hide(); // hide all controllers
  //  bt5.getController("Next").hide();
  //  bt5.getController("Prev").hide();
  //}

  if (isPaused == true) {
    /*
    I need to do custom buttons for this as there is a bug where controlp5 only
     */
    rectMode(CORNERS);
    fill(0, 0, 0, 10); // slowly fill black
    rect(55, 55, width - 55, height - 55);
    rectMode(CENTER);
    int Ymiddle = (height/2); // compensate for the fact that controlp5 draws from top corner
    int Bwidth = 77; // width of the buttons
    int Bheight = 40; // height of the buttons
    float spacing = 2* Bwidth;// + (Bwidth / 2);

    fill(255); // set button color to white

    rect(31+ (spacing * 1), Ymiddle, Bwidth, Bheight);
    rect(31+  (spacing * 2), Ymiddle, Bwidth, Bheight);
    rect(31+ (spacing * 3), Ymiddle, Bwidth, Bheight);
    rect(31+ (spacing * 4), Ymiddle, Bwidth, Bheight);
    rectMode(CORNER);
    fill(0); // set color to black
    textSize(16);
    Ymiddle+=5; // so text is centered
    // Labels for the buttons
    text("Exit", 18 + (spacing * 1), Ymiddle);
    textSize(14);
    text("Set Volume", (spacing * 3) - 1, Ymiddle);
    text("Main Menu", (spacing * 4) - 1, Ymiddle);
    textSize(13);
    text("Instructions", (spacing * 2) - 1, Ymiddle);
    textSize(20); // reset font to norm
    return;
  }
  slowdown++;
  if (slowdown % 8 == 0) { // runs at 1/8th of the speed that draw does
    if ((sceneNum == 9) && sceneProgress >= 0) {

      drawRain();
    }
  }


  if (sceneNum==2) { //animation that appears in this screen
    bt5.getController("Next").hide();
    stroke(0);
    strokeWeight(1);
    parentsMad=false;
    if (sceneProgress == 1 || sceneNum==2) {
      line(450, 292, 440, 332); //left mom arm
      line(440, 332, momArmX+40, momArmY+150);
      momArmX=momArmX-5;  //animation to raise the moms arm in a greeting/acknoledgement of departure
      momArmY=momArmY-5;
      momArmY = max(momArmY, 132);
      momArmX = max(momArmX, 380);
    }
    if (sceneProgress >= 4 || sceneProgress >=10) {
      momArmX=momArmX+15;
      momArmX = min(momArmX, 100000);
      momBodyX=momBodyX+10;  //showing the parents leave the scene
      dadBodyX=dadBodyX+10;
    }
    if (sceneProgress >= 6 || sceneProgress >=10) {
      sitterX= sitterX-10; //showing the babysitter leave the scene
      sitterArmX= sitterArmX-10;
    }
    introScene();
  }


  if (sceneNum==3) { //animation that appears in this scene
    bt5.getController("Next").hide();
    stroke(0);
    strokeWeight(1);
    babyEmotion="normal";

    if (sceneProgress >= 0 && sceneNum == 3) {
      sitterX=sitterX-10; //showing the babysitter slide into the scene as if he was coming from the last one.
      sitterArmX=sitterArmX-10;
      sitterX = max (sitterX, -260);
      sitterArmX = max (sitterArmX, -200);
    }

    if (sceneProgress >= 5) {
      line(sitterX+60, 300, sitterArmX, sitterArmY); // right babysitter arm moving to take his phone out of his pocket
      sitterArmX=sitterArmX+5;
      sitterArmY=sitterArmY-5;
      sitterArmX= max (sitterArmX, -190);
      sitterArmY= max (sitterArmY, 250);
    }
    if (sceneProgress >= 7) {
      babyX=babyX-5; //the baby sliding over to the stove which will then catch on fire
      babyX= max (babyX, 25);
    }
    if (sceneProgress >=8 && babyX==25) {
      fireY=fireY-7;  //the fire on the stove turning on and burning the baby
      fireY = max (fireY, 250);
    }
    if (fireY==250) {
      fireY+=20;
    }

    if (sceneProgress >= 9 && fireY>=250 && babyX == 25) {
      babyEmotion = "crying"; //showing how the baby is now crying because of the fire
    }
    babyFireSlide();
  }


  if (sceneNum == 4) {  //animation that happens in scene 4
    bt5.getController("Next").hide();
    stroke(0);
    strokeWeight(1);
    babyEmotion="crying";

    if (sceneProgress >= 0 && babyX != -620) {
      sitterX=sitterX-10;
      sitterArmX=sitterArmX-10;
      sitterX= max (sitterX, -500);
      sitterArmX= max (sitterArmX, -440);

      babyX= babyX-10;
      babyX= max(babyX, -620);
    }

    if (sceneProgress >=1 && sceneNum == 4 && babyX <=-620) {
      sitterX=sitterX+10;
      sitterArmX=sitterArmX+10;
    }
    babyCribScene();
  }


  if (sceneNum == 5) {
    bt5.getController("Next").hide();
    stroke(0);
    strokeWeight(1);
    babyEmotion="normal";

    if (sceneProgress == 0 || sceneNum == 5) {
      babyX=babyX+10;
      babyX= min (babyX, 1100);
    }

    babyCrawlScene();
  }

  if (sceneNum == 6) {
    bt5.getController("Next").hide();
    stroke(0);
    strokeWeight(1);
    babyEmotion="shocked";
    if (sceneProgress >= 0) {
      babyY=babyY+10;
    }

    babyFallScene();
  }

  if (sceneNum == 7) {
    bt5.getController("Next").hide();
    stroke(0);
    strokeWeight(1);
    babyEmotion="crying";
    sitterEmotion="unamused";
    if (sceneProgress >= 0) {
      babyX=babyX+10;
      babyY=babyY+5;
      sitterX=sitterX-10;
      sitterArmX=sitterArmX-10;


      sitterArmX= max (sitterArmX, -210);
      sitterX = max (sitterX, -270);
      babyY= min (babyY, 525);
      babyX= min (babyX, 650);
    }
    if (sceneProgress >=1 && babyX==650) {
      babyX-=20;
    }
    babyPickupScene();
  }

  if (sceneNum == 8) {
    bt5.getController("Next").hide();
    stroke(0);
    strokeWeight(1);
    babyEmotion="normal";
    sitterEmotion="unamused";
    if (sceneProgress >=1) {
      babyX-=5;

      babyX = max (babyX, 100);
    }
    if (sceneProgress >= 2 && babyX == 100) {
      babyEmotion="sick";
    }
    if (sceneProgress >=3) {
      sitterEmotion="angry";
    }
    if (sceneProgress >=5) {
      vomitX+=10;
      vomitX= min(vomitX, 800);
    }
    if (sceneProgress >= 5 && vomitX == 800 && vomitY != 130) {
      vomitY-=5;
    }
    if (vomitY == 130) {
      vomitY+=200;
    }

    babyPizzaScene();
  }
  if (sceneProgress >=7 && vomitX == 800) {
    parentsMad = true;
    momBodyX+=10;
    momArmX+=10;
    dadBodyX+=10;

    momBodyX= min(momBodyX, 1200);
    momArmX= min (momArmX, 1100);
    dadBodyX = min (dadBodyX, 1375);
  }

  if (sceneNum == 9) {
    bt5.getController("Next").hide();
    stroke(0);
    strokeWeight(1);
    sitterEmotion="angry";
    if (sceneProgress >=2) {
      sitterEmotion="shocked";
      sitterArmY-=10;
      sitterArmY2-=10;

      sitterArmY2= max (sitterArmY2, 150);
      sitterArmY= max (sitterArmY, 150);
    }
    if (sceneProgress >=3 && tornadoProgress != 2) {
      tornadoX+=10;
    }
    if (tornadoX==500) {
      tornadoProgress++;
    }
    if (sceneProgress >=3 && tornadoX <=500 && tornadoProgress ==2) {
      tornadoX-=10;
    }
    if (tornadoX==350 && tornadoProgress ==2) {
      tornadoProgress--;
    }
    stroke(0);
    tornadoScene();
    drawRain();
  }
}

void keyPressed() {
  if (key == ESC) {
    if (sceneNum == 1 && sceneProgress == 1) { // if on instructions in main menu
      sceneProgress = 0;
      bt5.show();
      mainMenu();
    }
    if (sceneNum <= 1) { // don't pause on main menu or splash screen
      key = 0; // reset key so it doesnt exit
      return;
    }

    if (isPaused == true) {
      isPaused = false;
      musicFile.amp(((float)musicVolume) / 100); // it takes input between 0 and 1
      bt5.show(); // show all buttons

      Story(); // redraw to clear out the pause menu
    } else {
      bt5.hide(); // hide all buttons
      Story();
      isPaused = true;
    }
    key = 0; // needed so processing doesn't close when you click it.
  } else if (keyCode == 37 && isPaused == false && bt5.getController("Prev") != null && bt5.getController("Prev").isVisible()) { // Left arrow
    Prev();
  } else if (keyCode == 39  && isPaused == false && bt5.getController("Next").isVisible()) { // Right arrow
    Next();
  } else if ( key == ' ') { // if user just clicked space


    //  if (sceneNum >= 2) {
    sceneProgress ++;
    println(sceneProgress);
    //}
  }
}

void Exit() {
  JOptionPane.showMessageDialog(null, "Thank you for playing babysitter hell simulator!");
  exit();
}
void mouseClicked() {
  /*
  I needed to make Instructions this way due to the fact that if didn't plan for an instructions method and if I handled it annother way (such is bt5.getController("Instructions").isMouseClicked()) in draw, it would never be consistant.
   */
  int middle = (width/2) - 40; // compensate for the fact that controlp5 draws from top corner
  println(sceneNum);
  println(sceneProgress);
  if (sceneNum == 1) { // if on main menu
    if (sceneProgress == 0) { // if instructions are NOT toggled
      boolean yCheck = (mouseY <= (height-75) && mouseY >= height-(75+50));
      boolean xCheck = (mouseX >= middle && mouseX <= middle+80); // 80 is the width of the box
      if (yCheck && xCheck) { // if the user is pressing the button and not somewhere else
        bt5.hide();

        sceneProgress = 1; // so that other controllers can check.
        rectMode(CORNERS);
        noStroke(); // don't do red outline
        fill(0, 0, 0); // quicklyish fill black
        rect(55, 55, width - 55, height - 55);
        rectMode(CORNER); // reset it back

        text("Press ESC or click anywhere to get out", 55, 45);
        fill(255); // set text color to white
        text("X", 70, 85); // an X just to make it more clear
        text("Welcome to this animated storybook! \nThis educational story focuses on what you shouldn't do as a babysitter by \nusing a look don't tell type of communication. \n\nIn order to progress the story click the spacebar and different lines \nof dialouge will show up. \nTo go to the next scene use the right arrow key once the scene is finished. \n you will know if the scene is finished if a button in the bottom right \nbecomes visible! \nIf you want to go back a scene use the left arrow key. \nThis can be done at anytime! \nIf you want to pause the game use the ESC function", 90, 95);
      }
    } else { // instructions ARE toggled so unset.
      sceneProgress = 0; // set to "not on instructions"
      bt5.show(); // show the selection buttons again
      mainMenu(); // call it to clear the instructions
    }
  } else if (isPaused) {
    /* Layout
     Button = 80px
     Gap = 40px
     G|P = middle of screen + gap
     Button Gap Button G|P Button Gap Button
     */
    boolean yCheck = (mouseY >= (height/2)-20 && mouseY <= (height/2)+20); // y check for all

    boolean xCheckExit = (mouseX >= 147 && mouseX <= 223); // x position check for exit
    boolean xCheckInstuctions = (mouseX >= 147+ 154  && mouseX <= 223 +154); // x position check for Instructions
    boolean xCheckSetAudio = (mouseX >= 147+(154*2) && mouseX <= 223+(154*2)); // x position check for Main Menu
    boolean xCheckMainMenu = (mouseX >= 147+(154*3) && mouseX <= 223+(154*3)); // x position check for Set Audio

    if (yCheck == true) {
      if (xCheckExit == true) {
        Exit();
      }
      if (xCheckInstuctions == true) {
        println("xCheckInstuctions");
      }
      if (xCheckMainMenu == true) { // if user clicked on main menu button
        isPaused = false;
        sceneNum = 1; // main menu scene num
        bt5.show();
        Story();
      }
      if (xCheckSetAudio == true) {
        while (true) {
          int tempVolume = getInt("Please enter your desired volume (between 0 for muted and 100 for full volume)");
          if (tempVolume > 100 || tempVolume < 0) {
            JOptionPane.showMessageDialog(null, "You tried entering: " +  tempVolume + ". The volume must be between 0-100.");
          } else {
            JOptionPane.showMessageDialog(null, "The volume has been set to: " +  tempVolume + "%");
            musicVolume = tempVolume;
            musicFile.amp(musicVolume / 100); // set it to it's default of 50% volume
            break;
          }
        }
      }
    }



    if (yCheck) { // if the user is pressing the button and not somewhere else
      bt5.hide();
    }
  }
}

void introScene() {
  background(227, 199, 162);
  // floor
  fill(156, 135, 108);
  //rect(120, 80, 220, 220);
  rect(0, 800, 800, 480);
  for (int i=height; i>=350; i-=10) {
    rect(0, i+10, width, i);
  }
  fill(79, 60, 45); //door
  rectMode(CORNERS);
  rect(550, 100, 675, 360);
  pushMatrix();
  rectMode(CORNER);
  rect(570, 120, 30, 100);
  translate(55, 0);
  rect(570, 120, 30, 100);
  translate(0, 125);
  rect(570, 120, 30, 100);
  translate(-55, 0);
  rect(570, 120, 30, 100);
  popMatrix();

  line(75, 0, 75, 360); //wall indications
  line(725, 0, 725, 360);

  fill(180, 95, 6);  //doormat
  rect(550, 365, 125, 70);

  fill(138, 0, 252); //curtain on window
  rect(150, 100, 300, 200);

  line(180, 100, 170, 300); //folds in the curtain
  line(210, 100, 190, 300);
  line(240, 100, 210, 300);
  line(270, 100, 230, 300);
  line(295, 100, 250, 300);
  line(300, 100, 300, 300);
  line(305, 100, 350, 300);
  line(330, 100, 370, 300);
  line(360, 100, 390, 300);
  line(390, 100, 410, 300);
  line(420, 100, 430, 300);

  strokeWeight(5);
  line(140, 100, 460, 100); //bar that holds the curtains up
  strokeWeight(1);

  pushMatrix();
  translate(-15, 0);
  delay(100);
  drawMom();
  drawDad();
  popMatrix();

  pushMatrix();
  scale(0.8);
  translate(50, 110);
  drawSitter();
  popMatrix();
  textSize(15);
  text("Press space to continue", 20, 32) ;
  textSize(20);
  if (sceneNum == 2 && sceneProgress == 1) {
    pushMatrix(); //small icon to show which character is talking
    scale(0.4);
    translate(-380, 870);
    fill(255, 242, 121);
    ellipse(500, 230, 130, 120);

    fill(252, 232, 194);
    ellipse(500, 250, 80, 80);
    popMatrix();

    fill(0);
    text("We're heading out, take good care of the baby okay " + username + "?", 100, 450);
  }
  if (sceneNum == 2 && sceneProgress == 2) {
    pushMatrix(); //small icon to show which character is talking
    scale(0.4);
    translate(-380, 870);
    fill(255, 242, 121);
    ellipse(500, 230, 130, 120);

    fill(252, 232, 194);
    ellipse(500, 250, 80, 80);
    popMatrix();

    fill(0);
    text("We left you some money for pizza, \nbut don't forget that the baby CAN'T have any!", 100, 450);
  }
  if (sceneNum == 2 && sceneProgress == 3) {
    pushMatrix(); //small icon to show which character is talking
    scale(0.4);
    translate(-380, 870);
    fill(255, 242, 121);
    ellipse(500, 230, 130, 120);

    fill(252, 232, 194);
    ellipse(500, 250, 80, 80);
    popMatrix();

    fill(0);
    text("because he'll throw up, \nand it'll be impossible to get out of the carpet", 100, 450);
  }

  if (sceneNum == 2 && sceneProgress == 4) {
    pushMatrix(); //small icon to show which character is talking
    scale(0.4);
    translate(-380, 870);
    fill(255, 242, 121);
    ellipse(500, 230, 130, 120);

    fill(252, 232, 194);
    ellipse(500, 250, 80, 80);
    popMatrix();

    fill(0);
    text("Also try to keep the baby out of trouble....", 100, 450);
  }

  if (sceneNum == 2 && sceneProgress >= 5 && momBodyX>=870) {
    pushMatrix(); //little icon to show speech
    scale(0.4);
    translate(0, 900);
    fill(252, 232, 194); //head
    ellipse(150, 200, 80, 80);
    fill(147, 105, 70);

    int hairY=200;
    beginShape(); //hair
    vertex(100, hairY);
    vertex(135, hairY-10);
    vertex(135, hairY-15);
    vertex(165, hairY-15);
    vertex(165, hairY-10);
    vertex(200, hairY);
    vertex(190, hairY-30);
    vertex(200, hairY-60);
    vertex(175, hairY-60);
    vertex(175, hairY-70);
    vertex(125, hairY-70);
    vertex(125, hairY-60);
    vertex(100, hairY-60);
    vertex(110, hairY-30);
    vertex(100, hairY);
    endShape(CLOSE);
    popMatrix();

    fill(0);
    text("yeah yeah whatever....", 100, 450);
  }
  if (sceneProgress >=6) {
    bt5.getController("Next").show();
  }
}

void babyFireSlide() {
  background(227, 199, 162);
  delay(100);
  fill(156, 135, 108);
  quad(0, 500, 75, 360, 725, 360, 800, 500); //floor
  triangle(737, 382, 783, 382, 783, 466); //floor of the other room on the right
  triangle(62, 382, 18, 382, 18, 466); //floor of the other room to the left

  line(75, 0, 75, 360); //wall indications
  line(725, 0, 725, 360);

  line(737, 382, 737, 125); //doorway on the right
  line(737, 125, 783, 165);
  line(783, 165, 783, 466);

  pushMatrix();
  translate(-675, 0);  //doorway on the left
  line(737, 382, 737, 125);
  translate(-90, 0);
  line(783, 165, 783, 466);
  popMatrix();
  line(62, 125, 18, 165);

  fill(234, 232, 232); //fridge
  rect(540, 90, 120, 290);
  quad(540, 90, 550, 70, 650, 70, 660, 90);

  fill(152); //countertop with stove
  rect(62, 300, 430, 82);
  quad(62, 300, 82, 250, 472, 250, 492, 300);

  fill(190); //stove control pannel
  rect(82, 200, 150, 50);

  line(232, 250, 252, 300);
  line(252, 300, 252, 382);

  fill(102); //oven door
  rect(87, 310, 135, 65);
  fill(82);
  rect(95, 320, 120, 10);

  fill(230); //stovetop
  quad(87, 290, 98, 260, 212, 260, 223, 290);
  fill(245, 0, 0);
  ellipse(125, 275, 25, 15);
  ellipse(125+55, 275, 25, 15);

  if (sceneProgress == 1) {
    pushMatrix(); //little icon to show speech
    scale(0.4);
    translate(0, 900);
    fill(252, 232, 194); //head
    ellipse(150, 200, 80, 80);
    fill(147, 105, 70);

    int hairY=200;
    beginShape(); //hair
    vertex(100, hairY);
    vertex(135, hairY-10);
    vertex(135, hairY-15);
    vertex(165, hairY-15);
    vertex(165, hairY-10);
    vertex(200, hairY);
    vertex(190, hairY-30);
    vertex(200, hairY-60);
    vertex(175, hairY-60);
    vertex(175, hairY-70);
    vertex(125, hairY-70);
    vertex(125, hairY-60);
    vertex(100, hairY-60);
    vertex(110, hairY-30);
    vertex(100, hairY);
    endShape(CLOSE);
    popMatrix();

    textFont(text);
    textSize(20);

    fill(0);
    text("Ugh, I can't believe I'm stuck babysitting you", 100, 450);
  }

  if (sceneProgress == 2) {
    pushMatrix();
    scale(0.9);
    translate(-240, 150);
    fill(252, 232, 194);
    ellipse(320, 340, 40, 40);
    popMatrix();

    fill(0);
    text("Goo goo ga ga", 100, 450);
  }

  if (sceneProgress == 3) {
    fill(150); // small icon showing that a phone just went off
    rect(70, 425, 20, 35);

    fill(0);
    text("*DING*", 100, 450);
  }

  if (sceneProgress == 4) {
    pushMatrix(); //little icon to show speech
    scale(0.4);
    translate(0, 900);
    fill(252, 232, 194); //head
    ellipse(150, 200, 80, 80);
    fill(147, 105, 70);

    int hairY=200;
    beginShape(); //hair
    vertex(100, hairY);
    vertex(135, hairY-10);
    vertex(135, hairY-15);
    vertex(165, hairY-15);
    vertex(165, hairY-10);
    vertex(200, hairY);
    vertex(190, hairY-30);
    vertex(200, hairY-60);
    vertex(175, hairY-60);
    vertex(175, hairY-70);
    vertex(125, hairY-70);
    vertex(125, hairY-60);
    vertex(100, hairY-60);
    vertex(110, hairY-30);
    vertex(100, hairY);
    endShape(CLOSE);
    popMatrix();

    fill(0);
    text("Oh, that reminds me, your parents left me some money for pizza", 100, 450);
  }

  if (sceneProgress >=6 && sitterArmY==250) {
    fill(150); // the phone that suddenly appears in the babysitters hand
    rect(560, 250, 20, 35);
  }
  if (sceneProgress == 6) {
    fill(0);
    text("**Blah Blah Blah, Pizza, Blah Blah**", 100, 450);
  }

  if (sceneProgress == 7) {
    pushMatrix();
    scale(0.9);
    translate(-240, 150);
    fill(252, 232, 194);
    ellipse(320, 340, 40, 40);
    popMatrix();

    fill(0);
    text("Ga...?", 100, 450);
  }
  pushMatrix();
  scale(0.8);
  translate(150, -65);
  drawBaby();
  popMatrix();

  if (sceneProgress >= 8 && babyX == 25) {
    fill(240, 173, 27); //the fire that appears to burn the baby
    triangle(90, 285, 125, 285, 100, fireY);
    triangle(125, 285, 175, 285, 150, fireY);
    triangle(175, 285, 215, 285, 200, fireY);
  }

  if (sceneProgress >= 9 && babyX == 25) {
    pushMatrix();
    scale(0.9);
    translate(-240, 150);
    fill(252, 232, 194);
    ellipse(320, 340, 40, 40);
    popMatrix();

    fill(0);
    text("Wahhhh wahhhhhhh \nWAHHHHHHHHHHHHHHHHH", 100, 450);
  }

  if (sceneProgress >= 10 && babyEmotion == "crying") {
    pushMatrix(); //little icon to show speech
    scale(0.4);
    translate(0, 900);
    fill(252, 232, 194); //head
    ellipse(150, 200, 80, 80);
    fill(147, 105, 70);

    int hairY=200;
    beginShape(); //hair
    vertex(100, hairY);
    vertex(135, hairY-10);
    vertex(135, hairY-15);
    vertex(165, hairY-15);
    vertex(165, hairY-10);
    vertex(200, hairY);
    vertex(190, hairY-30);
    vertex(200, hairY-60);
    vertex(175, hairY-60);
    vertex(175, hairY-70);
    vertex(125, hairY-70);
    vertex(125, hairY-60);
    vertex(100, hairY-60);
    vertex(110, hairY-30);
    vertex(100, hairY);
    endShape(CLOSE);
    popMatrix();

    fill(0);
    text("hm, oh, you're crying... \ncan you be quiet i'm trying to order pizza", 100, 450);
  }
  if (sceneProgress >= 11) {
    pushMatrix(); //little icon to show speech
    scale(0.4);
    translate(0, 900);
    fill(252, 232, 194); //head
    ellipse(150, 200, 80, 80);
    fill(147, 105, 70);

    int hairY=200;
    beginShape(); //hair
    vertex(100, hairY);
    vertex(135, hairY-10);
    vertex(135, hairY-15);
    vertex(165, hairY-15);
    vertex(165, hairY-10);
    vertex(200, hairY);
    vertex(190, hairY-30);
    vertex(200, hairY-60);
    vertex(175, hairY-60);
    vertex(175, hairY-70);
    vertex(125, hairY-70);
    vertex(125, hairY-60);
    vertex(100, hairY-60);
    vertex(110, hairY-30);
    vertex(100, hairY);
    endShape(CLOSE);
    popMatrix();

    fill(0);
    text("Gosh, you just won't pipe down, i'm putting you in your room!", 100, 450);
  }
  if (sceneProgress >=11) {
    bt5.getController("Next").show();
  }

  pushMatrix();
  scale(0.8);
  translate(900, 100);
  drawSitter();
  popMatrix();
}

void babyCribScene() {
  background(188, 150, 219);
  delay(100);
  fill(191, 146, 103); //floor
  quad(0, 500, 75, 360, 725, 360, 800, 500);
  triangle(737, 382, 783, 382, 783, 466); //floor of the room to the right

  line(75, 360, 75, 0); //wall indications
  line(725, 360, 725, 0);

  line(737, 382, 737, 125); //doorway on the right
  line(737, 125, 783, 165);
  line(783, 165, 783, 466);

  fill(94, 115, 240); //window
  quad(0, 200, 65, 100, 65, 275, 0, 375);
  line(32.5, 150, 32.5, 325);
  line(0, 287.5, 65, 187.5);

  pushMatrix();
  scale(0.8);
  translate(850, 50);
  drawBaby();
  popMatrix();

  fill(255, 238, 175); //the baby's crib
  rect(85, 250, 10, 150);
  rect(85+210, 250, 10, 150);
  rect(95, 280, 200, 10);
  rect(95, 280+100, 200, 10);

  fill(142, 193, 255); //crib cushion
  rect(95, 360, 200, 20);

  fill(255, 238, 175); //crib bars
  for (int i=100; i<300; i=i+25) {
    rect(i, 290, 10, 90);
  }

  pushMatrix();
  scale(0.8);
  translate(900, 75);
  drawSitter();
  popMatrix();

  if (sceneProgress == 0) {
    pushMatrix(); //little icon to show speech
    scale(0.4);
    translate(0, 900);
    fill(252, 232, 194); //head
    ellipse(150, 200, 80, 80);
    fill(147, 105, 70);

    int hairY=200;
    beginShape(); //hair
    vertex(100, hairY);
    vertex(135, hairY-10);
    vertex(135, hairY-15);
    vertex(165, hairY-15);
    vertex(165, hairY-10);
    vertex(200, hairY);
    vertex(190, hairY-30);
    vertex(200, hairY-60);
    vertex(175, hairY-60);
    vertex(175, hairY-70);
    vertex(125, hairY-70);
    vertex(125, hairY-60);
    vertex(100, hairY-60);
    vertex(110, hairY-30);
    vertex(100, hairY);
    endShape(CLOSE);
    popMatrix();

    fill(0);
    text("Stay here until your parents come home you understand?", 100, 450);
  }
  if (sceneProgress == 1) {
    pushMatrix();
    scale(0.9);
    translate(-240, 150);
    fill(252, 232, 194);
    ellipse(320, 340, 40, 40);
    popMatrix();

    fill(0);
    text("gaaaaaa, gwahhhhhhhhh", 100, 450);
  }
  if (sceneProgress == 2) {
    pushMatrix(); //little icon to show speech
    scale(0.4);
    translate(0, 900);
    fill(252, 232, 194); //head
    ellipse(150, 200, 80, 80);
    fill(147, 105, 70);

    int hairY=200;
    beginShape(); //hair
    vertex(100, hairY);
    vertex(135, hairY-10);
    vertex(135, hairY-15);
    vertex(165, hairY-15);
    vertex(165, hairY-10);
    vertex(200, hairY);
    vertex(190, hairY-30);
    vertex(200, hairY-60);
    vertex(175, hairY-60);
    vertex(175, hairY-70);
    vertex(125, hairY-70);
    vertex(125, hairY-60);
    vertex(100, hairY-60);
    vertex(110, hairY-30);
    vertex(100, hairY);
    endShape(CLOSE);
    popMatrix();

    fill(0);
    text("yeah yeah I get it....", 100, 450);
  }
  if (sceneProgress >=3) {
    bt5.getController("Next").show();
  }
}

void babyCrawlScene() {
  background(188, 150, 219);
  delay(100);
  fill(156, 135, 108);
  quad(0, 500, 75, 360, 725, 360, 800, 500); //floor
  triangle(62, 382, 18, 382, 18, 466); //floor of the other room to the left
  quad(725, 360, 762.5, 360, 800, 430, 800, 500);//stairs going downwards
  triangle(774, 380, 800, 380, 800, 430);

  line(75, 360, 75, 0); //wall indications
  line(725, 360, 725, 0);

  pushMatrix();
  translate(-675, 0);  //doorway on the left
  line(737, 382, 737, 125);
  translate(-90, 0);
  line(783, 165, 783, 466);
  popMatrix();
  line(62, 125, 18, 165);

  fill(206, 206, 200); //open door
  quad(18, 165, 100, 200, 100, 501, 18, 466);

  line(300, 50, 250, 75); //string hanging the painting
  line(300, 50, 350, 75);

  fill(255, 132, 31);  // painting canvas
  rect(225, 75, 150, 100);
  fill(159, 250, 96);
  beginShape();
  vertex(310, 90);
  vertex(330, 90);
  vertex(330, 110);
  vertex(350, 110);
  vertex(350, 130);
  vertex(330, 130);
  vertex(330, 150);
  vertex(310, 150);
  vertex(310, 130);
  vertex(290, 130);
  vertex(290, 110);
  vertex(310, 110);
  endShape(CLOSE);

  line(550, 135, 450, 155);//string hanging painting two
  line(550, 135, 650, 155);

  fill(219, 175, 219); //painting two canvas
  rect(425, 155, 250, 50);
  fill(88, 164, 255);
  rect(435, 173, 230, 15);

  line(340, 200, 320, 210); //string hanging painting three
  line(340, 200, 360, 210);

  fill(255, 247, 185); //painting three canvas
  rect(310, 210, 60, 130);
  strokeWeight(3);
  line(325, 230, 325, 320);
  line(355, 230, 355, 320);
  line(325, 230, 330, 225);
  line(355, 230, 350, 225);
  line(325, 320, 330, 325);
  line(355, 320, 350, 325);
  strokeWeight(5);
  point(322, 275);
  point(358, 275);
  strokeWeight(1);

  pushMatrix();
  scale(0.8);
  translate(-210, 125);
  drawBaby();
  popMatrix();

  fill(206, 206, 200); //open door
  quad(18, 165, 100, 200, 100, 501, 18, 466);

  if (sceneProgress == 0) {
    fill(0);
    text("it seems as if the babysitter left the door open, \nallowing the baby to escape it's room", 150, 450);
  }

  if (sceneProgress >= 1 && babyX == 1100) {
    pushMatrix();
    scale(0.9);
    translate(-240, 150);
    fill(252, 232, 194);
    ellipse(320, 340, 40, 40);
    popMatrix();

    fill(0);

    text("Guh, gwoohhhh", 100, 450);
  }
  if (sceneProgress >=2 && babyX == 1100) {
    bt5.getController("Next").show();
  }
}

void babyFallScene() {
  background(90);
  delay(100);
  fill(116, 65, 43); //top of each step
  int topX=0;
  int topY;
  for (topY=475; topY>=0; topY=topY-50) {
    quad(topX, topY, topX+35, topY-25, 800-(topX+35), topY-25, 800-topX, topY);
    topX=topX+35;
  }

  fill(188, 106, 70); // the vertical part of each step
  int stepX=0;
  int stepY;
  for (stepY=475; stepY>=0; stepY=stepY-50) {
    rect(stepX, stepY, 800-stepX*2, 25);
    stepX=stepX+35;
  }
  line(0, 475, 332, 0);  //wall indicators
  line(800, 475, 800-332, 0);

  pushMatrix();
  translate(100, -500);
  drawBaby();
  popMatrix();

  if (sceneNum >= 0) {
    fill(0);
    textSize(100);
    text("GAHHAHDHAHGJ!!!!!!!!!!!!", 0, 450);
    textSize(20);
  }
  if (sceneProgress >=1) {
    bt5.getController("Next").show();
  }
}

void babyPickupScene() {
  background(130);
  delay(100);
  fill(156, 135, 108);
  quad(0, 500, 75, 360, 725, 360, 800, 500);
  triangle(737, 382, 783, 382, 783, 466); //floor of the room to the right

  line(75, 360, 75, 0); //wall indications
  line(725, 360, 725, 0);

  line(737, 382, 737, 125); //doorway on the right
  line(737, 125, 783, 165);
  line(783, 165, 783, 466);
  fill(227, 199, 162);
  quad(737, 125, 782, 165, 783, 382, 737, 382);

  fill(188, 106, 70); // the vertical part of each step
  quad(0, 500, 0, 450, 75, 310, 75, 360);
  quad(0, 400, 0, 350, 50, 260, 50, 310);
  quad(0, 300, 0, 250, 25, 210, 25, 260);

  fill(116, 65, 43); //top of each step
  quad(0, 450, 0, 400, 50, 310, 75, 310);
  quad(0, 350, 0, 300, 25, 260, 50, 260);
  triangle(0, 250, 0, 210, 25, 210);

  strokeWeight(10);  //handrail
  stroke(183, 166, 79);
  line(-25, 150, 70, 210);
  stroke(0);
  strokeWeight(1);

  fill(105, 91, 83); //shelving units
  pushMatrix();
  quad(120, 150, 140, 120, 280, 120, 300, 150); //shelf one
  triangle(140, 150, 150, 170, 160, 150);
  triangle(280, 150, 270, 170, 260, 150);
  translate(350, 80);
  quad(120, 150, 140, 120, 280, 120, 300, 150); //shelf two
  triangle(140, 150, 150, 170, 160, 150);
  triangle(280, 150, 270, 170, 260, 150);
  popMatrix();

  pushMatrix();
  scale(0.8);
  translate(-350, -50);
  drawBaby();
  popMatrix();

  pushMatrix();
  scale(0.8);
  translate(1000, 100);
  drawSitter();
  popMatrix();

  if (sceneProgress == 1) {
    pushMatrix(); //little icon to show speech
    scale(0.4);
    translate(0, 900);
    fill(252, 232, 194); //head
    ellipse(150, 200, 80, 80);
    fill(147, 105, 70);

    int hairY=200;
    beginShape(); //hair
    vertex(100, hairY);
    vertex(135, hairY-10);
    vertex(135, hairY-15);
    vertex(165, hairY-15);
    vertex(165, hairY-10);
    vertex(200, hairY);
    vertex(190, hairY-30);
    vertex(200, hairY-60);
    vertex(175, hairY-60);
    vertex(175, hairY-70);
    vertex(125, hairY-70);
    vertex(125, hairY-60);
    vertex(100, hairY-60);
    vertex(110, hairY-30);
    vertex(100, hairY);
    endShape(CLOSE);
    popMatrix();


    fill(0);
    text("gosh, aren't you old enough to not fall down the stairs", 100, 450);
  }

  if (sceneProgress == 2) {
    pushMatrix();
    scale(0.9);
    translate(-240, 150);
    fill(252, 232, 194);
    ellipse(320, 340, 40, 40);
    popMatrix();

    fill(0);
    text("*hic hic* wahhahahahhhhahah", 100, 450);
  }

  if (sceneProgress == 3) {
    pushMatrix(); //little icon to show speech
    scale(0.4);
    translate(0, 950);
    fill(252, 232, 194); //head
    ellipse(150, 200, 80, 80);
    fill(147, 105, 70);

    int hairY=200;
    beginShape(); //hair
    vertex(100, hairY);
    vertex(135, hairY-10);
    vertex(135, hairY-15);
    vertex(165, hairY-15);
    vertex(165, hairY-10);
    vertex(200, hairY);
    vertex(190, hairY-30);
    vertex(200, hairY-60);
    vertex(175, hairY-60);
    vertex(175, hairY-70);
    vertex(125, hairY-70);
    vertex(125, hairY-60);
    vertex(100, hairY-60);
    vertex(110, hairY-30);
    vertex(100, hairY);
    endShape(CLOSE);
    popMatrix();

    fill(0);
    text("The pizza is here now anyway, \nand because I clearly can't leave you alone \nyou're coming with me", 100, 425);
  }
  if (sceneProgress >=4) {
    bt5.getController("Next").show();
  }
}

void babyPizzaScene() {
  background(227, 199, 162);
  delay(100);
  fill(156, 135, 108);
  quad(0, 500, 75, 360, 725, 360, 800, 500); //floor
  rect(125, 270, 550, 90); //floor of the room that is visible through the wall opening

  fill(130); //wall colour of the other room
  rect(125, 50, 550, 220);

  line(75, 0, 75, 360); //wall indications
  line(725, 0, 725, 360);

  pushMatrix();
  scale(0.8);
  translate(-900, -15);
  drawMom();
  drawDad();
  popMatrix();

  fill(227, 199, 162);
  rect(0, 0, 125, 360);  //invisible block for the purpose of making it seem like the parents are in the background
  line(125, 360, 125, 50); //open concept wall opening
  line(675, 360, 675, 50);
  line(125, 50, 675, 50);

  pushMatrix();
  scale(0.8);
  translate(700, 50);
  drawSitter();
  popMatrix();

  fill(178, 130, 54); //table in the center of the room
  beginShape(); //table stand
  vertex(250, 430);
  vertex(550, 430);
  vertex(530, 470);
  vertex(540, 490);
  vertex(480, 490);
  vertex(400, 470);
  vertex(320, 490);
  vertex(260, 490);
  vertex(270, 470);
  endShape(CLOSE);
  fill(220, 160, 60); //table top
  ellipse(400, 380, 500, 150);

  fill(180, 122, 33); //pizza that will be eaten by the baby
  ellipse(300, 370, 120, 70);
  fill(250, 72, 8);
  ellipse(300, 370, 110, 60);
  fill(245, 250, 187);
  ellipse(300, 370, 105, 55);

  pushMatrix();
  scale(0.8);
  translate(300, 70);
  drawBaby();
  popMatrix();


  if (sceneProgress == 1) {
    pushMatrix();
    scale(0.9);
    translate(-240, 150);
    fill(252, 232, 194);
    ellipse(320, 340, 40, 40);
    popMatrix();

    fill(0);
    text("*sniff sniff* guh?", 100, 450);
  }

  if (sceneProgress == 2) {
    pushMatrix();
    scale(0.9);
    translate(-240, 150);
    fill(252, 232, 194);
    ellipse(320, 340, 40, 40);
    popMatrix();

    fill(0);
    text("*munch munch* \nGurk, guugugugu", 100, 450);
  }

  if (sceneProgress == 3) {
    pushMatrix(); //little icon to show speech
    scale(0.4);
    translate(0, 900);
    fill(252, 232, 194); //head
    ellipse(150, 200, 80, 80);
    fill(147, 105, 70);

    int hairY=200;
    beginShape(); //hair
    vertex(100, hairY);
    vertex(135, hairY-10);
    vertex(135, hairY-15);
    vertex(165, hairY-15);
    vertex(165, hairY-10);
    vertex(200, hairY);
    vertex(190, hairY-30);
    vertex(200, hairY-60);
    vertex(175, hairY-60);
    vertex(175, hairY-70);
    vertex(125, hairY-70);
    vertex(125, hairY-60);
    vertex(100, hairY-60);
    vertex(110, hairY-30);
    vertex(100, hairY);
    endShape(CLOSE);
    popMatrix();


    fill(0);
    text("What the heck is wrong with you! \nget off of the pizza!", 100, 450);
  }

  if (sceneProgress == 4) {
    pushMatrix(); //little icon to show speech
    scale(0.4);
    translate(0, 900);
    fill(252, 232, 194); //head
    ellipse(150, 200, 80, 80);
    fill(147, 105, 70);

    int hairY=200;
    beginShape(); //hair
    vertex(100, hairY);
    vertex(135, hairY-10);
    vertex(135, hairY-15);
    vertex(165, hairY-15);
    vertex(165, hairY-10);
    vertex(200, hairY);
    vertex(190, hairY-30);
    vertex(200, hairY-60);
    vertex(175, hairY-60);
    vertex(175, hairY-70);
    vertex(125, hairY-70);
    vertex(125, hairY-60);
    vertex(100, hairY-60);
    vertex(110, hairY-30);
    vertex(100, hairY);
    endShape(CLOSE);
    popMatrix();

    fill(0);
    text("Oh no, don't you dare throw up!", 100, 450);
  }
  if (sceneProgress >=5 && babyX==100) {
    fill(59, 155, 12);
    triangle(babyX+255, babyY-20, vomitX, vomitY, vomitX, vomitY+40);
  }
  if (sceneProgress == 5 && babyEmotion=="sick") {

    fill(0);
    textSize(70);
    text("BLEHHHHHHHHHHHHHHH", 50, 450);
    textSize(20);
  }
  if (sceneProgress == 6) {
    pushMatrix(); //little icon to show speech
    scale(0.4);
    translate(0, 900);
    fill(252, 232, 194); //head
    ellipse(150, 200, 80, 80);
    fill(147, 105, 70);

    int hairY=200;
    beginShape(); //hair
    vertex(100, hairY);
    vertex(135, hairY-10);
    vertex(135, hairY-15);
    vertex(165, hairY-15);
    vertex(165, hairY-10);
    vertex(200, hairY);
    vertex(190, hairY-30);
    vertex(200, hairY-60);
    vertex(175, hairY-60);
    vertex(175, hairY-70);
    vertex(125, hairY-70);
    vertex(125, hairY-60);
    vertex(100, hairY-60);
    vertex(110, hairY-30);
    vertex(100, hairY);
    endShape(CLOSE);
    popMatrix();

    fill(0);
    textSize(50);
    text("EWWWWWW WHYYYYYYYYYYYY", 100, 450);
    textSize(20);
  }
  if (sceneProgress == 7) {
    pushMatrix(); //little icon to show speech
    scale(0.4);
    translate(0, 900);
    fill(252, 232, 194); //head
    ellipse(150, 200, 80, 80);
    fill(147, 105, 70);

    int hairY=200;
    beginShape(); //hair
    vertex(100, hairY);
    vertex(135, hairY-10);
    vertex(135, hairY-15);
    vertex(165, hairY-15);
    vertex(165, hairY-10);
    vertex(200, hairY);
    vertex(190, hairY-30);
    vertex(200, hairY-60);
    vertex(175, hairY-60);
    vertex(175, hairY-70);
    vertex(125, hairY-70);
    vertex(125, hairY-60);
    vertex(100, hairY-60);
    vertex(110, hairY-30);
    vertex(100, hairY);
    endShape(CLOSE);
    popMatrix();

    fill(0);
    text("YOU STUPID BABY!!!", 100, 450);
  }
  if (sceneProgress !=1 && momBodyX == 1200) {
    fill(0);
    text("how DARE you treat our baby like this! \nwe were watching you on the security cameras the ENTIRE time \nNOW GET OUT!!!", 100, 425);
  }
  if (sceneProgress >=8 && momBodyX == 1200) {
    bt5.getController("Next").show();
  }
}

void tornadoScene() {
  background(20, 60, 72);

  delay(100);
  fill(144, 45, 45);  //the house that the babysitter was in for the entire story in the background
  rect(0, 0, 400, 250);
  quad(400, 0, 500, 0, 500, 150, 400, 250);

  fill(138, 0, 252); //curtain seen through the window of the house
  rect(75, 50, 250, 150);

  line(125, 50, 105, 200); //curtain ripples
  line(165, 50, 135, 200);
  line(200, 50, 160, 200);
  line(210, 50, 240, 200);
  line(230, 50, 270, 200);
  line(280, 50, 300, 200);

  fill(79, 60, 45); //open door from which the babysitter was kicked out of
  quad(425, 75, 525, 100, 525, 250, 425, 225);

  fill(227, 199, 162);
  triangle(425, 75, 490, 50, 490, 90);

  pushMatrix();
  scale(0.9);
  translate(600, 50);
  drawSitter();
  popMatrix();
  fill(103); //drawing the big bad tornado that comes by to ruin the babysitters night
  triangle(tornadoX-20, 60, tornadoX+200, 60, tornadoX+20, 475); //funnel of the tornado
  arc (tornadoX, -20, 250, 210, radians (55), radians(190)); //clouds that the tornado is coming out of
  arc (tornadoX+140, -20, 300, 220, radians(0), radians(180));
  arc(tornadoX+70, -20, 200, 230, radians(0), radians(180));
  if (sceneProgress == 1) {
    pushMatrix(); //little icon to show speech
    scale(0.4);
    translate(0, 900);
    fill(252, 232, 194); //head
    ellipse(150, 200, 80, 80);
    fill(147, 105, 70);

    int hairY=200;
    beginShape(); //hair
    vertex(100, hairY);
    vertex(135, hairY-10);
    vertex(135, hairY-15);
    vertex(165, hairY-15);
    vertex(165, hairY-10);
    vertex(200, hairY);
    vertex(190, hairY-30);
    vertex(200, hairY-60);
    vertex(175, hairY-60);
    vertex(175, hairY-70);
    vertex(125, hairY-70);
    vertex(125, hairY-60);
    vertex(100, hairY-60);
    vertex(110, hairY-30);
    vertex(100, hairY);
    endShape(CLOSE);
    popMatrix();

    fill(0);
    text("Dammit, I can't believe they kicked me out", 100, 450);
  }

  if (sceneProgress == 2) {
    pushMatrix(); //little icon to show speech
    scale(0.4);
    translate(0, 900);
    fill(252, 232, 194); //head
    ellipse(150, 200, 80, 80);
    fill(147, 105, 70);

    int hairY=200;
    beginShape(); //hair
    vertex(100, hairY);
    vertex(135, hairY-10);
    vertex(135, hairY-15);
    vertex(165, hairY-15);
    vertex(165, hairY-10);
    vertex(200, hairY);
    vertex(190, hairY-30);
    vertex(200, hairY-60);
    vertex(175, hairY-60);
    vertex(175, hairY-70);
    vertex(125, hairY-70);
    vertex(125, hairY-60);
    vertex(100, hairY-60);
    vertex(110, hairY-30);
    vertex(100, hairY);
    endShape(CLOSE);
    popMatrix();

    fill(0);
    text("Uh oh, is, is IS THAT A TORNDAO!!!", 100, 450);
  }
  if (sceneProgress == 4) {
    pushMatrix(); //little icon to show speech
    scale(0.4);
    translate(0, 900);
    fill(252, 232, 194); //head
    ellipse(150, 200, 80, 80);
    fill(147, 105, 70);

    int hairY=200;
    beginShape(); //hair
    vertex(100, hairY);
    vertex(135, hairY-10);
    vertex(135, hairY-15);
    vertex(165, hairY-15);
    vertex(165, hairY-10);
    vertex(200, hairY);
    vertex(190, hairY-30);
    vertex(200, hairY-60);
    vertex(175, hairY-60);
    vertex(175, hairY-70);
    vertex(125, hairY-70);
    vertex(125, hairY-60);
    vertex(100, hairY-60);
    vertex(110, hairY-30);
    vertex(100, hairY);
    endShape(CLOSE);
    popMatrix();

    fill(0);
    textSize(50);
    text("AHHHH!!!!", 100, 450);
    textSize(20);
  }
}


void splashScreen() {
  noStroke();
  babyEmotion = "sick";
  parentsMad=true;
  sitterEmotion="unamused";

  background(252, 229, 205); // beige bc
  fill(102, 0, 0);
  beginShape();
  vertex(0, 170);
  vertex(20, 260);
  vertex(34, 289);
  vertex(47, 247);
  vertex(50, 200);
  vertex(68, 225);
  vertex(86, 244);
  vertex(100, 280);
  vertex(140, 225);
  vertex(159, 143);
  vertex(180, 200);
  vertex(190, 270);
  vertex(230, 180);
  vertex(260, 220);
  vertex(280, 300);
  vertex(312, 234);
  vertex(330, 156);
  vertex(360, 278);
  vertex(434, 200);
  vertex(450, 140);
  vertex(489, 190);
  vertex(520, 280);
  vertex(587, 123);
  vertex(600, 238);
  vertex(634, 304);
  vertex(658, 259);
  vertex(687, 234);
  vertex(700, 130);
  vertex(734, 175);
  vertex(756, 233);
  vertex(776, 198);
  vertex(800, 130);
  vertex(800, 800);
  vertex(0, 800);

  endShape(CLOSE);

  fill(246, 178, 107);
  beginShape();
  vertex(0, 220);
  vertex(20, 310);
  vertex(34, 329);
  vertex(47, 297);
  vertex(60, 250);
  vertex(68, 275);
  vertex(86, 294);
  vertex(100, 320);
  vertex(140, 275);
  vertex(159, 193);
  vertex(180, 250);
  vertex(190, 320);
  vertex(230, 230);
  vertex(260, 270);
  vertex(280, 350);
  vertex(312, 284);
  vertex(330, 206);
  vertex(360, 328);
  vertex(434, 250);
  vertex(450, 190);
  vertex(489, 240);
  vertex(520, 335);
  vertex(577, 193);
  vertex(600, 288);
  vertex(634, 354);
  vertex(658, 309);
  vertex(687, 284);
  vertex(720, 180);
  vertex(734, 235);
  vertex(756, 283);
  vertex(776, 248);
  vertex(800, 180);

  vertex(800, 800);
  vertex(0, 800);

  endShape(CLOSE);



  int spacing = 7; // pixels between lines
  int len = 6; // pixel length of each line
  int baseY = 100; // base Y value to position other elements off of
  textSize(15);
  fill(102, 0, 0); // red
  text("By Jason Cameron & Simon Michetti Studios", 76, baseY-10);
  textSize(20); // set it back to the original 20
  for (int x=90; x<=340; x+=(spacing+len)) {// from 300 to 100
    strokeWeight(4);
    stroke(241, 194, 50); // gold
    line(x, baseY, x+len, baseY);
  }
  for (int x=110; x<=320; x+=(spacing+len)) {// from 300 to 100
    strokeWeight(3);
    stroke(246, 178, 107); // orange
    line(x, baseY + 10, x+len, baseY + 10);
    x += (spacing + len) / 1.5;
  }
  for (int x=130; x<=300; x+=(spacing+len)) {// from 270 to 130
    strokeWeight(2.7);
    stroke(102, 0, 0); // red
    line(x, baseY+20, x+len, baseY+20);
  }


  // dont toych
  if (sceneNum == 0) {
    stroke(0);
    pushMatrix();
    translate(0, 100);
    scale(0.8);
    drawMom();
    drawDad();
    pushMatrix();
    translate(30, 100);
    scale(0.8);
    drawSitter();
    popMatrix();
    drawBaby();
    popMatrix();
  }
}


void drawSitter() {
  int hairY=200;

  if (sitterEmotion=="angry") {
    fill(252, 232, 194); //head
    ellipse(sitterX, 200, 80, 80);
    fill(0); //eyes
    arc(sitterX-20, 200, 30, 30, radians(45), radians(225));
    arc(sitterX+20, 200, 30, 30, radians(315), radians(495));

    stroke(1);
    line(sitterX, 120, sitterX-10, 110); //steam coming from the babysitters head
    line(sitterX-10, 110, sitterX+5, 110);
    strokeWeight(2);
    line(sitterX+5, 110, sitterX-15, 100);
    line(sitterX-15, 100, sitterX+10, 100);
    strokeWeight(3);
    line(sitterX+10, 100, sitterX-20, 90);
    line(sitterX-20, 90, sitterX+15, 90);
    strokeWeight(4);
    line(sitterX+15, 90, sitterX-25, 80);
    line(sitterX-25, 80, sitterX+20, 80);
    strokeWeight(5);
    line(sitterX+20, 80, sitterX-30, 70);
    line(sitterX-30, 70, sitterX+25, 70);
    strokeWeight(6);
    line(sitterX+25, 70, sitterX-35, 60);
    line(sitterX-35, 60, sitterX+30, 60);
    strokeWeight(7);
    line(sitterX+30, 60, sitterX-40, 50);
    line(sitterX-40, 50, sitterX+35, 50);
  } else if (sitterEmotion=="shocked") {
    strokeWeight(1);
    fill(252, 232, 194); //head
    ellipse(sitterX, 200, 80, 80);
    fill(0); //eyes
    ellipse(sitterX-20, 200, 30, 40);
    ellipse(sitterX+20, 200, 30, 40);

    hairY=160;
  } else { // unamused
    stroke(0);
    fill(252, 232, 194); //head
    ellipse(sitterX, 200, 80, 80);
    fill(0); //eyes
    arc(sitterX-20, 200, 30, 30, radians(0), radians(180));
    arc(sitterX+20, 200, 30, 30, radians(0), radians(180));
  }


  stroke(0);
  strokeWeight(1);
  fill(212, 242, 247); //body
  rect(sitterX-40, 240, 80, 150);

  fill(255, 168, 62); //stripes on the shirt
  for (int i=265; i<380; i=i+40) {
    rect(sitterX-40, i, 80, 20);
  }

  line(sitterX-40, 240, sitterX-60, 300); //left arm
  line(sitterX-60, 300, sitterX-60, sitterArmY2);

  line(sitterX+40, 240, sitterX+60, 300); //right arm
  line(sitterX+60, 300, sitterArmX, sitterArmY);

  line(sitterX-30, 390, sitterX-30, 450); //left leg
  line(sitterX-30, 450, sitterX-40, 450);

  line(sitterX+30, 390, sitterX+30, 450); //right leg
  line(sitterX+30, 450, sitterX+40, 450);

  fill(147, 105, 70);
  beginShape(); //hair
  vertex(sitterX-50, hairY);
  vertex(sitterX-15, hairY-10);
  vertex(sitterX-15, hairY-15);
  vertex(sitterX+15, hairY-15);
  vertex(sitterX+15, hairY-10);
  vertex(sitterX+50, hairY);
  vertex(sitterX+40, hairY-30);
  vertex(sitterX+50, hairY-60);
  vertex(sitterX+25, hairY-60);
  vertex(sitterX+25, hairY-70);
  vertex(sitterX-25, hairY-70);
  vertex(sitterX-25, hairY-60);
  vertex(sitterX-50, hairY-60);
  vertex(sitterX-40, hairY-30);
  vertex(sitterX-50, hairY);
  endShape(CLOSE);

  if (sitterEmotion=="shocked") {
    noFill();  //eyebrows
    strokeWeight(10);
    stroke(144, 119, 80);
    arc(sitterX-20, 160, 20, 30, radians(180), radians(360));
    arc(sitterX+20, 160, 20, 30, radians(180), radians(360));
    stroke(0);
    strokeWeight(1);
  }
}


void drawMom() {
  fill(255, 242, 121); //hair
  ellipse(momBodyX, 230, 130, 120);

  fill(252, 232, 194); //head
  ellipse(momBodyX, 250, 80, 80);

  fill(240, 126, 225); //dress
  triangle(momBodyX, 302, momBodyX-50, 402, momBodyX+50, 402);
  triangle(momBodyX-50, 292, momBodyX+50, 292, momBodyX, 352);

  line(momBodyX-50, 292, momBodyX-60, 332); //left mom arm
  line(momBodyX-60, 332, momArmX+40, momArmY+150);

  line(momBodyX+50, 292, momBodyX+60, 332); //right arm
  line(momBodyX+60, 332, momBodyX+60, 382);

  line(momBodyX-30, 402, momBodyX-30, 452); //left leg
  line(momBodyX-30, 452, momBodyX-40, 452);

  line(momBodyX+30, 402, momBodyX+30, 452); //right leg
  line(momBodyX+30, 452, momBodyX+40, 452);

  fill(0); //eyes
  ellipse(momBodyX-20, 255, 25, 25); //left eye
  ellipse(momBodyX+20, 255, 25, 25); //right eye

  if (parentsMad==true) {
    fill(252, 232, 194); //head
    ellipse(momBodyX, 250, 80, 80);
    fill(0);
    arc(momBodyX-20, 255, 25, 25, radians(45), radians(225));
    arc(momBodyX+20, 255, 25, 25, radians(315), radians(495));
  }
}

void drawDad() {
  fill(252, 232, 194); //head
  ellipse(dadBodyX, 150, 80, 80);

  fill(55); //body
  rect(dadBodyX-30, 210, 60, 175);

  fill(255); //suit detail
  triangle(dadBodyX-10, 210, dadBodyX, 240, dadBodyX+10, 210);

  line(dadBodyX-30, 210, dadBodyX-50, 280); //left arm
  line(dadBodyX-50, 280, dadBodyX-50, 350);

  line(dadBodyX+30, 210, dadBodyX+50, 280); //right arm
  line(dadBodyX+50, 280, dadBodyX+50, 350);

  line(dadBodyX-20, 385, dadBodyX-20, 455); //left leg
  line(dadBodyX-20, 455, dadBodyX-30, 455);

  line(dadBodyX+20, 385, dadBodyX+20, 455); //right leg
  line(dadBodyX+20, 455, dadBodyX+30, 455);

  fill(0); //glasses
  ellipse(dadBodyX-20, 155, 20, 20);
  ellipse(dadBodyX+20, 155, 20, 20);
  strokeWeight(5);
  line(dadBodyX-20, 155, dadBodyX+20, 155);

  strokeWeight(1);
  fill(255, 242, 121); //beard
  arc(dadBodyX, 180, 40, 30, radians(180), radians(360));
  arc(dadBodyX-20, 190, 40, 30, radians(135), radians(270));
  arc(dadBodyX-15, 205, 40, 30, radians(70), radians(190));
  arc(dadBodyX+5, 220, 30, 20, radians(0), radians(180));
  arc(dadBodyX+20, 200, 40, 40, radians(270), radians(450));
  noStroke();
  ellipse(dadBodyX+3, 200, 70, 43);

  if (parentsMad==true) {
    stroke(0);
    fill(252, 232, 194); //head
    ellipse(dadBodyX, 150, 80, 80);
    fill(0);
    arc(dadBodyX-20, 155, 20, 20, radians(45), radians(225));
    arc(dadBodyX+20, 155, 20, 20, radians(315), radians(495));
    fill(255, 242, 121); //beard
    arc(dadBodyX, 180, 40, 30, radians(180), radians(360));
    arc(dadBodyX-20, 190, 40, 30, radians(135), radians(270));
    arc(dadBodyX-15, 205, 40, 30, radians(70), radians(190));
    arc(dadBodyX+5, 220, 30, 20, radians(0), radians(180));
    arc(dadBodyX+20, 200, 40, 40, radians(270), radians(450));
    noStroke();
    ellipse(dadBodyX+3, 200, 70, 43);
  }
}

void drawBaby() {
  if (sceneNum != 5) {
    stroke(0);
    fill(252, 232, 194);
    rect(babyX, babyY, 40, 40, 50, 50, 0, 0); //body

    fill(255);
    rect(babyX-5, babyY+30, 50, 10); //diaper
    quad(babyX, babyY+40, babyX+40, babyY+40, babyX+35, babyY+60, babyX+5, babyY+60);

    fill(252, 232, 194);
    rect(babyX-40, babyY+10, 40, 10); //arms
    rect(babyX+40, babyY+10, 40, 10);

    quad(babyX+3, babyY+48, babyX+5, babyY+60, babyX-40, babyY+70, babyX-40, babyY+60); //legs
    quad(babyX+37, babyY+48, babyX+35, babyY+60, babyX+80, babyY+70, babyX+80, babyY+60);


    if (babyEmotion=="sick") {
      fill (167, 222, 157);
      ellipse(babyX+20, babyY-10, 40, 40); //head

      fill(0);  //eyes
      arc(babyX+10, babyY-10, 10, 15, radians(180), radians(360));
      arc(babyX+30, babyY-10, 10, 15, radians(180), radians(360));
    } else if (babyEmotion=="crying") {
      fill(252, 232, 194);
      ellipse(babyX+20, babyY-10, 40, 40); //head

      fill(0);
      ellipse(babyX+5, babyY-10, 15, 10); //eyes
      ellipse(babyX+35, babyY-10, 15, 10);

      fill(86, 218, 250);  //tears
      rect(babyX-1, babyY-5, 10, 20);
      rect(babyX+29, babyY-5, 10, 20);
    } else if (babyEmotion=="shocked") {
      fill(252, 232, 194);
      ellipse(babyX+20, babyY-10, 40, 40); //head

      fill(0);
      ellipse(babyX+10, babyY-10, 10, 20); //eyes
      ellipse(babyX+30, babyY-10, 10, 20);

      noFill();  //eyebrows
      stroke(255, 242, 121);
      strokeWeight(5);
      arc(babyX+10, babyY-25, 10, 10, radians(180), radians(360));
      arc(babyX+30, babyY-25, 10, 10, radians(180), radians(360));

      stroke(0);
      strokeWeight(1);
    } else {
      fill(252, 232, 194);
      ellipse(babyX+20, babyY-10, 40, 40); //head
      fill(0);
      ellipse(babyX+10, babyY-10, 10, 10); //eyes
      ellipse(babyX+30, babyY-10, 10, 10);
    }
  }

  if (sceneNum==5) {  //baby in a crawling position that only appears in this scene
    fill(252, 232, 194);
    rect(babyX-25, 350, 60, 30, 50, 50, 0, 0); //body

    fill(255);
    rect(babyX-15, 345, 10, 40); //diaper
    quad(babyX-15, 345, babyX-15, 385, babyX-40, 375, babyX-40, 355);

    fill(252, 232, 194);
    ellipse(babyX+30, 340, 40, 40); //head
    fill(0);
    ellipse(babyX+20, 340, 10, 10); //eyes
    ellipse(babyX+40, 340, 10, 10);

    fill(252, 232, 194);

    pushMatrix();
    translate(-35, -30);
    quad(babyX+3, 398, babyX+5, 410, babyX-40, 420, babyX-40, 410); //legs of the crawling baby
    popMatrix();

    pushMatrix();
    translate(-5, -30);
    quad(babyX+37, 398, babyX+35, 410, babyX+70, 420, babyX+70, 410); //arms of the crawling baby
    popMatrix();
  }
}
