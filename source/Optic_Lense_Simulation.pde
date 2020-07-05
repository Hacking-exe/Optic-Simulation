float d = 7;
float m = 1;
float e = 3;

float c = 37.795275591;

Lense len1;
Lense len2;

Ray ray;

void setup() {
    size(800,400);
    len1 = new Lense(width/3, height/2, 7, 1, 3, 1.33);
    len2 = new Lense(2*width/3, height/2, 7, 3, 1, 1.33);
    Lense[] lenarray = {len1, len2};
    ray = new Ray(lenarray, height/2);
}

void draw() {
    
    background(255);
    
    stroke(255,0,0);
    strokeWeight(2);
    for(int i = 0; i < height; i+= height/20){
        //line(0,i,width,i);
    }
    
    //stroke(255,0,0);
    strokeWeight(2);
    ray.render();
    
    len1.render();
    len2.render();
}
