class Mover {
  PVector pos;
  PVector vel;
  PVector acel;
  float masa;
  Mover[] others;
  int id;
  float diametro;
  color color1;
  color color2;

  Mover(int idin, Mover[] oin) {
    masa = random( 1, 2);
    //masa = 1;
    pos = new PVector(random(100, width-100), random(100, height-100));
    vel = new PVector(0, 0);
    acel = new PVector(0, 0);
    others = oin;
    id = idin;
    diametro = random(10, 15);
    color1= color(random(0, 100), random(100, 255));
    color2= color(0, 10);
  }

  void colision() {
    for (int i = id + 1; i < numMovers; i++) {
      //se reemplaza las posiciones de others que era el nuero arreglo para esta funcion con la de dx y dy y se las pasa al float distancia
      float dx = others[i].pos.x - pos.x;
      float dy = others[i].pos.y - pos.y;
      float distancia = sqrt(dx*dx + dy*dy);
      //se crea un float para distancia minima de impacto con la variable del diametro de cada elemento ya que son diferentes
      float minDist = others[i].diametro + diametro;
      if (distancia < minDist) { 
        //float angulo para calcular el angulo en radianes con x y y ya que el orden es atan2(y, x)
        float angulo = atan2(dy, dx);
        //targetX para calcular la posicion en x y multiplicar el coseno del angulo por la distancia minima de impacto
        float targetX = pos.x + cos(angulo) * minDist;
        float targetY = pos.y + sin(angulo) * minDist;
        //se resta el targetX de la posicion de los elementos y con el giro( que es la cantidad de impacto y con la cual se distancian los objetos al chocar.
        float ax = (targetX - others[i].pos.x) * impacto/2;
        float ay = (targetY - others[i].pos.y) * impacto/2;
        vel.x -= ax;
        vel.y -= ay;
        others[i].vel.x += ax;
        others[i].vel.y += ay;
      }
    }
  }

  void aplicarFuerza(PVector fuerza) {
    PVector f = PVector.div(fuerza, masa);
    acel.add(f);
  }
  void update() {
    vel.add(acel);
    //limite para la velocidad.
    vel.limit(4);
    pos.add(vel);
    //mult por escalar 0 para normalizar el vector aceleracion y que no se repita cada vez y se haga mas rapido
    acel.mult(0);
  }
  PVector atraccion(Mover a) {
    PVector fuerza = PVector.sub(pos, a.pos);             
    float distancia = fuerza.mag();   
    // el constrain funciona con dos valores un minimo y un maximo en este caso es la cantidad de distancia minima y maxima que los objetos van a ser atraidos osea practicamente su fuerza de atraccion    
    distancia = constrain(distancia, 1, 25);  
    //normaliza la fuera del vector en una escala de 1    
    fuerza.normalize();   
    // campograv es la formula para sacar el campo gravitacional entre los objetos y su fuerza de atraccion, en donde g es la "constante gravitacional" masa y a.masa son las masas de los objetos y a esto se lo divide por distancia al cuadrado.    
    float campograv = (g * masa *a.masa) / (distancia * distancia); 
    //a la final se multiplica la fuerza por la fuerza del campo gravitacional y se obtiene la variable fuerza con un return
    fuerza.mult(campograv);  
    return fuerza;
  }

  void fuerzas() {
    stroke(0);
    noFill();
    rect(0, 0, width, 50);
    rect(0, 0, 50, height);
    rect(width-50, 0, 50, height);
    rect(0, height-50, width, 50);

    PVector fuerza = new PVector(0, 0);

    if (pos.x < 50) {
      fuerza.x = 1;

      color1= color(random(0, 255), random(0, 255), random(0, 255));
    } else if (pos.x > width -50) {
      fuerza.x = -1;

      color1= color(random(0, 255), random(0, 255), random(0, 255));
    } 

    if (pos.y < 50) {
      fuerza.y = 1;

      color1= color(random(0, 255), random(0, 255), random(0, 255));
    } else if (pos.y > height-50) {
      fuerza.y = -1;

      color1= color(random(0, 255), random(0, 255), random(0, 255));
    } 
//    if (pos.x < 50) {
//      fuerza.x = 1;
//
//      color1= color(255, 0, 0);
//    } 
//
//    if (pos.x > width -50) {
//      fuerza.x = -1;
//
//      color1= color(255, 0, 0);
//    } 
//    if (pos.y < 50) {
//      fuerza.y = 1;
//
//      color1= color(255, 0, 0);
//    } 
//
//    if (pos.y > height-50) {
//      fuerza.y = -1;
//
//      color1= color(255, 0, 0);
//    } 

    fuerza.normalize();
    fuerza.mult(0.5);
    aplicarFuerza(fuerza);
  }
  void display() {
    noStroke();
    fill(color1);
    ellipse(pos.x, pos.y, masa*diametro, masa*diametro);
  }
}

