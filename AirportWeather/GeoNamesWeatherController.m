//
//  GeoNamesWeatherController.m
//  AirportWeather
//
//  Created by Wesley Kim on 9/14/12.
//  Copyright (c) 2012 Wesley Kim. All rights reserved.
//

#import "GeoNamesWeatherController.h"

@interface GeoNamesWeatherController()

@property (strong, nonatomic) id<WeatherControllerDelegate> delegate;
@property (strong, nonatomic) NSMutableData *receivedData;

@end

@implementation GeoNamesWeatherController

@synthesize delegate;
@synthesize receivedData;

static NSString *sGeoNamesPrefixURL = @"http://ws.geonames.org/weatherIcaoJSON?ICAO=";

- (id)initWithDelegate:(id<WeatherControllerDelegate>) inDelegate
{
    self = [super init];
    if (self) {
        delegate = inDelegate;
        parser = [[SBJsonParser alloc] init];
    }
    return self;
}

- (void)retrieveWeatherData:(NSString *)airportCode
{
    NSString *sGeoNamesURL = [NSString stringWithFormat:@"%@%@",
                                sGeoNamesPrefixURL,
                                airportCode];
    
    // Create the request.
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:sGeoNamesURL]
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                          timeoutInterval:60.0];
    
    // create the connection with the request
    // and start loading the data
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if (theConnection) {
        // Create the NSMutableData to hold the received data.
        // receivedData is an instance variable declared elsewhere.
        receivedData = [NSMutableData data];
    } else {
        // Inform the user that the connection failed.
        [delegate didFinishLoadingWeather:nil];
    }
}

#pragma mark NSURLConnection Delegates
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    [receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Parse resulting data and call delegate with results
    NSMutableDictionary *weatherDict = [parser objectWithData:receivedData];
    [[self delegate] didFinishLoadingWeather:weatherDict];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}
@end
