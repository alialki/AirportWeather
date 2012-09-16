//
//  GeoNamesWeatherController.h
//  AirportWeather
//
//  Created by Wesley Kim on 9/14/12.
//  Copyright (c) 2012 Wesley Kim. All rights reserved.
//
// @Purpose: Controller to retrieve weather data from GeoNames.
//           Takes in an ICAO code, makes the API call,
//           retrieves JSON data, and triggers callback method
//           to the delegate. In the case that the connection does not work,
//           a nil response is sent back to the delegate.


#import <Foundation/Foundation.h>
#import "SBJson.h"

@protocol WeatherControllerDelegate <NSObject>

/**
 @Purpose: Called when the weather data finished processing.
 */
- (void)didFinishLoadingWeather:(NSMutableDictionary *)weatherData;

@end

@interface GeoNamesWeatherController : NSObject
{
    id<WeatherControllerDelegate> delegate;
    NSMutableData *receivedData;
    SBJsonParser *parser;
} 

/**
 @Purpose: init method with specified delegate
 */
- (id)initWithDelegate:(id<WeatherControllerDelegate>) inDelegate;

/**
 @Purpose: Triggers the API Call to GeoNames for weather data based on airportCode
 */
- (void)retrieveWeatherData:(NSString *)airportCode;

@end
