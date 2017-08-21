### PENDING UPDATES
- Ability to upload data files that aren't structs (this bug originated from the lack of consideration for files other than SED and eeganes files)
- Error Catching

# Spectral-Analysis-GUI
User-interface for analysis and annotation of multitaper spectrograms optimized for research in the Brown/Purdon lab, the Neural Statistics Laboratory at MIT and MGH.

<img src="https://user-images.githubusercontent.com/20092998/28597691-4f75d728-716d-11e7-8094-5594eb820fbb.png" width="90%"></img> 

## Getting Started
1. Fork repository!!
2. Create your own local repository
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
- This is a pop-up window that allows one to alter the parameters of the spectrogram at any point in time; after a file is uploaded, this window will automatically appear with default values
  - The parameters are those commonly used with multitaper spectral analysis
  - Helpful Reference for Multitaper Analysis
  - A Review of Multitaper Spectral Analysis by Behtash Babadi and Emery Brown which can be found at https://www.ncbi.nlm.nih.gov/pubmed/24759284
    - ABSTRACT: Nonparametric spectral estimation is a widely used technique in many applications ranging from radar and seismic data analysis to electroencephalography (EEG) and speech processing. Among the techniques that are used to estimate the spectral representation of a system based on finite observations, multitaper spectral estimation has many important optimality properties, but is not as widely used as it possibly could be. We give a brief overview of the standard nonparametric spectral estimation theory and the multitaper spectral estimation, and give two examples from EEG analyses of anesthesia and sleep
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
- Click the check box to trigger this capability
- Utilizes P = findpeaks(x, y, SlopeThreshold, AmpThreshold, smoothwidth, peakgroup, smoothtype) from Tom O'Haver to find particular peaks in the spectrum
  - A set of fast customizable functions for locating and measuring the peaks in noisy time-series signals. Adjustable parameters allow discrimination of "real" signal peaks from noise and background. Determines the position, height, and width of each peak by least-squares curve-fitting. It can find and count over 10,000 peaks per second, and find and measure 1800 peaks per second, in very large signals. Includes two interactive versions, one with mouse-controlled sliders and one with keyboard control, for adjusting the peak finding criteria in real-time. Self-contained demos show how it works. See http://terpconnect.umd.edu/~toh/spectrum/PeakFindingandMeasurement.htm for details. Information from https://www.mathworks.com/matlabcentral/fileexchange/11755-peak-finding-and-measurement?focused=7217956&tab=function
### Get Spectrum
- Once the button is pressed, a 't' will pop up. Use this t to pick a time point on the spectrogram.
- After selecting the point, the spectrum will open with respect to that time-point on the upper-left graph and a time series will pop up on the upper-right graph
  - This upper-right time series with be of the length specified in the time series length edit window
  - Keep in mind that the spectrum pertains to the time window from [the click point time you specified] to [the click point time + the winLength parameter specified]; the spectrum is not calculated from the entire shown time-series
### Previous
- Iterate backward [winStep] seconds
### Next
- Iterate forward [winStep] seconds
### Play
- Once the button is pressed, a 't' will pop up. Use this t to pick a time point on the spectrogram
- From this selected time-point, a progression of the changing spectrogram and the corresponding time series will be shown until you click the stop button
### Stop
- Stops the progression cued by the play button
### Time Series Length
- Specifies the portrayed time length of the time-series data
### Current
- Shows the current file the user is observing
### Start Scoring Session
- Allows for the user to annotate the spectrogram with pertinent comments at specified time points
- The user is prompted to enter their name, purpose, the date, and the desired file name

## Acknowledgements
Thanks to the NSRL for helping me complete this project! Special thanks to Dr. Emery Brown, Devika Kishnan, and Dr. Patrick Purdon (pictured below in order).

<img src="https://user-images.githubusercontent.com/20092998/28598292-b0fa06ec-7170-11e7-8f55-50748a03efce.png" width="30%"></img> <img src="https://user-images.githubusercontent.com/20092998/28598300-b6a6722e-7170-11e7-8761-2b9589fe8139.png" width="30%"></img> <img src="https://user-images.githubusercontent.com/20092998/28598304-bb1cb8b8-7170-11e7-9b2d-18ee2df92b6b.png" width="30%"></img> 

## Outsourced Code
- peakFinder: version 4.0 (428 KB) by Tom O'Haver
- scrollzoompan: by Michael Prerau at MIT's NSRL
- quickbandpass: by Michael Prerau at MIT's NSRL
