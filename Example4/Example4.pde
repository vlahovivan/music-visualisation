import processing.sound.*;

FFT fft;

SoundFile file;
String songFilePath = "rumbera.mp3";

int bands = 128;
int bandsToCheck = 128;
float[] spectrum = new float[bands];
float[] history = new float[bands];

void setup() {
    fullScreen();
    background(255);
        
    fft = new FFT(this, bands);
    
    file = new SoundFile(this, songFilePath);
  
    file.play();
    file.rate(1.09);
    
    fft.input(file);
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