import processing.sound.*;

SoundFile sample;
Waveform waveform;
FFT fft;

int samples = 400;
int bands = 128;
int bandsToCheck = 128;

float[] spectrum = new float[bands];
float[] history = new float[bands];

public void setup()
{
  fullScreen();
  background(255);

  sample = new SoundFile(this, "rumbera.mp3");
  sample.rate(1.09);
  sample.loop();

  waveform = new Waveform(this, samples);
  waveform.input(sample);
  fft = new FFT(this, bands);
  fft.input(sample);


}

public void draw()
{
  background(0);
  stroke(255);
  strokeWeight(3);
  noFill();

  waveform.analyze();
  fft.analyze(spectrum);


  beginShape();
  for(int i = 0; i < samples; i++)
  {
    vertex(
      map(i, 0, samples, 0, width),
      map(waveform.data[i], -1, 1, 0, height)
    );
  }
  endShape();

  noStroke();
  fill(255);
  for(int i = 0; i < bandsToCheck; i++){
      history[i] = max(spectrum[i], history[i]*0.9);

      float barHeight = 70 + (height - 70) * min(1.0, history[i]);
      float barWidth = width/bandsToCheck*0.75;

      rect(i*width/bandsToCheck, height-barHeight, barWidth, barHeight, barWidth/2, barWidth/2, 0, 0);
  } 
}