PImage songImage;
// PImage songImageBlurred;

String songImagePath = "tainted-love.jpg";
String songTitle = "Tainted Love";
String songArtist = "Soft Cell";

float songDuration;

int bandsToCheck = 80;
int framesToCheck = 1203;
float[][] history = new float[framesToCheck][bandsToCheck];

float maxHistoryValue = 0.0;

void setup() {
    fullScreen();
    background(#000022);

    songImage = loadImage(songImagePath);
    // songImageBlurred = loadImage(songImagePath);
    // songImageBlurred.filter(BLUR, 50);
    imageMode(CENTER);
        
    BufferedReader reader = createReader("../DataFileGenerator/output-tainted-love.txt");

    try {

    for(int i=0; i<framesToCheck; i++) {
        String[] line = split(reader.readLine(), " ");
        
        println(i + " " + line.length);
        for(int j=0; j<bandsToCheck; j++) {
            history[i][j] = float(line[j]);
            maxHistoryValue = max(maxHistoryValue, history[i][j]);
        }
    }
    } catch(Exception e) {
        e.printStackTrace();
    }

    println(maxHistoryValue);
    image(songImage, 796, 476, 600, 600);

    fill(255);
    textSize(52);
    text(songTitle, 1216, 418);
    textSize(32);
    text(songArtist, 1216, 495);
}      

void draw() { 
    noStroke();

    // image(songImageBlurred, width/2, height/2, width * 1.25, width * 1.25 * songImageBlurred.height / songImageBlurred.width);
    fill(#000022);
    rect(0, height - 220, width, 220);
    rect(0, 0, width, 20);

    fill(255);
    rect(0, 0, (float) frameCount / (float) framesToCheck * width, 16, 0, 8, 8, 0);


    for(int i = 0; i < bandsToCheck; i++){
        float barHeight = 70 + 140 * history[frameCount][i] / maxHistoryValue;
        float barWidth = width/bandsToCheck*0.75;

        rect(i*width/bandsToCheck, height-barHeight, barWidth, barHeight, barWidth/2, barWidth/2, 0, 0);
    } 

    if(frameCount + 1 < framesToCheck) {
        saveFrame("tainted-love/######.png");
    } else {
        noLoop();
    }
}