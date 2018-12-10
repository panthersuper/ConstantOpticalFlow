import processing.video.*;
Movie myMovie;

int width = 1280;
int height = 720;
Matrix3D bufferFrame;
boolean init = false;
Calculation cal = new Calculation();
Viz viz = new Viz();
Tracker tracker = new Tracker();


void setup() {
  size(1280, 720);
  myMovie = new Movie(this, "wall.mp4");
  myMovie.loop();
}

void draw() {
  
  image(myMovie, 0, 0);
  Matrix2D localFrame = cal.toGradMat(myMovie.pixels,width,height);

  if(!init){
    init = true;
    println("launching!!!");
    bufferFrame = new Matrix3D(localFrame);
  }
  else{
    bufferFrame.updateFrame(localFrame);

    float [] uv = cal.uvByImg(bufferFrame);
    tracker.addSpeed(uv);
    viz.showSpeed(uv,150,100);
    viz.showPath(tracker,200,50,200);

  
  
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
    
