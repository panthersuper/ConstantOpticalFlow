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
    cam.read();
    Matrix2D localFrame = cal.toGradMat(cam.pixels,width,height);
  
    image(cam, 0, 0);
  
    if(!init){
      init = true;
      println("launching!!!");
      bufferFrame = new Matrix3D(localFrame);
    }
    else{
      bufferFrame.updateFrame(localFrame);
  
      //float [] uv = cal.uvByImg(bufferFrame);
      //tracker.addSpeed(uv);
      //viz.showSpeed(uv,150,100);
      //viz.showPath(tracker,200,50,200);
      
      int gap = 20;
      ArrayList<Matrix3D> patches = bufferFrame.uniformPatch(gap);
      viz.vizPatchList(patches,gap);
    
    }
  }

}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}

void mousePressed() {
  //cam.stop();
  tracker.reset();
}
    
