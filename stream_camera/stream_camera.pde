  import processing.video.*; 

Capture cam; 
int width = 1280;
int height = 720;
Matrix3D bufferFrame;
boolean init = false;
Calculation cal = new Calculation();
Viz viz = new Viz();
Tracker tracker = new Tracker();

void setup() { 
  size(1280, 720); 
  cam = new Capture(this);
  cam.start();
  
  if (cam.available()){
    cam.read(); 
    image(cam, 0, 0); 
    println("launching!!!");
  }
} 
 
void draw() { 
  if (cam.available()) { 
    // Reads the new frame
    cam.read(); 
    Matrix2D localFrame = cal.toGradMat(cam.pixels,width,height);
    image(cam, 0, 0); 

    if(!init){
      init = true;
      println("launching!!!");
      bufferFrame = new Matrix3D(localFrame);
    }
    else{
      //bufferFrame.updateAllFrame(localFrame,localFrame);
      bufferFrame.updateFrame(localFrame);
      
      int[] pt1 = new int[] {640,360};
      int[] pt2 = new int[] {360,640};

      float [] uv0 = cal.uvByTwoPts(bufferFrame, pt1, pt2);
      float [] uv = cal.uvByImg(bufferFrame);
      
      tracker.addSpeed(uv);

      //println("uv0,"+uv0[0]+","+uv0[1]);
      //println("uv,"+uv[0]+","+uv[1]);
      viz.showSpeed(uv,150,100);
      viz.showPath(tracker,200,50,200);
    
    }
      
    
    
  } 
} 

void mousePressed() {
  //cam.stop();
  tracker.reset();
}
    
