float d = 7;
float m = 1;
float e = 3;

float c = 37.795275591;

Lense len1;
Lense[] lenarray;

Ray[] rays;
int nRays = 10;

void setup() {
    size(1500,400);
    len1 = new Lense(100, height/2, 10, 4, 1, 1.5);
    lenarray = new Lense[1]; lenarray[0] = len1; 
    rays = new Ray[nRays];
    for(int i = 0; i < nRays; i++){
        float h = i*height/(nRays +1) + height/(nRays +1);
        rays[i] = new Ray(lenarray, h);
    }
    
}

void draw() {
    
    background(255);
    
    stroke(255,0,0);
    strokeWeight(2);
    for(int i = 0; i < height; i+= height/20){
        //line(0,i,width,i);
    }
    
    stroke(255,0,0);
    //strokeWeight(2);
    for(Ray ray : rays)
        ray.render();
    
    for(Lense lense : lenarray)
        lense.render();
}
