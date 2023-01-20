import processing.sound.*;

FFT fft;
AudioIn in;

int bands = 256;
int bandsToCheck = 80;
float[] spectrum = new float[bands];
float[] history = new float[bands];



float songDuration;

void setup() {
    fullScreen();
    background(255);
        
    fft = new FFT(this, bands);
    
    in = new AudioIn(this, 0);
  
    in.start();
    
    fft.input(in);
}      

void draw() { 
    background(0);
    fft.analyze(spectrum);
    noStroke();

    for(int i = 0; i < bandsToCheck; i++){
        history[i] = max(spectrum[i], history[i]*0.9);

        float barHeight = 70 + (height - 70) * min(1.0, history[i]);
        float barWidth = width/bandsToCheck*0.75;

        rect(i*width/bandsToCheck, height-barHeight, barWidth, barHeight, barWidth/2, barWidth/2, 0, 0);
    } 
}