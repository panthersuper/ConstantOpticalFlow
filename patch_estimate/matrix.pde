class Matrix2D{
  // w*h
  private float[][] myMat;
  
  Matrix2D(float[][] myMat) {
    this.myMat = myMat;
  }
  
  public float getE(int i,int j){
    return this.myMat[i][j];
  }
  
  public int getW(){
    return this.myMat.length;
  }
  
  public int getH(){
    return this.myMat[0].length;
  }
}

class Matrix3D{
  // 2*w*h 
  // matrix describing the two adjacent frames
  private Matrix2D myMat1;
  private Matrix2D myMat2;
  private int[] location;
    
  
  Matrix3D() {
  }
  
  Matrix3D(int[] loc) {
    this.location = loc;
  }


  Matrix3D(Matrix2D myMat1,Matrix2D myMat2) {
    this.myMat1 = myMat1;
    this.myMat2 = myMat2;
  }
  
  Matrix3D(Matrix2D myMat) {
    this.myMat1 = myMat;
    this.myMat2 = myMat;
  }
  
  // update frame by replacing mat1 with mat2, and mat with the new frame
  public void updateFrame(Matrix2D myMat){
    this.myMat1 = this.myMat2;
    this.myMat2 = myMat;
  }
  
  public void updateAllFrame(Matrix2D myMat1,Matrix2D myMat2){
    this.myMat1 = myMat1;
    this.myMat2 = myMat2;
  }
  
  public int getW(){
    return this.myMat1.getW();
  }
  
  public int getH(){
    return this.myMat1.getH();
  }
  
  public int[] getLoc(){
    return this.location;
  }
  
  public void setLoc(int[] loc){
    this.location = loc;
  }
  
  // return a sub matrix
  public Matrix3D getPatch(int[] loc,int w,int h){
    float[][] mat1 = new float[w][h];
    float[][] mat2 = new float[w][h];

      //int thisW = i%w;
      //int thisH = floor(i/w);
      //mat[thisW][thisH] = brightness(pixels[i]);
    for(int i=0;i<w;i++){
      for(int j=0;j<h;j++){
        mat1[i][j] = this.getE(loc[0]+i,loc[1]+j,0);
        mat2[i][j] = this.getE(loc[0]+i,loc[1]+j,1);
      }
    }
    
    Matrix3D patch = new Matrix3D(new Matrix2D(mat1),new Matrix2D(mat2));
    patch.setLoc(loc);
    return patch;
  }
  
  public ArrayList<Matrix3D> uniformPatch(int gap){
    int w = this.getW();
    int h = this.getH();
    ArrayList<Matrix3D> list = new ArrayList<Matrix3D>();

    for(int i=0;i<w-gap;i+=gap){
      for(int j=0;j<h-gap;j+=gap){
        int[] loc = new int[] {i,j};
        list.add(this.getPatch(loc,gap,gap));
      }
    }
    
    return list;
  }
   
  // the brightness at pixel (i,j) in frame k (k in [0,1])
  public float getE(int i,int j,int k){
    if(k==0)
        return this.myMat1.getE(i,j);
    else
        return this.myMat2.getE(i,j);
  }
  
  // Ex at location i+1/2,j+1/2
  public float Ex(int i,int j){   
    float out = 
          1.0/4 * (this.getE(i,j+1,0) + this.getE(i+1,j+1,0) + this.getE(i,j+1,1) + this.getE(i+1,j+1,1))
        - 1.0/4 * (this.getE(i,j,0) + this.getE(i+1,j,0) + this.getE(i,j,1) + this.getE(i+1,j,1));
    
    return out;
  }
  
  // Ey at location i+1/2,j+1/2
  public float Ey(int i,int j){
    float out = 
          1.0/4 * (this.getE(i+1,j,0) + this.getE(i+1,j+1,0) + this.getE(i+1,j,1) + this.getE(i+1,j+1,1))
        - 1.0/4 * (this.getE(i,j,0) + this.getE(i,j+1,0) + this.getE(i,j,1) + this.getE(i,j+1,1));
    
    return out;
  }
  
  // Et at location i+1/2,j+1/2
  public float Et(int i,int j){
    float out = 
          1.0/4 * (this.getE(i+1,j,1) + this.getE(i+1,j+1,1) + this.getE(i,j+1,1) + this.getE(i,j,1))
        - 1.0/4 * (this.getE(i+1,j,0) + this.getE(i+1,j+1,0) + this.getE(i,j+1,0) + this.getE(i,j,0));
    
    return out;
  }
}
