PImage bg, startNormal, startHover, lose, win, restart, ship;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;
final int GAME_WIN = 3;
int gameState = GAME_START;

final int BUTTON_TOP = 210;
final int BUTTON_BOTTOM = 280;
final int BUTTON_LEFT = 115;
final int BUTTON_RIGHT = 450;

float shipX, shipY;
float shipSpeed = 5;
float shipWidth = 50;

float wall1Speed = 1;
float wall2Speed = 2;
float wall3Speed = 3;

float wall1Y = 100;
float wall2Y = 200;
float wall3Y = 300;

float wall1Left, wall2Left, wall3Left;


float wall1HoleWidth = 300;
float wall2HoleWidth = 200;
float wall3HoleWidth = 100;

float winningLineY = 400;

color wallColor;

boolean rightPressed = false;
boolean downPressed  = false;
boolean leftPressed  = false;
boolean upPressed  = false;


void setup() {
  size(600, 500);
  bg=loadImage("img/bg.png");
  startNormal=loadImage("img/start1.png");
  startHover=loadImage("img/start2.png");
  lose=loadImage("img/lose.png");
  win=loadImage("img/win.png");
  restart=loadImage("img/restart.png");
  ship=loadImage("img/ship.png");

  shipX = width / 2 - shipWidth / 2;
  shipY = 0;

  wallColor = color(247, 210, 60);
}

void draw() {

  switch(gameState) {
  case GAME_START:
    if (mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM) {
      image(startHover, 0, 0);
      if (mousePressed) {
        gameState = GAME_RUN;
      }
    } else {
      image(startNormal, 0, 0);
    }
    break;

  case GAME_RUN:

    image(bg, 0, 0);

    //ship movement
    if (upPressed) {
      shipY -= shipSpeed;
    }
    if (downPressed) {
      shipY += shipSpeed;
    }
    if (leftPressed) {
      shipX -= shipSpeed;
    }
    if (rightPressed) {
      shipX += shipSpeed;
    }

    //boundary
    if (shipX > width - shipWidth) {
      shipX = width - shipWidth;
    }
    if (shipX < 0) {
      shipX = 0;
    }
    if (shipY > height - shipWidth) {
      shipY = height - shipWidth;
    }
    if (shipY < 0) {
      shipY = 0;
    }

    //draw ship
    image(ship, shipX, shipY);

    //win
    if (shipY > winningLineY) {
      gameState = GAME_WIN;
    }

    //wall1
    strokeWeight(5);
    stroke(247, 210, 60);
    line (0, wall1Y, wall1Left, wall1Y);
    line (wall1Left + wall1HoleWidth, wall1Y, width, wall1Y);

    //wall1 move
    wall1Left += wall1Speed;
    if (wall1Left + wall1Speed + wall1HoleWidth >= width || wall1Left <= 0) {
      wall1Speed *= -1;
    }

    //wall2
    strokeWeight(5);
    stroke(247, 210, 60);
    line (0, wall2Y, wall2Left, wall2Y);
    line (wall2Left + wall2HoleWidth, wall2Y, width, wall2Y);
    //wall2 move
    wall2Left += wall2Speed;
    if (wall2Left + wall2Speed + wall2HoleWidth >= width || wall2Left <= 0) {
      wall2Speed *= -1;
    }

    //wall3
    strokeWeight(5);
    stroke(247, 210, 60);
    line (0, wall3Y, wall3Left, wall3Y);
    line (wall3Left + wall3HoleWidth, wall3Y, width, wall3Y);
    //wall2 move
    wall3Left += wall3Speed;
    if (wall3Left + wall3Speed + wall3HoleWidth >= width || wall3Left <= 0) {
      wall3Speed *= -1;
    }

    break;

  case GAME_WIN:
    image(win, 0, 0);
    if (keyPressed)
    {
      if (keyCode == ENTER) {
        gameState = GAME_RUN;
      }
      break;
    }
  case GAME_OVER:
    image(lose, 0, 0);
    break;
  }
}

void keyPressed() {
  if (key == CODED) {
    switch(keyCode) {
    case UP:
      upPressed = true;
      break;
    case DOWN:
      downPressed = true;
      break;
    case LEFT:
      leftPressed = true;
      break;
    case RIGHT:
      rightPressed = true;
      break;
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    switch(keyCode) {
    case UP:
      upPressed = false;
      break;
    case DOWN:
      downPressed = false;
      break;
    case LEFT:
      leftPressed = false;
      break;
    case RIGHT:
      rightPressed = false;
      break;
    }
  }
}
