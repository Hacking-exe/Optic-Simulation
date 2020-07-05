class Ray {
    Lense[] lenses;
    PVector[] path;
    Ray(Lense[] lenses, float h) {
        this.lenses = lenses;
        
        updateRay(h);
    }
    
    PVector[] updateRay(float h){
        PVector[] out = {new PVector(0,h)};
        PVector dir = new PVector(1, 0).normalize();
        for(PVector i = new PVector(0,h); i.x <= width; i.add(dir)){
            for(Lense len : lenses) {
                if (abs(len.value(i.y) - i.x) < .5) {
                    out = (PVector[])append(out, new PVector(i.x, i.y));
                }
                if (abs(len.value(i.y, true) - i.x) < .5) {
                    out = (PVector[])append(out, new PVector(i.x, i.y));
                }
            }
            
            if(abs(i.x - width) < .5)
                out = (PVector[])append(out, new PVector(i.x, i.y));
        }
        
        path = out;
        return out;
    }
    
    void render(){
        for(int i = 1; i < path.length; i++) {
            stroke(map(i, 1, path.length, 255, 50), 0, 0);
            line(path[i-1].x, path[i-1].y, path[i].x, path[i].y);
        }
    }
}

class Lense {
    float d, m, e;
    float r;
    float xPos, yPos;
    float c = 37.795275591;
    
    Lense(float x, float y, float diameter, float middleWidth, float edgeWidth, float refractiveIndex) {
        d = diameter;
        m = middleWidth; 
        e = edgeWidth;
        r = refractiveIndex;
        xPos = x;
        yPos = y;
    }
    
    void render(){
        pushMatrix();
        translate(xPos, yPos);
        
        noStroke();
        fill(61, 196, 212, map(r, 1.0, 2.0, 0, 200));
        
        beginShape();
        for(float i = -d/2; i <= d/2; i+= 0.1) {
            float x = f(i);
            vertex(x*c,i*c);
        }
        for(float i = d/2; i >= -d/2; i-= 0.1) {
            float x = f(i);
            vertex(-x*c,i*c);
        }
        endShape();
        popMatrix();
    }
    
    float value(float y) {
        return -c*f((y - yPos)/c) + xPos;
    }
    
    float value(float y, boolean back) {
        int mult = back ? 1 : -1;
        return mult * c*f((y - yPos)/c) + xPos;
    }
    
    float tang(float y, boolean front) {
        
      return 0;
    }
    
    private float f(float y) {
        return (4*(e - m) / (2 * d*d)) * y*y + (m / 2);
    }
}
