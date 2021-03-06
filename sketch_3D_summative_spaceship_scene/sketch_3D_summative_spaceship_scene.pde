import queasycam.*;

float speed;
PShape rocketcapsule;
PImage earth;
PShape globe;
PVector pos;
PVector dir;
PVector vel;
PVector accel;
float topSpeed;
float globeRotate=0;
float shipMove=0;
float shipSpeed=0.5;
float shipRotation;
float shipRotationConstrained;
QueasyCam cam;


void setup()
{
  size(800, 800, P3D);
  cam= new QueasyCam (this);
  rocketcapsule=loadShape("rocketandcapsule copy/tinker.obj");
  earth=loadImage("earth texture.jpeg");
  cam= new QueasyCam (this);
  pos = new PVector(300, -200, -169.68);
  vel=new PVector(0, 0, 0);
  dir = new PVector(0, 5, 0);
  //angle= new PVector(1.5708,0);
  accel = new PVector(0, 0, 0);
  noStroke();
  globe=createShape(SPHERE, 500);
  globe.setTexture(earth);
}

void draw()

{


  background(0);
  lights();



  speed=0.1;
  topSpeed=10;
  PVector target = new PVector(300, -300, 0);
  PVector dir = target.copy().sub(pos); 
  dir.normalize(); 
  dir.mult(speed);
  accel=dir;
  vel.add(accel);
  vel.limit(topSpeed);
  pos.add(vel);
  
//thing it orbits around
  pushMatrix();
  translate(300, -300, 0);
  sphere(10);
  popMatrix();
  shipMove=shipMove-shipSpeed;
  println((shipMove-80)*1.414);

  //rocket
  pushMatrix();
  if ((shipMove>-80)&&(shipMove<0)) 
  {
    translate(300, shipMove, 0);
    rotateX(1.570800000709);
  }
  if ((shipMove>-200)&&(shipMove<-79))
  {
    translate(300, shipMove, ((shipMove+80)* 1.414));
    shipRotation=shipRotation+0.01;
    shipRotationConstrained=constrain(shipRotation, 0, 0.785398);
    rotateX(1.5708+shipRotationConstrained);
  }
  if (shipMove<-200)
  {
    translate(pos.x, pos.y, pos.z);
    rotateX(1.5708+0.785398);
    rotateY(globeRotate*100);
  }
  shape(rocketcapsule);
  popMatrix();




  //earth
  pushMatrix();
  noStroke();
  translate(300, 580, 0);
  globeRotate=globeRotate-(0.00174533/2);
  rotateY(globeRotate);
  shape(globe);
  popMatrix();
}
