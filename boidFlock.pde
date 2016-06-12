class boidFlock {
  ArrayList<boid> boids;
  PVector origin;
  float size;
  
  boidFlock(PVector o, int flockSize) {
    origin = o.get();
    size = flockSize;
    boids = new ArrayList<boid>();
    
    for (int i=0; i<size; i++) {
      //initialise random position on the screen 
      PVector pos = new PVector(random(0,width),random(0,height));
      boid b_temp = new boid(pos);
      boids.add(b_temp);
    }
  }
  
  void run() {
    //centreMass();
    for (boid b : boids) {
      b.run();
    }
    centreMass();
    separation();
    speed_match();
  }
  
  void attracter(PVector force) {
    for (boid b : boids) {
      //apply a force to get them to move to the centre of the flock..
      PVector f = force.get();
      f.sub(b.location);
      f.normalize();
      f.mult(0.01);
      b.applyForce(f);
    }
  }
  
  void centreMass() {
   //calculates where the centre of the flock is and moves the boid towards it
   PVector c = new PVector(0,0);
   for (int i=0; i<size; i++) {
     PVector b = boids.get(i).location;
     c.add(b);
   }
   c.div(size);
   fill(255,0,0);
   ellipse(c.x,c.y,10,10);
   fill(0);
   attracter(c);
}
  
  void separation() {
    //keeps all the boids separated from each other
    for (int i=0; i<size; i++) {
      boid b = boids.get(i);
      PVector b1 = boids.get(i).location;
      for (int j=0; j<size; j++) {
        PVector b2 = boids.get(j).location;
        if (j != i && b1.dist(b2) < 20) {
          PVector dist = PVector.sub(b1,b2);
          float power = dist.mag();
         
          //making a greater repulsion force the closer objects get
          dist.normalize();
          dist.mult(pow(1/power,1));
          dist.mult(10);
          println(dist.mag());
         
          b.applyForce(dist);
        }
      } 
    }        
  }
  
  void speed_match() {
    //makes boid try to match the speed of the surrounding boids
    PVector v = new PVector(0,0);
    for (int i=0; i<size; i++) {
      PVector bv = boids.get(i).velocity;
      v.add(bv);
    }
    v.div(size);
    attracter(v);
    for (boid b : boids) {
      PVector f = v.get();
      f.sub(b.velocity);
      f.normalize();
      f.mult(0.01);
      b.applyForce(f);
    }
  }
}