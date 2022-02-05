//https://youtu.be/Dauo_TOGFEY
//How to Create an AMAZING PENDULUM PAINTING by CHELC PAINTS
//觀看次數：542,221次 2020年5月21日
//2022-01-22(六) 謝其叡的訊息:
//我昨天晚上睡不著在寢室玩手電筒想到的 
//可能拿個陀螺儀然後拿個繩子吊著做單擺運動
PGraphics canvas;//將軌跡能秀出, 用 PGraphics 殘留 2D 畫面
PVector p0, p1, p2;
//float angle=0.1, angle0=0.1, len=200;
//float dangle=0, v=0;
PVector v;
boolean bAnim=false, bInit=true;;
void setup(){
  size(640,360,P3D);
  camera(-300, 600, 600, 0, 0, 100, 0,0,-1);//up向量很奇怪,是向下 -- 因為y向下為正,所以3D的z負為y向下,寫0,0,-1
  //TODO: 未來可照 YouTube 畫面, 點4個角點, 推算出 camera 的 perspective() 及 camera() 參數
  p0 = new PVector(0,0,500);
  p1 = new PVector(0,0,0);
  p2 = new PVector(0,0,0);
  v = new PVector(0,0,0);
  canvas = createGraphics(600,600);//將軌跡能秀出, 用 PGraphics 殘留 2D 畫面
  resetAll();//including canvas reset
}
void draw(){
  background(255);

  stroke(#FF0000); line(0,0,0, 100,0,0); //x-axis, red
  stroke(#00FF00); line(0,0,0, 0,100,0); //y-axis, green
  stroke(#0000FF); line(0,0,0, 0,0,100); //z-axis, blue
  
  ellipse(p1.x, p1.y, 30, 30); //starting position on 2D canvas
  stroke(0); drawLine(p0, p1); //fishing line from top (p0) to 2D canvas (p1)
  if(mousePressed) drawLine(p1, p2); //moving direction (vector) on 2D canvas
  
  //fill(35,46,82);
  noFill(); box(600,600,8); //2D canvas
  drawSphere(p0); //a sphere in top (p0)
  if(bAnim){
    float g=0.98;
    PVector N=PVector.sub(p1,p0).normalize();
    PVector gravity=new PVector(0,0,-g);
    float mag = PVector.dot(gravity,N);
    //float a = g*sin(-angle);//這裡會變成 ax,ay
    PVector a = PVector.sub(gravity, PVector.mult(N,mag) );
    //v += a;
    //v *= 0.999; //TODO: 之後要加入空氣阻力/動能耗損
    v.add(a);
    v.z=0; //不是很確定,但v有z分量,所以暫時將z設為0
    //float dx = v;
    //dangle = asin(dx/len);
    //angle += dangle;
    //println(angle +" "+ dangle +" "+ v);
    p1.add(v);
    canvas.beginDraw();//將軌跡能秀出, 用 PGraphics 殘留 2D 畫面
    canvas.ellipse(p1.x+300, p1.y+300, 5,5); 
    canvas.endDraw();
  }
  image(canvas, -300,-300);//將軌跡能秀出, 用 PGraphics 殘留 2D 畫面
}
void drawLine(PVector p0, PVector p1){
  line(p0.x, p0.y, p0.z,  p1.x, p1.y, p1.z);
}
void drawSphere(PVector p){
  pushMatrix();
    translate(p.x, p.y, p.z);
    fill(#FF0000); noStroke(); sphere(10);
  popMatrix();
}
void mouseMoved(){
  if(bInit){
    p2.x = p1.x = mouseX-300; 
    p2.y = p1.y = mouseY-300;
  }
}
void mouseDragged(){
  p2.x = mouseX-300;
  p2.y = mouseY-300;
  //len=dist(p0.x, p0.y, p0.z, p1.x, p1.y, p1.z);
  //angle0=angle=atan2(mouseY-p0.y, mouseX-p0.x)-PI/2;
  //dangle=0;
  //v=0;
  v.x=0; v.y=0;
}
void mouseReleased(){
  if(mouseButton==LEFT){//放開時,依照速度,開始動畫
    bAnim=true;
    bInit=false;
    v = PVector.sub(p2,p1).div(10);
  }
}
void resetAll(){
  bAnim=false;
  bInit=true;
  p2.x=p1.x;
  p2.y=p1.y;
  canvas.beginDraw();
  canvas.background(255,128,128);
  canvas.endDraw();
}
void mousePressed(){
  if(mouseButton==LEFT){//按下時, 設好起始點,準備將要要動畫
    bAnim=false;
  }else if(mouseButton==RIGHT){//reset all
    resetAll();
  }
}
void keyPressed(){//reset all
    bAnim=false;
    bInit=true;
    p2.x=p1.x;
    p2.y=p1.y;  
}
