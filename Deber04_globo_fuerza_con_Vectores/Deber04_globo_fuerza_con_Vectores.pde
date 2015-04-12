int numMovers = 15;
Mover[] movers = new Mover[numMovers];
float giro = 0.1;
void setup() {
  for ( int i=0; i< numMovers; i++) {
    movers[i] = new Mover(random(80, 150), i, movers);
  }
  size(1024, 600);
}
void draw() {
  background(255);

  for ( Mover mover : movers) {
    mover.display();
    mover.Fuerza();
    mover.Fuerza2();
    mover.update();
    mover.colision();
  }
}

void mouseClicked() {
  for ( int i=0; i< numMovers; i++) {
    movers[i] = new Mover(random(80, 150), i, movers);
  }
}

