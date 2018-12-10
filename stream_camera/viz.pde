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
      line(-pline.get(i)[1]+left+size/2,pline.get(i)[0]+top+size/2,-pline.get(i+1)[1]+left+size/2,pline.get(i+1)[0]+top+size/2);

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

    fill(0,0,0);
    ellipse(w-uv[1]*10, h-uv[0]*10, 10, 10);
  }
  










}
