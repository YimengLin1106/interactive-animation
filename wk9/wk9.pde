// ==========================================================
// DIGITAL CAT COMPANION
// Week 9 Development Version
// Behaviour and Mood System
// ==========================================================

DigitalCat cat;

UIButton feedButton;
UIButton playButton;


// ==========================================================
// SETUP
// ==========================================================

void setup() {

  size(1050, 700);

  smooth(8);

  cat = new DigitalCat(340, 365);

  feedButton = new UIButton(
    675, 490,
    135, 52,
    "FEED"
  );

  playButton = new UIButton(
    835, 490,
    135, 52,
    "PLAY"
  );
}


// ==========================================================
// MAIN LOOP
// ==========================================================

void draw() {

  // Update the cat every frame
  cat.update();

  drawBackground();

  drawHeader();

  cat.display();

  drawStatusPanel();

  drawFooter();
}


// ==========================================================
// BACKGROUND
// ==========================================================

void drawBackground() {

  background(242, 239, 232);

  noStroke();

  // Cat area
  fill(221, 233, 224);

  rect(
    0,
    120,
    620,
    445
  );


  // Floor
  fill(225, 208, 186);

  rect(
    0,
    565,
    width,
    135
  );


  // Floor border
  fill(198, 177, 151);

  rect(
    0,
    560,
    width,
    5
  );


  // Rug
  fill(238, 220, 199);

  ellipse(
    340,
    535,
    450,
    80
  );
}


// ==========================================================
// HEADER
// ==========================================================

void drawHeader() {

  textAlign(LEFT);

  fill(55);

  textSize(34);

  text(
    "Digital Cat Companion",
    65,
    65
  );


  textSize(15);

  fill(110);

  text(
    "An interactive 2D digital pet",
    67,
    92
  );
}


// ==========================================================
// STATUS PANEL
// ==========================================================

void drawStatusPanel() {

  // Shadow
  noStroke();

  fill(0, 18);

  rect(
    647,
    137,
    350,
    435,
    25
  );


  // Main card
  fill(255);

  rect(
    640,
    130,
    350,
    435,
    25
  );


  // --------------------------------------------------------
  // TITLE
  // --------------------------------------------------------

  textAlign(LEFT);

  fill(55);

  textSize(24);

  text(
    "Cat Status",
    675,
    172
  );


  textSize(13);

  fill(130);

  text(
    "Keep your companion happy and healthy.",
    675,
    194
  );


  // --------------------------------------------------------
  // MOOD
  // --------------------------------------------------------

  fill(85);

  textSize(14);

  text(
    "Mood",
    675,
    227
  );


  drawMoodBadge(
    cat.mood,
    748,
    208
  );


  // --------------------------------------------------------
  // STATUS BARS
  // --------------------------------------------------------

  drawStatusBar(
    "Happiness",
    cat.happiness,
    675,
    270,
    color(239, 159, 171)
  );


  drawStatusBar(
    "Hunger",
    cat.hunger,
    675,
    345,
    color(236, 183, 102)
  );


  drawStatusBar(
    "Energy",
    cat.energy,
    675,
    420,
    color(112, 180, 157)
  );


  // --------------------------------------------------------
  // BUTTONS
  // --------------------------------------------------------

  feedButton.display();

  playButton.display();


  fill(125);

  textSize(11);

  textAlign(CENTER);

  text(
    "Click the cat to pet it",
    815,
    558
  );
}


// ==========================================================
// MOOD BADGE
// ==========================================================

void drawMoodBadge(
  String mood,
  float x,
  float y
) {

  color badgeColor;


  if (mood.equals("Playful")) {

    badgeColor = color(
      239,
      159,
      171
    );

  } else if (mood.equals("Hungry")) {

    badgeColor = color(
      236,
      183,
      102
    );

  } else if (mood.equals("Tired")) {

    badgeColor = color(
      155,
      166,
      196
    );

  } else if (mood.equals("Sad")) {

    badgeColor = color(
      169,
      183,
      195
    );

  } else {

    badgeColor = color(
      112,
      180,
      157
    );
  }


  noStroke();

  fill(badgeColor);

  rect(
    x,
    y,
    105,
    27,
    14
  );


  fill(255);

  textAlign(CENTER, CENTER);

  textSize(12);

  text(
    mood,
    x + 52,
    y + 13
  );
}


