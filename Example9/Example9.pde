import processing.sound.*;
Amplitude amp;
AudioIn in;

float[] history = new float[640];

void setup() {
  fullScreen();
  background(255);
    
  // Create an Input stream which is routed into the Amplitude analyzer
  amp = new Amplitude(this);
  in = new AudioIn(this, 0);
  in.start();
  amp.input(in);
}      

void draw() {
    background(0);
    strokeWeight(3);

    float val = 2*amp.analyze();
    history[frameCount%640] = val;
    beginShape();
    noFill();
    for(int i=0; i<min(640, frameCount); i++) {
        stroke(lerpColor(#ff0000, #00ff00, history[(frameCount - min(640, frameCount) + i) % 640]));
        vertex(i * width / 640.0, map(history[(frameCount - min(640, frameCount) + i) % 640], 0, 1, height, 0));
    }
    endShape();
    // rect(0, , width, map(val, 0, 1, 0, height));
}