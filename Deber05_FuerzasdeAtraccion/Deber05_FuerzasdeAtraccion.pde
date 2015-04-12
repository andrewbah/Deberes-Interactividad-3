int numMovers = 50;
Mover[] movers = new Mover[numMovers];
float impacto = 0.09;
//constante gravitacional
float g = 0.4;

void setup() {
  size(1333, 650);
  for (int i = 0; i < numMovers; i++) {
    movers[i] = new Mover(i, movers);
  }
}

void draw() {
  background(255);
  for (int i = 0; i < numMovers; i++) {
    for (int z = 0; z < numMovers; z++) {
      if (i != z) {
        PVector fuerza = movers[z].atraccion(movers[i]);
        movers[i].aplicarFuerza(fuerza);
      }
    }
    movers[i].fuerzas();
    movers[i].update();
    movers[i].display();
    movers[i].colision();
  }
}


void mouseClicked() {
  for ( int i=0; i< numMovers; i++) {
    movers[i] = new Mover(i, movers);
  }
}

