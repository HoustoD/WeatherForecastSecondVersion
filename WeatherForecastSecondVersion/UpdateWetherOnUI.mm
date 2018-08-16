//
//  UpdateWetherOnUI.m
//  WeatherForecastSecondVersion
//
//  Created by Анюта on 11.08.18.
//  Copyright © 2018 Roman. All rights reserved.
//

#import "UpdateWetherOnUI.h"

UpdateWetherOnUI* UpdateWetherOnUI::m_pInstance = NULL;

UpdateWetherOnUI* UpdateWetherOnUI::Instance()
{
    if (!m_pInstance)
    {
        m_pInstance = new UpdateWetherOnUI;
    }
    return m_pInstance;
}

NSMutableDictionary* UpdateWetherOnUI::getMainDictForUpdatingWetherOnUI(NSString* cityName, NSString* date)
{
    WeatherCollection* weatherCollection = WeatherCollection::Instance();
    NSMutableArray* arrayOfCountryPerDay = this->getArrayOfCountryPerDay(weatherCollection, date, cityName);
    NSMutableDictionary* mainDictForUpdatingWetherOnUI = [[NSMutableDictionary alloc]init];
    int temp = 0;
    
    for(int i = 0; i< 8; i++)
    {
        NSMutableArray* arrayOfWetherOnThreeHour = [[NSMutableArray alloc]init];
        
        [arrayOfWetherOnThreeHour addObject:[arrayOfCountryPerDay[i]locationName]];
        [arrayOfWetherOnThreeHour addObject:[NSString stringWithFormat:@"%f.2",[arrayOfCountryPerDay[i]temperature]]];
        [arrayOfWetherOnThreeHour addObject:[NSString stringWithFormat:@"%f.2",[arrayOfCountryPerDay[i]minTemperature]]];
        [arrayOfWetherOnThreeHour addObject:[NSString stringWithFormat:@"%f.2",[arrayOfCountryPerDay[i]maxTemperature]]];
        [arrayOfWetherOnThreeHour addObject:[NSString stringWithFormat:@"%f.2",[arrayOfCountryPerDay[i]pressure]]];
        [arrayOfWetherOnThreeHour addObject:[NSString stringWithFormat:@"%f.2",[arrayOfCountryPerDay[i]seaLevel]]];
        [arrayOfWetherOnThreeHour addObject:[NSString stringWithFormat:@"%f.2",[arrayOfCountryPerDay[i]groundLevel]]];
        [arrayOfWetherOnThreeHour addObject:[NSString stringWithFormat:@"%f.2",[arrayOfCountryPerDay[i]humidity]]];
        [arrayOfWetherOnThreeHour addObject:[arrayOfCountryPerDay[i]wetherDescription]];
        [arrayOfWetherOnThreeHour addObject:[arrayOfCountryPerDay[i]clouds]];
        [arrayOfWetherOnThreeHour addObject:[NSString stringWithFormat:@"%f.2",[arrayOfCountryPerDay[i]windSpeed]]];
        [arrayOfWetherOnThreeHour addObject:[arrayOfCountryPerDay[i]time]];
        [arrayOfWetherOnThreeHour addObject:[arrayOfCountryPerDay[i]date]];
        
        [mainDictForUpdatingWetherOnUI setObject:arrayOfWetherOnThreeHour forKey:[NSString stringWithFormat:@"Identifier%i",temp]];
        temp+=3;
    }

    return mainDictForUpdatingWetherOnUI;
}

NSMutableArray* UpdateWetherOnUI::getArrayOfCountryPerDay(WeatherCollection* weatherCollection, NSString* date, NSString* cityName)
{
    NSMutableArray* arrayOfCountryPerDay = [[NSMutableArray alloc]init];
    long amountOfItemsInWetherCollections = weatherCollection->count();
    
    for(int i = 0; i < amountOfItemsInWetherCollections; ++i)
    {
        WeatherPerThreeHour* weatherPerThreeHour = weatherCollection->getElementForIndex(i);
        
        if([date isEqualToString:[weatherPerThreeHour date]] && [cityName isEqualToString:[weatherPerThreeHour locationName]])
        {
            [arrayOfCountryPerDay addObject:weatherPerThreeHour];
        }
    }
    
    long temp = [arrayOfCountryPerDay count] - 8;
    
    if(temp)
    {
        WeatherPerThreeHour* tempWeatherPerThreeHour = [[WeatherPerThreeHour alloc]init];
        for(int i = 0; i < (temp * -1); ++i)
        {
            [tempWeatherPerThreeHour setLocationName:@"!"];
            [tempWeatherPerThreeHour setTemperature:0];
            [tempWeatherPerThreeHour setMinTemperature:0];
            [tempWeatherPerThreeHour setMaxTemperature:0];
            [tempWeatherPerThreeHour setPressure:0];
            [tempWeatherPerThreeHour setGroundLevel:0];
            [tempWeatherPerThreeHour setHumidity:0];
            [tempWeatherPerThreeHour setWetherDescription:@"-"];
            [tempWeatherPerThreeHour setClouds:@"-"];
            [tempWeatherPerThreeHour setWindSpeed:0];
            [tempWeatherPerThreeHour setTime:@"- -:-:-"];
            [tempWeatherPerThreeHour setDate:@"- -:-:-"];
            
            [arrayOfCountryPerDay insertObject:tempWeatherPerThreeHour atIndex:0];
        }
    }
    
    return arrayOfCountryPerDay;
}
