import processing.sound.*;

FFT fft;
// AudioIn in;
SoundFile file;

String songFilePath = "rumbera.mp3";

int bands = 128;
int bandsToCheck = 80;
float[] spectrum = new float[bands];
float[] history = new float[bands];

PImage songImage;
// PImage songImageBlurred;

String songImagePath = "rumbera.png";
String songTitle = "Rumbera";
String songArtist = "Disko";

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
    file.rate(1.09);
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
    rect(0, height - 220, width, 220);
    rect(0, 0, width, 20);
    fill(255);
    rect(0, 0, file.percent() / 100.0 * width, 16, 0, 8, 8, 0);

    for(int i = 0; i < bandsToCheck; i++){
        history[i] = max(spectrum[i], history[i]*0.9);

        float barHeight = 70 + 140 * min(1.0, history[i]);
        float barWidth = width/bandsToCheck*0.75;

        rect(i*width/bandsToCheck, height-barHeight, barWidth, barHeight, barWidth/2, barWidth/2, 0, 0);
    } 
}