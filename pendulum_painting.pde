//https://youtu.be/Dauo_TOGFEY
//How to Create an AMAZING PENDULUM PAINTING by CHELC PAINTS
//觀看次數：542,221次2020年5月21日
//2022-01-22(六) 謝其叡送私訊
//我昨天晚上睡不著在寢室玩手電筒想到的
//可能拿個陀螺儀然後拿個繩子吊著做單擺運動
void setup(){
  size(300,300, P3D);
  camera(-300, 300, -300, -150, -150, 100, 0,0,1);
}
void draw(){
  line(0,0,0, -150,-150,100);//ellipse(100,100,10,10);
  pushMatrix();
  fill(35,46,82);
  box(300,300,30);
  popMatrix();
}
