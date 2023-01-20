import processing.sound.*;

FFT fft;
SoundFile file;

String songName = "tainted-love";

String songFilePath = "../Example2/" + songName + ".mp3";

int bands = 128;
int bandsToCheck = 80;
float[] spectrum = new float[bands];
float[] history = new float[bands];

PrintWriter output;

void setup() {
    size(300, 300);
    fft = new FFT(this, bands);
    
    file = new SoundFile(this, songFilePath);
    file.play();

    fft.input(file);

    output = createWriter("output-" + songName + ".txt");
}

void draw() {
    background(0);
    fft.analyze(spectrum);

    for(int i = 0; i < bandsToCheck; i++){
        history[i] = max(spectrum[i], history[i]*0.9);

        output.print(history[i] + " ");
    } 
    output.print("\n");

    println(file.percent());

    if(!file.isPlaying()) noLoop();
}