// ==========================================================
// STATUS BAR
// ==========================================================

void drawStatusBar(
  String label,
  float value,
  float x,
  float y,
  color barColor
) {

  textAlign(LEFT);

  fill(70);

  textSize(15);

  text(
    label,
    x,
    y
  );


  textAlign(RIGHT);

  fill(110);

  text(
    int(value) + " / 100",
    x + 260,
    y
  );


  // Empty bar
  noStroke();

  fill(230);

  rect(
    x,
    y + 15,
    260,
    14,
    7
  );


  // Filled bar
  fill(barColor);

  rect(
    x,
    y + 15,
    260 * value / 100,
    14,
    7
  );
}


// ==========================================================
// FOOTER
// ==========================================================

void drawFooter() {

  fill(95);

  textAlign(CENTER);

  textSize(13);

  text(
    "CLICK CAT  •  PET        F  •  FEED        P  •  PLAY",
    width / 2,
    650
  );


  fill(145);

  textSize(11);

  text(
    "Your cat's needs and mood change over time.",
    width / 2,
    675
  );
}


// ==========================================================
// MOUSE INPUT
// ==========================================================

void mouseReleased() {

  // Pet the cat
  if (cat.contains(mouseX, mouseY)) {

    cat.pet();

  }


  // Feed
  else if (feedButton.isMouseOver()) {

    cat.feed();

  }


  // Play
  else if (playButton.isMouseOver()) {

    cat.play();

  }
}


// ==========================================================
// KEYBOARD INPUT
// ==========================================================

void keyPressed() {

  // Feed
  if (
    key == 'f' ||
    key == 'F'
  ) {

    cat.feed();
  }


  // Play
  if (
    key == 'p' ||
    key == 'P'
  ) {

    cat.play();
  }


  // Pet
  if (key == ' ') {

    cat.pet();
  }
}


// ==========================================================
// DIGITAL CAT CLASS
// ==========================================================

class DigitalCat {

  float x;
  float y;


  // ========================================================
  // INTERNAL NEEDS
  // ========================================================

  float happiness = 70;

  float hunger = 80;

  float energy = 65;


  // ========================================================
  // BEHAVIOUR STATE
  // ========================================================

  String mood = "Content";

  String previousMood = "Content";


  // ========================================================
  // TIME SYSTEM
  // ========================================================

  int lastUpdateTime;


  // ========================================================
  // REACTION MESSAGE
  // ========================================================

  String reactionText = "";

  int reactionEndTime = 0;


  // ========================================================
  // SHORT INTERACTION ANIMATIONS
  // ========================================================

  int petAnimationEnd = 0;

  int playAnimationEnd = 0;

  int feedAnimationEnd = 0;


  // ========================================================
  // COLOURS
  // ========================================================

  color fur;

  color furLight;

  color furDark;

  color eyeColour;


  // ========================================================
  // CONSTRUCTOR
  // ========================================================

  DigitalCat(
    float startX,
    float startY
  ) {

    x = startX;

    y = startY;


    fur = color(
      222,
      148,
      83
    );


    furLight = color(
      246,
      188,
      132
    );


    furDark = color(
      190,
      105,
      57
    );


    eyeColour = color(
      82,
      158,
      112
    );


    lastUpdateTime = millis();
  }


  // ========================================================
  // UPDATE
  // ========================================================

