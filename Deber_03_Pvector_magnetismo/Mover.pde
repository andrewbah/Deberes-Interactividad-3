class Mover {
  PVector pos;
  PVector vel;
  PVector acel;
  color color1;
  Mover[] others;
  int id;
  float diametro;
  PImage stars;
  //constructor con las variables que se obtienen, un arreglo para obtener nuevo grupo de elementos y reemplezarlos con others para la funcion de colision, Pvectors de aceleracion
  //posicion y velocidad, se crea un id para cada elemento para su funcionamiento con colision
  Mover(float din, int idin, Mover[] oin) {
    acel = new PVector(-0.8, 0.8);
    pos = new PVector(random(200, width), random(200, height));
    vel= new PVector( 0, 0);
    color1= color(random(0, 255), random( 0, 255), random( 0, 255));
    others = oin;
    id = idin;
    diametro = din;
    stars = loadImage("star.png");
  }
  //funcion de colision que recoge los id y separa para cada uno la colision
  void colision() {

    for (int i = id + 1; i < numMovers; i++) {
      //se reemplaza las posiciones de others que era el nuero arreglo para esta funcion con la de dx y dy y se las pasa al float distancia
      float dx = others[i].pos.x - pos.x;
      float dy = others[i].pos.y - pos.y;
      float distancia = sqrt(dx*dx + dy*dy);
      //se crea un float para distancia minima de impacto con la variable del diametro de cada elemento ya que son diferentes
      float minDist = others[i].diametro/2 + diametro/2;
      if (distancia < minDist) { 
        //float angulo para calcular el angulo en radianes con y y x ya que el orden es atan2(y, x)
        float angulo = atan2(dy, dx);
        //targetX para calcular la posicion en x y multiplicar el coseno del angulo por la distancia minima de impacto
        float targetX = pos.x + cos(angulo) * minDist;
        float targetY = pos.y + sin(angulo) * minDist;
        //se resta el targetX de la posicion de los elementos y con el giro( que es la cantidad de impacto y con la cual se distancian los objetos al chocar.
        float ax = (targetX - others[i].pos.x) * giro;
        float ay = (targetY - others[i].pos.y) * giro;
        vel.x -= ax;
        vel.y -= ay;
        others[i].vel.x += ax;
        others[i].vel.y += ay;
      }
    }
  }



  void update() {
    PVector mouse= new PVector(mouseX, mouseY);
    PVector dir= PVector.sub(mouse, pos);
    dir.normalize();
    dir.mult(2);
    acel = dir;
    pos.add(vel);
    vel.add(acel);
    //LIMITAR EL VECTOR!!
    vel.limit(15);
    //ALEATORIDAD!! 
    //    acel = PVector.random2D();
    acel.mult(random(2));
    if ( pos.x > width) {
      pos.x= 0;
    } else if ( pos.x < 0) {
      pos.x = width;
    } else if ( pos.y >height ) {
      pos.y=0;
    } else if ( pos.y < 0) {
      pos.y=height;
    }
    //condiciones para friccion y choque
    if (pos.x + diametro/2 > width) {
      pos.x = width - diametro/2;
    } else if (pos.x - diametro/2 < 0) {
      pos.x = diametro/2;
    }
    if (pos.y + diametro/2 > height) {
      pos.y = height - diametro/2;
    } else if (pos.y - diametro/2 < 0) {
      pos.y = diametro/2;
    }
  }
  void display() {
    noStroke();
    //fill(color1);
    image(stars, pos.x, pos.y, diametro, diametro);
    //ellipse(pos.x, pos.y, diametro, diametro);
  }
}

