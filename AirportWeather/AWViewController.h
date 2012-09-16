//
//  AWViewController.h
//  AirportWeather
//
//  Created by Wesley Kim on 9/14/12.
//  Copyright (c) 2012 Wesley Kim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeoNamesWeatherController.h"

@interface AWViewController : UIViewController <WeatherControllerDelegate>
{
    IBOutlet UITextField *searchInput;
    IBOutlet UILabel *airportLocation;
    IBOutlet UILabel *temperature;
    IBOutlet UILabel *observationTime;
    
    GeoNamesWeatherController *weatherController;
    NSString *plistPath;
    NSMutableDictionary *plistDict;
}

- (IBAction)searchForWeather:(id)sender;

- (IBAction)textFieldReturn:(id)sender;
- (IBAction)backgroundTouched:(id)sender;

@end
