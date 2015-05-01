class Objeto { 
  PVector posicion;
  PVector velocidad;
  PVector aceleracion;
  float sizeActual;
  int vida;

  //Sistema de objetos
  Objeto () {
    posicion = new PVector(0, 0);
    velocidad = new PVector(0, 0);
    aceleracion = new PVector( 0, 0);
    vida = 255;
  }

  Objeto (float x, float y, float _size) {
    posicion = new PVector(x, y);
    velocidad = new PVector(0, 0);
    aceleracion = new PVector( random (-0.05, 0.05), random(-0.08, -0.1));
    sizeActual =_size;

    vida = 255;
  }
  void actualizar() {
    vida = vida-1;
    velocidad.add(aceleracion);
    posicion.add(velocidad);
    velocidad.limit(1);
  }

  void dibujar () {
    imageMode(CENTER);
    fill(vida, vida);

    ellipse( posicion.x, posicion.y, sizeActual, sizeActual);
  }

  boolean estaMuerta() {
    if (posicion.y< height/2) {
      return true;
    }
    return false;
  }
}

