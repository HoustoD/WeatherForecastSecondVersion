//
//  WeatherPerThreeHour.m
//  WeatherForecastSecondVersion
//
//  Created by Анюта on 11.08.18.
//  Copyright © 2018 Roman. All rights reserved.
//

#import "WeatherPerThreeHour.h"

@implementation WeatherPerThreeHour
- (void)setLocationName:(NSString *)locationName
{
    _locationName = locationName;
}
- (void)setTemperature:(float)temperature
{
    _temperature = temperature;
}
- (void)setMinTemperature:(float)minTemperature
{
    _minTemperature = minTemperature;
}
- (void)setPressure:(float)pressure
{
    _pressure = pressure;
}
- (void)setSeaLevel:(float)seaLevel
{
    _seaLevel = seaLevel;
}
- (void)setGroundLevel:(float)groundLevel
{
    _groundLevel = groundLevel;
}
- (void)setHumidity:(float)humidity
{
    _humidity = humidity;
}
- (void)setWetherDescription:(NSString *)wetherDescription
{
    _wetherDescription = wetherDescription;
}
- (void)setClouds:(NSString *)clouds
{
    _clouds = clouds;
}
- (void)setWindSpeed:(float)windSpeed
{
    _windSpeed = windSpeed;
}
- (void)setTime:(NSString*)dateAndTime
{
    if(dateAndTime != nil)
    {
        NSArray *arrayOfDateAndTime = [dateAndTime componentsSeparatedByString:@" "];
        NSArray *arrayOfTime = [arrayOfDateAndTime[1] componentsSeparatedByString:@":"];
        _time = arrayOfTime[0];
    }
    else
    {
        _time = @"";
    }
}
- (void)setDate:(NSString *)dateAndTime
{
    if(dateAndTime != nil)
    {
        NSArray *arrayOfDateAndTime = [dateAndTime componentsSeparatedByString:@" "];
        _date = arrayOfDateAndTime[0];
    }
    else
    {
        _date = @"";
    }
}

@end