  void update() {

    int currentTime = millis();


    // Convert milliseconds to seconds
    float deltaTime =
      (currentTime - lastUpdateTime)
      / 1000.0;


    lastUpdateTime = currentTime;


    // Prevent large changes if program freezes temporarily
    deltaTime =
      min(
      deltaTime,
      0.1
      );


    // ------------------------------------------------------
    // HUNGER DECREASES OVER TIME
    // ------------------------------------------------------

    hunger -=
      0.35 *
      deltaTime;


    // ------------------------------------------------------
    // ENERGY SYSTEM
    // ------------------------------------------------------

    if (energy < 20) {

      // Cat rests automatically when very tired
      energy +=
        1.0 *
        deltaTime;

    } else {

      // Slow natural recovery
      energy +=
        0.10 *
        deltaTime;
    }


    // ------------------------------------------------------
    // HAPPINESS SYSTEM
    // ------------------------------------------------------

    // Being hungry slowly reduces happiness
    if (hunger < 30) {

      happiness -=
        0.20 *
        deltaTime;
    }


    // Being extremely tired also reduces happiness
    if (energy < 15) {

      happiness -=
        0.10 *
        deltaTime;
    }


    // ------------------------------------------------------
    // KEEP VALUES BETWEEN 0 AND 100
    // ------------------------------------------------------

    happiness =
      constrain(
      happiness,
      0,
      100
      );


    hunger =
      constrain(
      hunger,
      0,
      100
      );


    energy =
      constrain(
      energy,
      0,
      100
      );


    // ------------------------------------------------------
    // CALCULATE CURRENT MOOD
    // ------------------------------------------------------

    updateMood();
  }


  // ========================================================
  // MOOD SYSTEM
  // ========================================================

  void updateMood() {

    previousMood = mood;


    /*
      Priority is important.

      Tired takes priority because the cat needs rest.
      Hungry comes next.
      Sad depends mainly on happiness.
      Playful requires strong overall condition.
      Otherwise the cat is Content.
    */


    if (energy < 20) {

      mood = "Tired";

    } else if (hunger < 30) {

      mood = "Hungry";

    } else if (happiness < 30) {

      mood = "Sad";

    } else if (
      happiness > 80 &&
      hunger > 45 &&
      energy > 45
    ) {

      mood = "Playful";

    } else {

      mood = "Content";
    }


    // Detect mood changes
    if (!mood.equals(previousMood)) {

      reactToMoodChange();
    }
  }


  // ========================================================
  // AUTOMATIC MOOD REACTION
  // ========================================================

  void reactToMoodChange() {

    if (mood.equals("Hungry")) {

      setReaction(
        "I'm hungry..."
      );

    } else if (mood.equals("Tired")) {

      setReaction(
        "So sleepy..."
      );

    } else if (mood.equals("Sad")) {

      setReaction(
        "Pet me?"
      );

    } else if (mood.equals("Playful")) {

      setReaction(
        "Let's play!"
      );
    }
  }


  // ========================================================
  // DISPLAY
  // ========================================================

