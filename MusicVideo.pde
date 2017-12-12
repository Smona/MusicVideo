import processing.sound.*;
SoundFile file;
FFT fft;
int bands = 256;
float[] spectrum = new float[bands];
AudioDevice device;
float rWidth;
PImage art;
RMS rms;
float waveY;

void setup() {
  size(1280, 720); // 720p
  frameRate(30);
  device = new AudioDevice(this, 44000, bands);
  file = new SoundFile(this, "hashimoto_mono.wav");
  art = loadImage("logo.png");
  fft = new FFT(this, bands);
  rms = new RMS(10, bands);
  file.play();
  fft.input(file);
  
  waveY = height * 0.45;
}

void draw() {
  background(0);
  image(art, 0, -width / 4, width, width);
  //noFill();
  fill(255);
  stroke(255);
  strokeWeight(4);
  fft.analyze(spectrum);
  rms.pushSpectrum(spectrum);
  int leftX = 20;
  
  //text("Delatropic", leftX, height / 2);
  //text("Hashimoto", leftX, height / 2 + 30);
  
  beginShape();
  float x = leftX, y = waveY;
  curveVertex(x, y);
  curveVertex(x, y);
  for(int i = 0; i < ceil(bands * 0.8); i++){
    rWidth = pow(bands - i, 2.0) / bands / 18;

    x += rWidth;
    curveVertex(x, y - rms.getValue(i)*height*1.5);
  } 
  for (int i = ceil(bands * 0.8); i > 0; i--) {
    rWidth = pow(bands - i, 2.0) / bands / 18;

    x -= rWidth;
    curveVertex(x, y + rms.getValue(i)*height*1.5);
  }
  curveVertex(leftX, y);
  curveVertex(leftX, y);
  endShape();
  saveFrame();
}