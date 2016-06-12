class boid {
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float angle;
  float aVel;
  
  boid(PVector l) {
    location = l.get();
    //velocity = new PVector(width/2,height/2);
    //velocity.sub(location);
    //velocity.normalize();
    
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    //not sure if I need anymore information here..
  }
  
  void run() {
    update();
    display();
  }
  
  void update() {
    // probably only needed if I'm messing around with velocities..
    
   velocity.add(acceleration);
   velocity.limit(1);
   location.add(velocity);
   acceleration.mult(0);
  }
  
  void display() {
    stroke(0);
    fill(0);
    pushMatrix();
    translate(location.x,location.y);
    rotate(angle);
    ellipse(0,0,16,16);
    popMatrix();
  }
  
   void applyForce(PVector force) {
   PVector f = force.get();
   f.limit(0.0050);
   println(f.mag());
   acceleration.add(force);
 }
}