  void display() {

    pushMatrix();


    // ------------------------------------------------------
    // PLAY BOUNCE
    // ------------------------------------------------------

    float bounce = 0;


    if (millis() < playAnimationEnd) {

      bounce =
        abs(
        sin(
        frameCount * 0.20
        )
        ) * -12;
    }


    translate(
      x,
      y + bounce
    );


    // ------------------------------------------------------
    // SMALL BREATHING EFFECT
    // ------------------------------------------------------

    float breathing =
      1.0 +
      sin(
      frameCount * 0.04
      ) * 0.006;


    scale(
      breathing
    );


    // ------------------------------------------------------
    // SHADOW
    // ------------------------------------------------------

    noStroke();

    fill(
      90,
      75,
      60,
      30
    );


    ellipse(
      0,
      185,
      280,
      38
    );


    // ------------------------------------------------------
    // TAIL
    // ------------------------------------------------------

    drawTail();


    // ------------------------------------------------------
    // BODY
    // ------------------------------------------------------

    noStroke();

    fill(fur);

    ellipse(
      0,
      70,
      235,
      245
    );


    // Belly
    fill(furLight);

    ellipse(
      0,
      95,
      135,
      155
    );


    // ------------------------------------------------------
    // BACK PAWS
    // ------------------------------------------------------

    fill(furDark);

    ellipse(
      -82,
      165,
      85,
      50
    );


    ellipse(
      82,
      165,
      85,
      50
    );


    // ------------------------------------------------------
    // HEAD
    // ------------------------------------------------------

    fill(fur);

    ellipse(
      0,
      -80,
      220,
      190
    );


    // ------------------------------------------------------
    // EARS
    // ------------------------------------------------------

    fill(fur);


    triangle(
      -85,
      -135,
      -65,
      -220,
      -20,
      -155
    );


    triangle(
      85,
      -135,
      65,
      -220,
      20,
      -155
    );


    // Inner ears
    fill(
      236,
      161,
      164
    );


    triangle(
      -70,
      -150,
      -64,
      -195,
      -37,
      -157
    );


    triangle(
      70,
      -150,
      64,
      -195,
      37,
      -157
    );


    // ------------------------------------------------------
    // FOREHEAD STRIPES
    // ------------------------------------------------------

    stroke(furDark);

    strokeWeight(7);

    strokeCap(ROUND);


    line(
      -28,
      -160,
      -20,
      -137
    );


    line(
      0,
      -166,
      0,
      -138
    );


    line(
      28,
      -160,
      20,
      -137
    );


    // ------------------------------------------------------
    // FACE
    // ------------------------------------------------------

    drawFace();


    // ------------------------------------------------------
    // COLLAR
    // ------------------------------------------------------

    noStroke();

    fill(
      85,
      165,
      183
    );


    rect(
      -72,
      -5,
      144,
      14,
      7
    );


    // Tag
    fill(
      255,
      190,
      40
    );


    ellipse(
      0,
      12,
      24,
      24
    );


    // ------------------------------------------------------
    // FRONT LEGS
    // ------------------------------------------------------

    fill(fur);


    ellipse(
      -52,
      120,
      55,
      110
    );


    ellipse(
      52,
      120,
      55,
      110
    );


    // Front paws
    fill(furLight);


    ellipse(
      -52,
      165,
      52,
      31
    );


    ellipse(
      52,
      165,
      52,
      31
    );


    popMatrix();


    // Reaction bubble is not scaled with cat
    displayReaction();


    // Sleeping indicator
    if (mood.equals("Tired")) {

      displaySleepIndicator();
    }
  }


  // ========================================================
  // TAIL BEHAVIOUR
  // ========================================================

  void drawTail() {

    float speed = 0.04;

    float amount = 7;


    if (mood.equals("Playful")) {

      speed = 0.15;

      amount = 20;

    } else if (mood.equals("Tired")) {

      speed = 0.02;

      amount = 3;

    } else if (mood.equals("Sad")) {

      speed = 0.02;

      amount = 4;
    }


    float tailMovement =
      sin(
      frameCount *
      speed
      ) *
      amount;


    noFill();

    stroke(furDark);

    strokeWeight(30);

    strokeCap(ROUND);


    bezier(
      95,
      80,

      180 + tailMovement,
      60,

      190 + tailMovement,
      -70,

      125 + tailMovement,
      -90
    );
  }


  // ========================================================
  // FACE / EXPRESSION SYSTEM
  // ========================================================

