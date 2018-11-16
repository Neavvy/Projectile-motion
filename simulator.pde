float a, b, x, y;
float bulX = -15;
float bulY = 800;
int m, m_prev;
float t;
float r;
int inter = 0;
boolean mov = false, ran = true, trafiony = false;

int v0 = 125;
float g = 9.81;

PImage tank;
PImage explosion;

void setup() 
{
  size(1600, 800);
  stroke(70);
  fill(70);
  background(255);
  
  tank = loadImage("tank.png");
  explosion = loadImage("explosion.png");
}

void draw()
{
  m = millis();
  background(255);
  
  textSize(22);
  text("Angle:", 10, 30);
  text("Speed:", 10, 60);
  text("Time:", 10, 90);
  text("Range:", 10, 120);
  text("Max height:", 10, 150);

  
  if(mov)
  {
    text(b * 360 / 6.282, 134, 30);
    text("°", 250, 30);
    
    text(v0, 141, 60);
    text("m/s", 250, 60);
    
    text(2 * v0 * sin(b) / g, 134, 90);
    text("s", 250, 90);
    
    text(v0 * v0 * sin(2 * b) / g, 134, 120);
    text("m", 250, 120);
    
    text(v0 * v0 * sin(b) * sin(b) / (2 * g), 134, 150);
    text("m", 250, 150);
  }
  
  else
  {
    text(a * 360 / 6.282, 132, 30);
    text("°", 248, 30);
  }
  
  if(ran)
  {
    r = random(400, 1500);
    ran = false;
  }
  
  a = atan((height-y)/x);
  t = m - m_prev;
  
  if(mov && m - inter >= 5)
  {
    inter = m;
    bulX = v0 * cos(b) * t / 1000;
    bulY = 800 - (v0 * sin(b) * t / 1000) + (g * t / 1000 * t / 1000 / 2);
    if(!trafiony) ellipse(bulX,bulY,10,10);
  }
   
  if(bulX >= r && bulX <= (r + 130) && bulY >= (height - 59) && bulY <= height)
  {
    trafiony = true;
  }
  
  if(!trafiony) image(tank, r, height - 58);
  else image(explosion, r - 35, height - 115);
  
  if(x != 0) x = mouseX; 
  else x = 0.00001;
  y = mouseY;
  
  translate(-10, height);
  rotate(-a);
  rect(0, -4, 55, 20);
}

void mousePressed()
{
  m_prev = m;
  b = a;
  mov = true;
}

void keyPressed()
{
  if(key == 'R' || key == 'r')
  {
    mov = false;
    ran = true;
    trafiony = false;
  }
}
