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
  
  Matrix3D() {
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
