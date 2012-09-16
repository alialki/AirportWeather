//
//  AWViewController.m
//  AirportWeather
//
//  Created by Wesley Kim on 9/14/12.
//  Copyright (c) 2012 Wesley Kim. All rights reserved.
//

#import "AWViewController.h"

@interface AWViewController ()

@property (strong, nonatomic) UITextField *searchInput;
@property (strong, nonatomic) UILabel *airportLocation;
@property (strong, nonatomic) UILabel *temperature;
@property (strong, nonatomic) UILabel *observationTime;
@property (strong, nonatomic) GeoNamesWeatherController *weatherController;

@end

@implementation AWViewController

@synthesize searchInput;
@synthesize airportLocation;
@synthesize temperature;
@synthesize observationTime;
@synthesize weatherController;

NSString *sLocationPreferenceKey = @"sLocationPreferenceKey";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //init the weather controller used to get weather data
    weatherController = [[GeoNamesWeatherController alloc] initWithDelegate:self];
    
    //retrieve potential saved location
    NSString *savedLocation = [[NSUserDefaults standardUserDefaults] stringForKey:sLocationPreferenceKey];
    
    if(savedLocation != nil) {
        [[self searchInput] setText:savedLocation];
        [self searchForWeather:nil];
    }
}

- (IBAction)searchForWeather:(id)sender;
{
    //call weather controller to retrieve weather data
    [[self weatherController] retrieveWeatherData:[searchInput text]];
}

-(IBAction)hideKeyboard:(id)sender
{
    [searchInput resignFirstResponder];
}

#pragma mark UITextFieldDelegate Delegates

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [searchInput resignFirstResponder];
    [self searchForWeather:nil];
    return YES;
}

#pragma mark WeatherControllerDelegate Delegates

- (void)didFinishLoadingWeather:(NSMutableDictionary *)weatherData
{
    if(weatherData == nil) {
        NSLog(@"Failed connection");
        [[self airportLocation] setText:@"Failed connection"];
        [[self temperature] setText:@""];
        [[self observationTime] setText:@""];
        return;
    }
    else if([weatherData valueForKey:@"status"] != nil) {
        NSLog(@"Invalid search");
        [[self airportLocation] setText:@"Invalid search"];
        [[self temperature] setText:@""];
        [[self observationTime] setText:@""];
        return;
    }
    
    NSMutableDictionary *weatherObservationDict = [weatherData objectForKey:@"weatherObservation"];
    
    NSString *tempData = [NSString stringWithFormat:@"%@˚C",[weatherObservationDict valueForKey:@"temperature"]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:[weatherObservationDict valueForKey:@"datetime"]];
    [dateFormatter setDateFormat:@"h:mm a, MMM dd, yyyy"];
    
    
    [[self airportLocation] setText:[weatherObservationDict valueForKey:@"stationName"]];
    [[self temperature] setText:tempData];
    [[self observationTime] setText:[dateFormatter stringFromDate:date]];
    
    //save location into preferences, only if it was a valid location
    [[NSUserDefaults standardUserDefaults] setObject:[searchInput text] forKey:sLocationPreferenceKey];
 
}

@end