  void drawFace() {

    // ------------------------------------------------------
    // EYES
    // ------------------------------------------------------

    if (mood.equals("Tired")) {

      drawClosedEyes();

    } else if (mood.equals("Sad")) {

      drawSadEyes();

    } else {

      drawNormalEyes();
    }


    // ------------------------------------------------------
    // MUZZLE
    // ------------------------------------------------------

    noStroke();

    fill(
      246,
      202,
      163
    );


    ellipse(
      -25,
      -48,
      58,
      46
    );


    ellipse(
      25,
      -48,
      58,
      46
    );


    // ------------------------------------------------------
    // PETTING BLUSH
    // ------------------------------------------------------

    if (millis() < petAnimationEnd) {

      fill(
        245,
        135,
        150,
        110
      );


      ellipse(
        -65,
        -45,
        30,
        17
      );


      ellipse(
        65,
        -45,
        30,
        17
      );
    }


    // ------------------------------------------------------
    // NOSE
    // ------------------------------------------------------

    fill(
      218,
      116,
      126
    );


    triangle(
      -10,
      -58,
      10,
      -58,
      0,
      -46
    );


    // ------------------------------------------------------
    // MOUTH
    // ------------------------------------------------------

    drawMouth();


    // ------------------------------------------------------
    // WHISKERS
    // ------------------------------------------------------

    stroke(
      95,
      78,
      70
    );

    strokeWeight(2);


    line(
      -35,
      -55,
      -110,
      -70
    );


    line(
      -35,
      -45,
      -115,
      -45
    );


    line(
      -35,
      -35,
      -105,
      -20
    );


    line(
      35,
      -55,
      110,
      -70
    );


    line(
      35,
      -45,
      115,
      -45
    );


    line(
      35,
      -35,
      105,
      -20
    );
  }


  // ========================================================
  // NORMAL EYES
  // ========================================================

  void drawNormalEyes() {

    noStroke();


    // White
    fill(255);


    ellipse(
      -45,
      -92,
      53,
      44
    );


    ellipse(
      45,
      -92,
      53,
      44
    );


    // Iris
    fill(eyeColour);


    ellipse(
      -45,
      -92,
      31,
      34
    );


    ellipse(
      45,
      -92,
      31,
      34
    );


    // Pupils
    fill(45);


    ellipse(
      -45,
      -92,
      11,
      25
    );


    ellipse(
      45,
      -92,
      11,
      25
    );


    // Highlights
    fill(255);


    ellipse(
      -39,
      -99,
      7,
      7
    );


    ellipse(
      51,
      -99,
      7,
      7
    );
  }


  // ========================================================
  // CLOSED EYES
  // ========================================================

  void drawClosedEyes() {

    stroke(
      80,
      65,
      60
    );

    strokeWeight(4);

    noFill();


    arc(
      -45,
      -88,
      40,
      22,
      0,
      PI
    );


    arc(
      45,
      -88,
      40,
      22,
      0,
      PI
    );
  }


  // ========================================================
  // SAD EYES
  // ========================================================

  void drawSadEyes() {

    drawNormalEyes();


    // Eyebrows
    stroke(
      95,
      70,
      60
    );

    strokeWeight(4);


    line(
      -68,
      -126,
      -38,
      -118
    );


    line(
      68,
      -126,
      38,
      -118
    );
  }


  // ========================================================
  // MOUTH EXPRESSIONS
  // ========================================================

  void drawMouth() {

    stroke(
      90,
      65,
      60
    );

    strokeWeight(2.5);

    noFill();


    if (mood.equals("Sad")) {

      // Downturned mouth
      arc(
        0,
        -30,
        35,
        25,
        PI,
        TWO_PI
      );

    } else if (mood.equals("Hungry")) {

      // Small open mouth
      ellipse(
        0,
        -37,
        18,
        22
      );

    } else if (mood.equals("Playful")) {

      // Bigger smile
      arc(
        0,
        -48,
        55,
        45,
        0,
        PI
      );

    } else {

      // Normal cat mouth
      arc(
        -10,
        -43,
        20,
        18,
        0,
        PI
      );


      arc(
        10,
        -43,
        20,
        18,
        0,
        PI
      );
    }
  }


  // ========================================================
  // SLEEP INDICATOR
  // ========================================================

  void displaySleepIndicator() {

    fill(
      100,
      110,
      150
    );

    textAlign(CENTER);

    textSize(18);


    float floating =
      sin(
      frameCount *
      0.05
      ) * 5;


    text(
      "z",
      x + 115,
      y - 185 + floating
    );


    textSize(23);


    text(
      "Z",
      x + 140,
      y - 215 + floating
    );


    textSize(29);


    text(
      "Z",
      x + 170,
      y - 250 + floating
    );
  }


