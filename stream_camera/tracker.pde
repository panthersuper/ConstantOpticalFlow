class Tracker{
  // a list to keep a record of the speeds of each frame
  ArrayList<float []> list;

  public Tracker(){
    list = new ArrayList<float []>();
  }
  
  public void addSpeed(float [] speed){
    list.add(speed);
  }
  
  public void reset(){
    list = new ArrayList<float []>();
  }
  
  public float [] getSpeed(int frame){
    return list.get(frame);
  }
   
   // get the estimated location by accumulate speed by frame
  public float [] getLocation(int frame){
    float[] location = new float[] {0,0};
    int count = 0;
    
     //speed in each frame
     for(float[] spd:list){
         if (count < frame){
           count ++;
           location[0] += spd[0];
           location[1] += spd[1];
         }
         else
           break;
     }  
     return location;
  }
  
   // get the estimated location by accumulate speed by frame
  public float [] getLatestLocation(){
    float[] location = new float[] {0,0};
    
     //speed in each frame
     for(float[] spd:list){
         location[0] += spd[0];
         location[1] += spd[1];
     }  
     return location;
  }

  public ArrayList<float []> getSpeedList(){
    return list;
  }
  
  public ArrayList<float []> getLocationList(){
    
    ArrayList<float []> locationList = new ArrayList<float []>();;

    float[] location = new float[] {0,0};
    
     //speed in each frame
     for(float[] spd:list){
         location[0] += spd[0];
         location[1] += spd[1];
         locationList.add(new float[] {location[0],location[1]});
     }  

    
    return locationList;

  }
  






}
