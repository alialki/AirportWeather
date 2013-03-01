AirportWeather
=============
Purpose: Retrieve weather at airports based on ICAO codes. Interview project for Flurry, Fall 2012.

To run
------
1. Clone project.
2. Launch in XCode (AirportWeather.xcodeproj).
3. Build and run (mostly tested on iPhone 4S with iOS6).

Design Overview
---------------
- The app consists of one view and a couple controllers. Majority of the code is in the AWViewController and GeoNamesWeatherController.
- The AWViewController handles all the UI logic, and interacts with the GeoNamesWeatherController to retrieve all necessary weather information.
- The GeoNamesWeatherController takes in a ICAO code and calls the GeoNames API service.
- Results are returned in JSON format, and are parsed using the json-framework library built for json parsing on iOS.
- The most recent successful search is saved in the user's preferences and loaded whenever the user comes back to the app

Design Rationale
----------------
- I wanted to keep the data source (GeoNames) separate from the UI/ViewController so that other potential sources can be plugged in.
- The UI itself is very minimal, I mainly built the project to showcase how the back-end controllers are handled.
- I decided just to display the key information: Airport name, temperature, and time when the temperature was taken.

Error Handling
--------------
- If there are every connectivity issues, the app will let the user know that weather cannot be retrieved at the time.
- Similarly, if an invalid code is entered, the app will let the user know it's not a valid code. On re-entry or relaunch, the app will then load the most recent legitimate location searched for.

Thanks for reading!

- Wesley

Last Modified: 9-16-2012
