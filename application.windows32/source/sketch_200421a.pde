import processing.video.*;

Capture cam;
PImage img,imgatt;
PImage viewer;
int cellsize = 4; // Dimensions of each cell in the grid
int cols, rows;   // Number of columns and rows in our system

int noff=-120;
int poff=30;


void setup()
{
  size(640, 480, P3D);
  cols = width;
  rows = height;
  
  img = createImage(width, height, RGB);
  imgatt = createImage(width, height, RGB);
  viewer = createImage(width, height, RGB);
  String[] cameras = Capture.list();
  
  if (cameras.length!= 0){
    cam = new Capture(this, cameras[1]);
    cam.start();
  }
}
void keyPressed() {
copyn();

}
void copyn(){
  img.copy(cam,0,0,cam.width,cam.height,0,0,cam.width,cam.height);
  img.updatePixels();
}
boolean once=true;
void draw()
{
  if(once){
    once=false;
    copyn();
  }
  if (cam.available() == true){   
    imgatt.copy(cam,0,0,cam.width,cam.height,0,0,cam.width,cam.height);
    imgatt.updatePixels();
    cam.read();
  }
  
  loadPixels();
  cam.loadPixels();
  imgatt.loadPixels();
  img.loadPixels();
  viewer.loadPixels();
  for ( int x = 0; x < cam.width;x++) {
    for ( int y = 0; y < cam.height;y++) {
      int loc = (x + y*cam.width);  
        float r = red(img.pixels[loc]);
        float g = green(img.pixels[loc]);
        float b = blue(img.pixels[loc]);
        float r2 = red(imgatt.pixels[loc]);
        float g2 = green(imgatt.pixels[loc]);
        float b2 = blue(imgatt.pixels[loc]);
        if(numberAround(int(r)-int(r2),int(noff),int(poff))&&numberAround(int(b)-int(b2),int(noff),int(poff))&&numberAround(int(g)-int(g2),int(noff),int(poff))){
         viewer.pixels[loc]=color(0,255,0);
        } else{
         viewer.pixels[loc]=imgatt.pixels[loc];
        }
    }
  }  
  viewer.updatePixels();
 image(viewer, 0, 0);
}
boolean numberAround(int a,int b,int c){
  boolean tot=false;
  if(a>b&&a<c){
    tot=true;
  }
  return tot;
}
