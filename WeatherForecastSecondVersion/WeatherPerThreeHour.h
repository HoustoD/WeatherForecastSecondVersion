//
//  WeatherPerThreeHour.h
//  WeatherForecastSecondVersion
//
//  Created by Анюта on 11.08.18.
//  Copyright © 2018 Roman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherPerThreeHour : NSObject
@property(nonatomic,copy)NSString* locationName;
@property(nonatomic)float temperature;
@property(nonatomic)float minTemperature;
@property(nonatomic)float maxTemperature;
@property(nonatomic)float pressure;
@property(nonatomic)float seaLevel;
@property(nonatomic)float groundLevel;
@property(nonatomic)float humidity;
@property(nonatomic,copy)NSString* wetherDescription;
@property(nonatomic,copy)NSString* clouds;
@property(nonatomic)float windSpeed;
@property(nonatomic, copy)NSString* time;
@property(nonatomic,copy)NSString* date;

- (void)setLocationName:(NSString *)locationName;
- (void)setTemperature:(float)temperature;
- (void)setMinTemperature:(float)minTemperature;
- (void)setPressure:(float)pressure;
- (void)setSeaLevel:(float)seaLevel;
- (void)setGroundLevel:(float)groundLevel;
- (void)setHumidity:(float)humidity;
- (void)setWetherDescription:(NSString *)wetherDescription;
- (void)setClouds:(NSString *)clouds;
- (void)setWindSpeed:(float)windSpeed;
- (void)setTime:(NSString*)dateAndTime;
- (void)setDate:(NSString *)dateAndTime;
@end
