//
//  AWViewController.h
//  AirportWeather
//
//  Created by Wesley Kim on 9/14/12.
//  Copyright (c) 2012 Wesley Kim. All rights reserved.
//
// @Purpose: View Controller for the single view of the application.
//           Deals with UI components of the app, and makes calls to
//           the GeoNamesWeatherController to receive weather data.
//           Also implements the WeatherControllerDelegate methods
//           to receive the callback from the GeoNamesWeatherController
//           when all the data has been loaded.

#import <UIKit/UIKit.h>
#import "GeoNamesWeatherController.h"

@interface AWViewController : UIViewController <WeatherControllerDelegate, UITextFieldDelegate>
{
    IBOutlet UITextField *searchInput;
    IBOutlet UILabel *airportLocation;
    IBOutlet UILabel *temperature;
    IBOutlet UILabel *observationTime;
    
    GeoNamesWeatherController *weatherController;
}

/**
 @Purpose: search for weather when:
        1) Application is launched and there's a saved airport
        2) OK is clicked in the keyboard view
        3) Get Weather button is clicked
 */
- (IBAction)searchForWeather:(id)sender;

/**
 @Purpose: Hide keyboard when weather begins searching or background is clicked
 */
- (IBAction)hideKeyboard:(id)sender;

@end
