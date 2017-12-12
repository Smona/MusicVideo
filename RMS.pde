public class RMS {
  int bands, frames, activeFrame;
  float[][] spectra;
  RMS(int frames, int bands) {
    this.bands = bands;
    this.frames = frames;  // Number of frames to average
    activeFrame = 0;
    spectra = new float[frames][bands];
  }
  
  float getValue(int band) {
    float result = 0;
    for (int i = 0; i < frames; i++) {
      result += pow(spectra[i][band], 2.0);
    }
    return sqrt(result / frames);
  }
  void pushSpectrum(float[] spectrum) {
    spectra[activeFrame] = spectrum;
    activeFrame++;
    if (activeFrame >= frames) {
      activeFrame = 0;
    }
  }
}