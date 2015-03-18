float x = 100;
float y = 100;
int[] bolas;
float xspeed = 1;
float yspeed = 2;

void setup() {
  size(800, 400);
  smooth();
  bolas = new int[5];
  background(255);
}

void draw() {
  

  int index = int(random(bolas.length));

  bolas[index]++;

  x = x + xspeed;
  y = y + yspeed;

  for (int z = 0; z < bolas.length; z++) { 
    
    ellipse(x +random(0, index), y +random(0, index), 48, 48);
  }
  if ((x > width) || (x < 0)) {
    xspeed = xspeed * -1;
  }
  if ((y > height) || (y < 0)) {
    yspeed = yspeed * -1;
  }
}

