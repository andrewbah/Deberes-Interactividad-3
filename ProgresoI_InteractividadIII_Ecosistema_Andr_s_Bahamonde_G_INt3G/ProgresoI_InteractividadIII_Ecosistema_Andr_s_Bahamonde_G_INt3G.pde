//Libreria para Animacion GIF
import gifAnimation.*;
Gif shark;
Gif plants;
Gif gavio;
//Libreria para Sonido Ambiente
import ddf.minim.*;
Minim minim;
AudioPlayer player;
//Diferentes variables de uso para las clases
float g = 0.2;
float impacto = 2;
float impacto2 = 0.05;

//ArrayList para el sistemade objetos de las burbujas
ArrayList<SistemaDeObjetos> sistemas;

//AGUA
Agua Agua;

//Imagen fondo
PImage oceano;

//Variables para numero de elementos 
int numpez = 60;
int numcoral = 10;
int numpezpeq = 50;

//Variables para Gaviota
int pezpeq = 0;
int pezgran = 0;
int muertesgav = 0;

//Variables para Tiburon
int pezpeq2 = 0;
int pezgran2 = 0;

//Variables para Bote
int pezpeq3 = 0;
int pezgran3 = 0;
//Carga diferentes clases y objetos
Gaviota gaviotas;
Tiburon tiburon;
Bote bote;

//Arrays para los elementos
Coral[] coral= new Coral[numcoral];
Pez[] peces= new Pez[numpez];
Pezpeq[] pecespeq= new Pezpeq[numpezpeq];


void setup() {
  size( 1333, 700, P3D);
  oceano = loadImage("fondo.jpg");
  minim = new Minim (this);
  player = minim.loadFile("sound.mp3"); 
  player.play();
  player.loop();
  //burbujas
  sistemas = new ArrayList<SistemaDeObjetos>();

  // AGUA
  Agua = new Agua(0, height/2-10, width, height/2+10, 5000);

  //GIFs
  shark = new Gif(this, "shark3.gif");
  plants = new Gif(this, "coral2.gif");
  gavio = new Gif(this, "gaviota2.gif");

  //TIBURON 
  tiburon = new Tiburon();

  //Gaviota
  gaviotas = new Gaviota(random(80, 100));

  //Bote
  bote = new Bote();

  //For anidados para cada Array
  for (int i=0; i<numcoral; i++) {
    float coralpos = random(0, width);
    coral[i] = new Coral(coralpos);
  }

  for (int i=0; i<numpez; i++) {
    peces[i] = new Pez(random(10, 50), i, peces, random(-10, 10));
  }

  for (int i=0; i<numpezpeq; i++) {
    pecespeq[i] = new Pezpeq(random(8, 15), i, pecespeq, random(-10, 10));
  }
}

void draw() {
  imageMode(CENTER);
  image(oceano, width/2, height/2, width, height);

  //BOTE
  bote.display();
  bote.update();
  bote.Fuerza();
  bote.Fuerza2();
  if (bote.pos.x>width +300 ) {

    bote.pos.x= random(-800, -200);
  } 

  if (bote.pos.y > height/2 -100) {
    bote.acel.y*= -1;
  } else if ( bote.pos.y <height/2 ) {
    bote.acel.y*= -1;
  }

  //AGUA
  Agua.display();

  //Funciones para clase Tiburon, y condiciones de posicion para su retorno
  tiburon.display();
  tiburon.update();

  if (tiburon.pos.y> height-100 ) {
    tiburon.pos.y = height-100; 
    tiburon.acel.y*= -1;
  } else if (tiburon.pos.y< height/2) {
    tiburon.pos.y = height/2; 
    tiburon.acel.y*= -1;
  }
  if (tiburon.pos.x>width +1000 ) {

    tiburon.acel.x*= -1;
  } else if (tiburon.pos.x< -1000 ) {
    tiburon.pos.x = width+500;
  }

  //for anidado para la clase coral y su funcion display
  for ( int i=0; i< numcoral; i++) {
    coral[i].display();
  }

  //GAVIOTAS y sus funciones
  gaviotas.display();
  gaviotas.update();

  //condicion para que cuando la gaviota toque el agua se aplique la fuerza "Agua"
  if (Agua.contenedor(gaviotas)) {
    gaviotas.cambioColor();
    PVector fuerzaAgua = Agua.drag(gaviotas);
    // Aplica la fuerza de arrastre de Agua a las Gaviotas
    gaviotas.aplicarFuerza(fuerzaAgua);
    //println("agua");
  }

  //burbujas con un sistema de particulas.
  for (int i=0; i < sistemas.size (); i++) {
    SistemaDeObjetos s= sistemas.get(i);
    s.actualizar();
    s.dibujar();
    s.adicionarObjeto();
  }

  //Funcion para detectar impacto entre el tiburon y la gaviota
  detectarImpacto();

  //Inicio Peces grandes y pequeños
  Peces();
  PecesGrandes() ;

  //TEXTO para conteo de puntos
  //BOTE
  text ("Bote:Peces Pequeños " + pezpeq3, width/3, 50);
  text ("Bote:Peces Grandes" + pezgran3, width/3, 100);

  //GAVIOTA
  text ("Gaviota:Peces Pequeños " + pezpeq, 720, 50);
  text ("Gaviota:Peces Grandes" + pezgran, 720, 100);
  text ("Muertes de la Gaviota" + muertesgav, 720, 150);

  //TIBURON
  text ("Tiburon:Peces Pequeños" + pezpeq2, 100, 50);
  text ("Tiburon:Peces Grandes" + pezgran2, 100, 100);
}

