class Viz{
  
  Calculation cal = new Calculation();

  Viz(){
  }
  
  // show path calculated by accumulating recorded speed
  public void showPath(Tracker tracker,int size,int left,int top){
    ArrayList<float []> locationList = tracker.getLocationList();
    
    float bound = cal.largeBound(locationList);
    float scale = 0;
    if(bound>0)
      scale = 0.9 * size / 2 /bound;
    
    ArrayList<float []> pline = cal.scaleList(locationList,scale);
    
    smooth();
    noStroke();
    fill(255, 255, 255, 100);
    rect(left, top, size, size);
    
    stroke(0,0,0);
    strokeWeight(2);
    for(int i=0;i<pline.size()-1;i++){
      //line(pline.get(i)[1]+left+size/2,pline.get(i)[0]+top+size/2,pline.get(i+1)[1]+left+size/2,pline.get(i+1)[0]+top+size/2);
      line(-pline.get(i)[1]+left+size/2,-pline.get(i)[0]+top+size/2,-pline.get(i+1)[1]+left+size/2,-pline.get(i+1)[0]+top+size/2);

    }
  }
  
  // show real time calculated frame speed
  public void showSpeed(float [] uv,int w,int h){
    println(uv[0]+","+uv[1]);

    smooth();
    noStroke();
    fill(255, 255, 255, 100);
    ellipse(w, h, 150, 150);
    ellipse(w, h, 125, 125);
    ellipse(w, h, 100, 100);
    ellipse(w, h, 25, 25);
    ellipse(w, h, 50, 50);
    ellipse(w, h, 75, 75);
    
    stroke(0,0,0);
    strokeWeight(2);
    line(w-uv[1]*10, h-uv[0]*10,w,h);

    //fill(0,0,0);
    //ellipse(w-uv[1]*10, h-uv[0]*10, 10, 10);
  }
  
  public void vizPatchSpd(Matrix3D patch,int len){
    float [] uv = cal.uvByImg(patch);
    int[] loc = patch.getLoc();
    int w = patch.getW();
    int h = patch.getH();
    
    stroke(255,0,0);
    strokeWeight(1);

    line(loc[0]+w/2+uv[1]*len/20, loc[1]+h/2+uv[0]*len/20,loc[0]+w/2,loc[1]+h/2);
     
    float uvSpeed = uv[0] * uv[0] + uv[1] * uv[1];
    if(uvSpeed<2){
      stroke(0,0,0);
      fill(0,0,0,100);
      rect(loc[0],loc[1],w,h);
    }

  }
  
  
  public void vizPatchList(ArrayList<Matrix3D> list,int gap){
     for(Matrix3D patch:list){
       vizPatchSpd(patch,gap);
     }
  }









}