  // ========================================================
  // CLICK DETECTION
  // ========================================================

  boolean contains(
    float mx,
    float my
  ) {

    float bodyDistance =
      dist(
      mx,
      my,
      x,
      y + 45
      );


    float headDistance =
      dist(
      mx,
      my,
      x,
      y - 80
      );


    return
      bodyDistance < 135 ||
      headDistance < 115;
  }


  // ========================================================
  // PET
  // ========================================================

  void pet() {

    happiness += 8;


    happiness =
      constrain(
      happiness,
      0,
      100
      );


    petAnimationEnd =
      millis() + 1000;


    if (mood.equals("Tired")) {

      setReaction(
        "Purrr..."
      );

    } else {

      setReaction(
        "I like that!"
      );
    }
  }


  // ========================================================
  // FEED
  // ========================================================

  void feed() {

    if (hunger >= 95) {

      setReaction(
        "I'm full!"
      );

      return;
    }


    hunger += 18;


    hunger =
      constrain(
      hunger,
      0,
      100
      );


    feedAnimationEnd =
      millis() + 1000;


    setReaction(
      "Yum!"
    );
  }


  // ========================================================
  // PLAY
  // ========================================================

  void play() {

    // Cat cannot play if too tired
    if (energy < 20) {

      setReaction(
        "Too tired..."
      );

      return;
    }


    // Cat does not want to play when extremely hungry
    if (hunger < 15) {

      setReaction(
        "Feed me first!"
      );

      return;
    }


    happiness += 10;

    energy -= 12;

    hunger -= 3;


    happiness =
      constrain(
      happiness,
      0,
      100
      );


    energy =
      constrain(
      energy,
      0,
      100
      );


    hunger =
      constrain(
      hunger,
      0,
      100
      );


    playAnimationEnd =
      millis() + 1200;


    setReaction(
      "Let's play!"
    );
  }


  // ========================================================
  // SET REACTION
  // ========================================================

  void setReaction(
    String message
  ) {

    reactionText =
      message;


    reactionEndTime =
      millis() + 1600;
  }


  // ========================================================
  // DISPLAY REACTION
  // ========================================================

  void displayReaction() {

    if (
      millis() <
      reactionEndTime
    ) {

      // Bubble shadow
      noStroke();

      fill(
        0,
        20
      );


      rect(
        x - 72,
        y - 301,
        150,
        55,
        18
      );


      // Bubble
      fill(255);


      rect(
        x - 75,
        y - 305,
        150,
        55,
        18
      );


      // Bubble pointer
      triangle(
        x - 12,
        y - 250,
        x + 8,
        y - 250,
        x,
        y - 232
      );


      // Text
      fill(70);

      textAlign(
        CENTER,
        CENTER
      );

      textSize(14);


      text(
        reactionText,
        x,
        y - 278
      );
    }
  }
}


// ==========================================================
// BUTTON CLASS
// ==========================================================

class UIButton {

  float x;
  float y;

  float w;
  float h;

  String label;


  UIButton(
    float bx,
    float by,
    float bw,
    float bh,
    String buttonLabel
  ) {

    x = bx;

    y = by;

    w = bw;

    h = bh;

    label = buttonLabel;
  }


  // ========================================================
  // DISPLAY BUTTON
  // ========================================================

  void display() {

    noStroke();


    if (isMouseOver()) {

      fill(
        92,
        151,
        139
      );

    } else {

      fill(
        112,
        170,
        158
      );
    }


    rect(
      x,
      y,
      w,
      h,
      14
    );


    fill(255);

    textAlign(
      CENTER,
      CENTER
    );

    textSize(14);


    text(
      label,
      x + w / 2,
      y + h / 2 - 1
    );
  }


  // ========================================================
  // HOVER DETECTION
  // ========================================================

  boolean isMouseOver() {

    return
      mouseX >= x &&
      mouseX <= x + w &&
      mouseY >= y &&
      mouseY <= y + h;
  }
}
