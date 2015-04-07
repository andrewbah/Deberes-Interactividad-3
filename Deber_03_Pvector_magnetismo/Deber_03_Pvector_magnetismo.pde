import ddf.minim.*;
//Cantidad de movers 
int numMovers = 25;
//arreglo para crear los movers con objetos
Mover[] movers = new Mover[numMovers];
//variables para giro o para cantidad de impulso de choque
float giro = 1;

PImage Vader, fondo;

Minim minim;
AudioPlayer player ;

void setup() {
  //for anidado para controlar los movers y variar la posicion el tamano de los objetos
  for ( int i=0; i< numMovers; i++) {
    movers[i] = new Mover(random(20, 40), i, movers);
  }

  minim = new Minim(this);
  player = minim.loadFile("star_wars.mp3");
  player.play();
  player.loop();
  size(1240, 700);
  Vader = loadImage("vader.png");
  fondo=loadImage("fondo.jpg");
}

void draw() {
  imageMode(CENTER);
  image(fondo, width/2, height/2, width, height);
  image(Vader, mouseX, mouseY, 500, 500);
  // for para poder acceder a los movers y sus respectivas funciones de display update y colision
  for ( Mover mover : movers) {
    mover.display();

    mover.update();
    mover.colision();
  }
}
// cuando se da click los movers se resetean y se crean nuevos con otras dimensiones y posiciones
void mouseClicked() {
  for ( int i=0; i< numMovers; i++) {
    movers[i] = new Mover(random(20, 40), i, movers);
  }
}

