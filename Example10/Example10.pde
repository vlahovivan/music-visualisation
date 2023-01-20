import processing.sound.*;
Waveform wave;
FFT fft;
TriOsc triOsc;

float[] history = new float[640];
float[] fftHistory = new float[128];

void setup() {
  size(640, 360);
  background(255);
    
  // Create an Input stream which is routed into the Amplitude analyzer
  wave = new Waveform(this, 640);
  fft = new FFT(this, 128);
  triOsc = new TriOsc(this);
  triOsc.play();
  wave.input(triOsc);
  fft.input(triOsc);

}      

void draw() {
    background(0);
    noStroke();

    float freq = map(mouseX, 0, width, 100, 2000);
    float ampl = map(mouseY, 0, height, 0, 1);
    triOsc.freq(freq);
    triOsc.amp(ampl);

    wave.analyze(history);
    fft.analyze(fftHistory);
    // history[frameCount%640] = val;
    beginShape();
    noFill();
    for(int i=0; i<640; i++) {
        stroke(lerpColor(#ff0000, #00ff00, history[i]));
        vertex(i, map(history[i], -1, 1, height, 0));
    }
    endShape();
    noFill();
    for(int i=0; i<128; i++) {
        stroke(#0000ff);
        line(i * width/128.0, height, i*width/128.0, map(fftHistory[i], 0, 1, height, 0));
    }
    // rect(0, , width, map(val, 0, 1, 0, height));
}