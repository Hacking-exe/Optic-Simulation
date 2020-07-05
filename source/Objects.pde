class Ray {
    Lense[] lenses;
    PVector[] path;
    Ray(Lense[] lenses, float h) {
        this.lenses = lenses;
        
        updateRay(h);
    }
    
    void updateRay(float h){
        PVector[] out = {new PVector(0,h)};
        PVector dir = new PVector(1, 0).normalize();
        for(PVector i = new PVector(0,h); i.x < width; i.add(dir)){
            for(Lense len : lenses) {
                if (abs(len.value(i.y) - i.x) < 1) {
                    out.append(i);
                }
            }
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
    
    private float f(float y) {
        return (4*(e - m) / (2 * d*d)) * y*y + (m / 2);
    }
}
