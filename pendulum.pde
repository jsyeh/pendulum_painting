//https://www.youtube.com/watch?v=sJG-rXBbmCc
// For the Love of Physics - Walter Lewin - May 16, 2011
//F=mg, 在切線上的分量是 mg*sin(angle) = F = ma
// a = g*sin(angle)
// v+=a; dx+=v; len*sin(dangle)=dx
// dangle = arccos(dx/len)
PVector p0, p1;
float angle=0.1, angle0=0.1, len=200;
float dangle=0, v=0;
boolean bAnim=false;
void setup(){
  size(400,600);
  p0=new PVector(200,100);
}
void draw(){
  background(255);
//  drawLine(p0, len, angle0, true);//秀出對應的長度label
  drawLine(p0, len, angle, false);//用來畫動畫的單擺
  if(bAnim){
//F=mg, 在切線上的分量是 mg*sin(angle) = F = ma
// 加速度 a = g*sin(angle)
// v+=a; dx+=v; len*sin(dangle)=dx //dx是在圓弧上的位移量
// dangle = arccos(dx/len)
    float a = 0.98*sin(-angle);
    v+=a;//v接近0
    v *= 0.999;//能量耗損,剩下多少
    float dx=v;
    dangle = asin(dx/len);//糟,dx/len是0
    angle += dangle;
    println(angle+" "+dangle+" "+v);
  }
}
void drawLine(PVector p0, float len, float angle, boolean bLabel){
  float a2=angle+PI/2;
  float x=p0.x+len*cos(a2), y=p0.y+len*sin(a2);
  line(p0.x, p0.y, x, y);
  if(bLabel){//drawing label
    float shiftX=10*cos(a2+PI/2), shiftY=10*sin(a2+PI/2);
    line(p0.x+shiftX, p0.y+shiftY, x+shiftX, y+shiftY);
    fill(0);
    pushMatrix();
    translate( (p0.x+x)/2+shiftX, (p0.y+y)/2+shiftY );
    rotate(a2+PI);
    textAlign(CENTER,BOTTOM);
    text(""+int(len), 0, 0);
    popMatrix();
    fill(255);
  }
  fill(255); ellipse(x,y,30,30);
}
void lineSeg(PVector p0, PVector p1){
  line(p0.x, p0.y, p1.x, p1.y);
}
void lineSeg(PVector p0, float x, float y){
  line(p0.x, p0.y, p0.x+x, p0.y+y);
}
void mouseDragged(){
  bAnim=false;
  len=dist(mouseX,mouseY,p0.x,p0.y);
  angle0=angle=atan2(mouseY-p0.y,mouseX-p0.x)-PI/2;
  dangle=0;
  v=0;
}
void mouseReleased(){
  bAnim=true;
}