//Con Shift los peces pequeños salen de posiciones randomicas

void keyPressed() {

  if ( keyCode == SHIFT) {
    for (int i = 0; i < numpezpeq; i++) {
      pecespeq[i].pos.x = random(0, width);
      pecespeq[i].pos.y= random(height/2 +50, height);
      //println("nuevos pezpeq");
    }
  }
}


//Detectar Impactop entre la gaviota yel tiburon
void detectarImpacto() {
  if (( gaviotas.getPosX()< tiburon.getPosX()+100 
    && gaviotas.getPosX() > tiburon.getPosX()-100 
    && gaviotas.getPosY() <tiburon.getPosY()+50
    && gaviotas.getPosY() > tiburon.getPosY()-50)) {
    muertesgav = muertesgav + 1;
    gaviotas.pos2= new PVector(random(0, width), random(0, height/2)-100);
  }
}

//Inicio de el objeto Peces y sus funciones 

void Peces() {
  //PECES para acceder a sus funciones como si fueran un objeto simple no un arreglo con For, para la clase Pez el objeto pez el array peces.
  for (int i = 0; i < numpezpeq; i++) {
    for (int z = 0; z < numpezpeq; z++) {
      if (i != z) {
        PVector fuerza = pecespeq[z].atraccion(pecespeq[i]);
        pecespeq[i].aplicarFuerza(fuerza);
      }
    }

    pecespeq[i].fuerzas();
    pecespeq[i].update();
    pecespeq[i].display();
    pecespeq[i].colision();

    if (tiburon.intersecta(pecespeq[i])) {
      pecespeq[i].atrapado();
      pezpeq2= pezpeq2+1;
    }

    if (bote.intersecta(pecespeq[i])) {
      pecespeq[i].atrapado();
      pezpeq3=pezpeq3+1;
    }

    //condiciones para la funcion intersecta, entre la clase gaviotas y la clase pez.      
    if (gaviotas.intersecta(pecespeq[i])) {
      pecespeq[i].atrapado();
      pezpeq= pezpeq+1;
    }
  }
}

//Inicio de objeto peces Grandes y sus funciones

void PecesGrandes() {
  //PECES para acceder a sus funciones como si fueran un objeto simple no un arreglo con For, para la clase Pez el objeto pez el array peces.
  for ( Pez pez : peces) {
    pez.display();
    pez.Fuerza();
    pez.Fuerza2();
    pez.update();
    pez.colision();

    //for anidado para retorno de cada pez a posicion
    for (int i =0; i<numpez; i++) {    
      if (pez.pos.y> height-100 ) {
        pez.pos.y = height-100; 
        pez.vel.y*= -1;
      } else if (pez.pos.y< height/2) {
        pez.pos.y = height/2; 
        pez.vel.y*= -1;
      }
      if (pez.pos.x>width ) {
        pez.pos.x = 0; 
        pez.vel.x*= -1;
      }
      //condiciones para la funcion intersecta, entre la clase tiburon y la clase pez.
      if (tiburon.intersecta(pez)) {
        pez.atrapado();
        pezgran2= pezgran2+1;
      }
      //condiciones para la funcion intersecta, entre la clase gaviotas y la clase pez.      
      if (gaviotas.intersecta(pez)) {
        pez.atrapado();
        pezgran= pezgran+1;
      }

      if (bote.intersecta(pez)) {
        pez.atrapado();
        pezgran3=pezgran3+1;
      }
    }
  }
}
//Con click se inicia la dispercion de los objetos burbujas como un sistema de particulas
void mousePressed() {

  //Cuando se presiona el mouse las burbujas o las particulas comienzan su funcionamiento
  SistemaDeObjetos sistema;
  sistema = new SistemaDeObjetos( random(0, width), random (0, height));
  sistemas.add(sistema);
}

