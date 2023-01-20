import processing.sound.*;

FFT fft;
// AudioIn in;
SoundFile file;

String songFilePath = "tainted-love.mp3";

int bands = 64;
int bandsToCheck = 64;
float[] spectrum = new float[bands];
float[] history = new float[bands];

PImage songImage;
// PImage songImageBlurred;

String songImagePath = "tainted-love.jpg";
String songTitle = "Tainted Love";
String songArtist = "Soft Cell";

float songDuration;

void setup() {
    fullScreen();
    background(0);

    songImage = loadImage(songImagePath);
    // songImageBlurred = loadImage(songImagePath);
    // songImageBlurred.filter(BLUR, 50);
    imageMode(CENTER);
        
    fft = new FFT(this, bands);
    
    file = new SoundFile(this, songFilePath);
    songDuration = file.duration();
    file.play();


    println(songDuration);

    fft.input(file);

    image(songImage, 796, 476, 600, 600);

    textSize(52);
    text(songTitle, 1216, 418);
    textSize(32);
    text(songArtist, 1216, 495);

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