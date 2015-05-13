
import processing.serial.*;
int numMovers = 50;
Mover[] movers = new Mover[numMovers];
float impacto = 0.05;
//constante gravitacional
float g = 0.4;


Serial myPort;
void setup() {
  size(1333, 650);
  println(Serial.list());

  myPort = new Serial(this, Serial.list()[1], 9600);

  myPort.bufferUntil('\n');


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



void serialEvent(Serial myPort) { 


  String inString = myPort.readStringUntil('\n');

  if (inString != null) {

    inString = trim(inString);

    numMovers = (int) map(int(inString), 0, 1023, 0, 50);
  }
}

