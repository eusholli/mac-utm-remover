# mac-utm-remover

UTMRemover is a macOS application that automatically removes UTM parameters and LinkedIn-specific tracking parameters (rcm and trackingId) from URLs when they are copied to the clipboard. This app runs in the background and helps keep your links clean and free of tracking parameters.

## Prerequisites

- A Mac running macOS 11 (Big Sur) or later
- Xcode 13 or later (free on the Mac App Store)
- Git (usually pre-installed on macOS, or install from https://git-scm.com/)

## Installation and Setup Guide

### 1. Install Xcode

If you haven't already installed Xcode:
1. Open the App Store on your Mac.
2. Search for "Xcode" and click "Get" or the download icon.
3. Wait for Xcode to download and install (it's a large application, so this may take some time).
4. Once installed, open Xcode to complete the installation of additional components.

### 2. Clone the Repository

1. Open Terminal on your Mac.
2. Navigate to the directory where you want to store the project.
3. Run the following command to clone the repository:
   ```
   git clone https://github.com/eusholli/mac-utm-remover.git
   ```
4. Navigate into the project directory:
   ```
   cd mac-utm-remover
   ```

### 3. Open the Project in Xcode

1. In the mac-utm-remover directory, double-click the `UTMRemover.xcodeproj` file to open it in Xcode.
2. If prompted, click "Trust and Open" to open the project.

### 4. Configure the Project

1. In Xcode's project navigator (left sidebar), click on the project name (UTMRemover).
2. In the center pane, select the "UTMRemover" target under the "TARGETS" section.
3. Go to the "Signing & Capabilities" tab.
4. In the "Team" dropdown, select your personal team or Apple ID.
   - If you haven't added your Apple ID to Xcode yet, click "Add an Account" and follow the prompts.

### 5. Build and Run the App

1. In the top-left corner of Xcode, ensure "UTMRemover" is selected next to the play button.
2. Click the play button or press Cmd + R to build and run the app.
3. You should see a small link icon appear in your Mac's menu bar.

### 6. Export the App

1. In Xcode, go to Product > Archive.
2. Once the archive is created, click "Distribute App".
3. Choose "Copy App" as the distribution method.
4. Follow the prompts, keeping the default settings.
5. Choose a location to save the exported .app file.

### 7. Install the App

1. Locate the exported .app file in Finder.
2. Drag the .app file into your Applications folder.
3. Right-click on the app in the Applications folder and select "Open" to bypass Gatekeeper for the first run.

### 8. (Optional) Set Up Automatic Launch

1. Go to System Preferences > Users & Groups.
2. Select your user account.
3. Click on "Login Items".
4. Click the "+" button and select the UTMRemover app from the Applications folder.

## Usage

Once installed and running, UTMRemover will automatically remove the following tracking parameters from any URL you copy:
- UTM parameters (utm_*)
- LinkedIn tracking parameters (rcm* and trackingId*)

You can verify this by copying a URL with these tracking parameters and then pasting it somewhere - the tracking parameters should be gone.

## Troubleshooting

If you encounter any issues:
- Ensure you have the latest version of Xcode installed.
- Try cleaning the build folder in Xcode (Product > Clean Build Folder) and rebuilding.
- Check that you've correctly set up your signing team in the project settings.
- If you see any code signing errors, try closing and reopening Xcode, or restarting your Mac.

## Contributing

Feel free to fork this project and submit pull requests with improvements or bug fixes. Here are some ideas for contributions:
- Add support for removing other types of tracking parameters (beyond UTM and LinkedIn parameters)
- Implement a whitelist/blacklist feature for specific domains
- Create a preferences window to customize the app's behavior

## License

[MIT License](http://opensource.org/licenses/MIT)

## Acknowledgements

This project was created with the assistance of Claude.ai and the Sonnet 1.5 large language model. Special thanks to the open-source community for inspiration and resources.
