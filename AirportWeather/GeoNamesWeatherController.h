//
//  GeoNamesWeatherController.h
//  AirportWeather
//
//  Created by Wesley Kim on 9/14/12.
//  Copyright (c) 2012 Wesley Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"

@protocol WeatherControllerDelegate <NSObject>

- (void)didFinishLoadingWeather:(NSMutableDictionary *)weatherData;

@end

@interface GeoNamesWeatherController : NSObject
{
    id<WeatherControllerDelegate> delegate;
    NSMutableData *receivedData;
    SBJsonParser *parser;
} 

- (id)initWithDelegate:(id<WeatherControllerDelegate>) inDelegate;
- (void)retrieveWeatherData:(NSString *)airportCode;

@end
