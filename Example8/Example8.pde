import processing.sound.*;

FFT fft;
// AudioIn in;
SoundFile file;
LowPass lowPass;
HighPass highPass;

String songFilePath = "tainted-love.mp3";

int bands = 64;
int bandsToCheck = 64;
float[] spectrum = new float[bands];
float[] history = new float[bands];

void setup() {
    fullScreen();
    background(0);
        
    fft = new FFT(this, bands);
    // lowPass = new LowPass(this);
    highPass = new HighPass(this);
    
    file = new SoundFile(this, songFilePath);
    highPass.process(file, 5000);
    file.play();

    // lowPass.process(file, 800);
    fft.input(file);

    frameRate(60);

}      

void draw() { 
    // background(0);
    fft.analyze(spectrum);
    noStroke();

    // image(songImageBlurred, width/2, height/2, width * 1.25, width * 1.25 * songImageBlurred.height / songImageBlurred.width);
    fill(0);
    rect(0, height - 260, width, 260);
    rect(0, 0, width, 20);
    fill(255);
    rect(0, 0, file.percent() / 100.0 * width, 16, 0, 8, 8, 0);

    for(int i = 0; i < bandsToCheck; i++){
        history[i] = max(spectrum[i], history[i]*0.9);

        float barHeight = 70 + 500 * history[i];
        float barWidth = width/bandsToCheck*0.75;

        rect(i*width/bandsToCheck, height-barHeight, barWidth, barHeight, barWidth/2, barWidth/2, 0, 0);
    } 
}