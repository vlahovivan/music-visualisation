import processing.sound.*;
Waveform wave;
FFT fft;
AudioIn in;

int historySize = 540;
float[] history = new float[historySize];
float[] fftHistory = new float[128];

void setup() {
  fullScreen();
  background(255);
    
  // Create an Input stream which is routed into the Amplitude analyzer
  wave = new Waveform(this, historySize);
  fft = new FFT(this, 128);
  in = new AudioIn(this);
  in.start();
  wave.input(in);
  fft.input(in);

}      

void draw() {
    background(0);
    noStroke();


    wave.analyze(history);
    fft.analyze(fftHistory);
    // history[frameCount%640] = val;
    strokeWeight(3);
    beginShape();
    noFill();
    stroke(#ff0000);
    for(int i=0; i<historySize; i++) {
        vertex(i * width / (float) historySize, map(history[i], -1, 1, height, 0));
    }
    endShape();
    noFill();
    for(int i=0; i<128; i++) {
        stroke(#0000ff);
        line(i * width/128.0, height, i*width/128.0, map(fftHistory[i], 0, 1, height, 0));
    }
    // rect(0, , width, map(val, 0, 1, 0, height));
}