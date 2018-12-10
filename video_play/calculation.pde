class Calculation{
  Calculation() {
  }

  // return the gradient matrix
  public Matrix2D toGradMat(int[] pixels,int w,int h){
    float[][] mat = new float[w][h];
    
    for(int i = 0; i < pixels.length; i++) {
      // println(red(pixels[i]),green(pixels[i]),blue(pixels[i]));
      //println(brightness(pixels[i]));
       
      int thisW = i%w;
      int thisH = floor(i/w);
      mat[thisW][thisH] = brightness(pixels[i]);
    }
    
    //println(mat[640][360]);
    return new Matrix2D(mat);
  }

  // calculate u,v speed with the given two pts
  public float[] uvByTwoPts(Matrix3D bufferFrame, int[] pt1, int[] pt2){
    float[] out = new float[2];
    
    float Ex1 = bufferFrame.Ex(pt1[0],pt1[1]);
    float Ey1 = bufferFrame.Ey(pt1[0],pt1[1]);
    float Et1 = bufferFrame.Et(pt1[0],pt1[1]);
    
    float Ex2 = bufferFrame.Ex(pt2[0],pt2[1]);
    float Ey2 = bufferFrame.Ey(pt2[0],pt2[1]);
    float Et2 = bufferFrame.Et(pt2[0],pt2[1]);

    float u = Ey1 * Et2 - Ey2 * Et1;
    float v = Ex2 * Et1 - Ex1 * Et2;
    float delta = Ex1 * Ey2 - Ex2 * Ey1;
    
    out[0] = u/delta;
    out[1] = v/delta;
    
    //println("Et,"+Et2+','+Et1);
    //println("ratio:"+Ey2/Ex2+","+Ey1/Ex1);
    
    return out;
  }

  // speed in uv form predicted by the whole image frame
  public float[] uvByImg(Matrix3D bufferFrame){
    float[] out = new float[] {0,0};
    
    int thisW = bufferFrame.getW();
    int thisH = bufferFrame.getH();
    
    float sumExEy = 0;
    float sumExEt = 0;
    float sumEyEt = 0;
    float sumExSq = 0;
    float sumEySq = 0;
        
    for(int i=0;i<thisW-1;i++){
      for(int j=0;j<thisH-1;j++){
        float Ex = bufferFrame.Ex(i,j);
        float Ey = bufferFrame.Ey(i,j);
        float Et = bufferFrame.Et(i,j);
        
        sumExEy += Ex * Ey;
        sumExEt += Ex * Et;
        sumEyEt += Ey * Et;
        sumExSq += Ex * Ex;
        sumEySq += Ey * Ey; 
      }
    }
    
    float u = sumExEy * sumEyEt - sumEySq * sumExEt;
    float v = sumExEy * sumExEt - sumExSq * sumEyEt;
    float delta = sumExSq * sumEySq - sumExEy * sumExEy;
    
    out[0] = u/delta;
    out[1] = v/delta;
    
    return out;
  }
  
  // return bounding box in the format of 
  // [smallest_x,smallest_y,largest_x,largest_y]
  public float[] bbox(ArrayList<float []> locationList){
    float[] out = new float[] {1000000,1000000,-1000000,-1000000};
    
     for(float[] loc:locationList){
         if(loc[0]<out[0])
           out[0] = loc[0];
         if(loc[1]<out[1])
           out[1] = loc[1];
         if(loc[0]>out[2])
           out[2] = loc[0];
         if(loc[1]>out[3])
           out[3] = loc[1];
     }
    return out;
  }
  
  public float largeBound(ArrayList<float []> locationList){
    float[] bbox = bbox(locationList);
    float bound = 0;
    
    for(int i=0;i<bbox.length;i++){
      if(Math.abs(bbox[i])>bound)
        bound = Math.abs(bbox[i]);
    }
    return bound;
  }
  
  public ArrayList<float []> scaleList(ArrayList<float []> locationList,float scale){
      ArrayList<float []> list = new ArrayList<float []>();

    
     for(float[] loc:locationList){
       list.add(new float[] {loc[0]*scale,loc[1]*scale});
     }
     
     return list;
  }

}
