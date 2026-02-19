# Flutter Camera App

A simple Flutter application that works with the device camera.  
The app allows users to take a photo and save it to the device storage.

## Features

- Open device camera
- Capture a photo
- Handle file paths correctly

## Packages Used

- `camera` — to access and control the device camera
- `path_provider` — to get the correct storage directory
- `path` — to build file paths properly

## How It Works

1. The app gets the list of available cameras on the device.
2. It initializes the selected camera.
3. When the user presses the capture button, a photo is taken.
4. The photo is saved inside the app’s directory.
5. The file path is created using `path_provider` and `path`.
