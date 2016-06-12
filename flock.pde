boidFlock birds;

void setup() {
  size(500,500);
  PVector centre = new PVector(width/2, height/2);
  birds = new boidFlock(centre, 10);
}

void draw() {
  background(255);
  birds.run();
}
  