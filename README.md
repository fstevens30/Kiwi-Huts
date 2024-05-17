# Kiwi Huts

Kiwi Huts is an open source iOS app designed to inspire adventure to the many Department of Conservation (DOC) Huts available in Aotearoa.

This app is my first attempt at a proper iOS app and is a project to test my skills over the full software development process, from design to deployment. I plan on continuing updating this into the future, at present the scope remains focused as this project is currently being used for a school assignment.

## Status

The project is currently in the final testing stages before I begin the process for uploading to the app store.

## Features

### Searching Huts

Search and refine huts to find something that suits you perfectly.

### Hut details

View details on critical information, such as how many beds are in the hut, what facilities are available and if the uts needs to be pre-booked.

### Saving Huts

Hut can be saved to a list for future reference.

### Completing Huts

Mark huts as complete and track your progress across all huts within all the regions in Aotearoa.

## Usage

You can download the app via Apples `Test Flight` program, please contact me for more details.

To build it from the source code you will need to:

1. Setup
- Aquire a [DOC API Key](https://api.doc.govt.nz/), sign up to the `huts` API.
- Create a Firebase Firestore and download both the `.plist` and `.json` keys.
- Put the `Firebase.json` and `DOC.json` keys into `Backend/Keys` directory.
- Put the `Google-Services.plist` into the `Kiwi Huts` directory.

2. Initiate Firestore
- Within the `Backend` directory run `python3 main.py`.
- Check the Firestore online to see it update (it can take a while to get all the data).

3. Build the Xcode project
- Build for your specific device.

## Future Plans

- Integrate the other DOC APIs (Tracks, campsites).
- Integrate accounts to save progress to the cloud.
- Allow users to comment and upload images of DOC assets, the current images from API are very low-res.

