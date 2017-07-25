# Spectral-Analysis-GUI
User-interface for analysis and annotation of multitaper spectrograms optimized for research in the Brown/Purdon lab, the Neural Statistics Laboratory at MIT and MGH.



## Getting Started
1. Download all files from the repository in a zip file
2. Unzip folder
3. Open the .m file named Spectrogram_Extraction
4. Run the file
5. Voila!

## Features
### File Upload
- File must be a .mat file
- You must know the structure of your file
  - What is the name of the variable in the structure that contains the EEG data? (data, eegdata, etc.)
  - How many channels are in the file? (1, 5, etc.)
### Parameters
- This is a pop-up window that allows one to alter the parameters of the spectrogram at any point in time
- Will pop up after a file is uploaded
- Each time, make sure that you specify the data file name and which channel you want if these are not the defaults of 'data' and a single channel file
- Closing the window saves and applies the parameter changes
### Color Spectrum
- This is a pop-up window that allows one to alter the color spectrum used for the spectrogram
- Will pop up after a file is uploaded
- Closing the window saves and applies the color spectrum changes
### Power Contents
- This is a pop-up window that allows one to look at the power contents of a spectrogram
- Specify the start time (t0) and the end time (t1)
- Delta Button
  - Gives power in frequency band from 1 to 4 Hz
  - Percent power calculated from taking power in the band over the power found from 0 to 40 Hz
- Slow Button
  - Gives power in frequency band from 0 to 1 Hz
  - Percent power calculated from taking power in the band over the power found from 0 to 40 Hz
- Alpha Button
  - Gives power in frequency band from 7.5 to 12.5 Hz
  - Percent power calculated from taking power in the band over the power found from 0 to 40 Hz
- Beta Button
  - Gives power in frequency band from 12.5 to 30 Hz
  - Percent power calculated from taking power in the band over the power found from 0 to 40 Hz
- Total
  - Gives power in frequency band from 0 to 40 Hz
  - Percent power calculated from taking power in the band over the power found from 0 to 40 Hz
### Find Peaks
- Utilizes P=findpeaks(x,y,SlopeThreshold,AmpThreshold,smoothwidth,peakgroup,smoothtype) from Tom O'Haver to find particular peaks in 
  - A set of fast customizable functions for locating and measuring the peaks in noisy time-series signals. Adjustable parameters allow discrimination of "real" signal peaks from noise and background. Determines the position, height, and width of each peak by least-squares curve-fitting. It can find and count over 10,000 peaks per second, and find and measure 1800 peaks per second, in very large signals. Includes two interactive versions, one with mouse-controlled sliders and one with keyboard control, for adjusting the peak finding criteria in real-time. Self-contained demos show how it works. See http://terpconnect.umd.edu/~toh/spectrum/PeakFindingandMeasurement.htm for details. Information from https://www.mathworks.com/matlabcentral/fileexchange/11755-peak-finding-and-measurement?focused=7217956&tab=function
### Get Spectrum
- Once the button is pressed, a 't' will pop up. Use this t to pick a time point on the spectrogram.
- After selecting the point, the spectrum will open with respect to that time-point on the upper-left graph
### Previous
### Next
### Play
### Stop
### Time Series Length
### Current
### Start Scoring Session

## Acknowledgements

## 

