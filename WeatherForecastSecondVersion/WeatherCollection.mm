//
//  WeatherCollection.m
//  WeatherForecastSecondVersion
//
//  Created by Анюта on 11.08.18.
//  Copyright © 2018 Roman. All rights reserved.
//

#import "WeatherCollection.h"

WeatherCollection* WeatherCollection::m_pInstance = NULL;

WeatherCollection* WeatherCollection::Instance()
{
    if (!m_pInstance)
        m_pInstance = new WeatherCollection;
    
    return m_pInstance;
}

void WeatherCollection::addCity(NSString* cityName)
{
    NSString *urlString = [NSString stringWithFormat:@"https://api.openweathermap.org/data/2.5/forecast?q=%@,us&mode=json&units=metric&APPID=5eea5c798e9fc61eee671c907ea27281",cityName];
    ParceWeatherJSON* parceWeatherJSON = ParceWeatherJSON::Instance();
    
    parceWeatherJSON->takeDataFromUrlString(urlString);
    this->m_weatherCollection.push_back([WeatherPerThreeHour new]);
    for(int i = 0; i < 37; ++i)
    {
        WeatherPerThreeHour* weatherPerThreeHour = [[WeatherPerThreeHour alloc]init];
        
        NSString* locationName = parceWeatherJSON->getSelectParametrsOfMainCloudsWindWithHourIndex(i, @"city", @"name");
        float temperature = [parceWeatherJSON->getSelectParametrsOfMainCloudsWindWithHourIndex(i, @"main", @"temp") floatValue];
        float minTemperature = [parceWeatherJSON->getSelectParametrsOfMainCloudsWindWithHourIndex(i, @"main", @"temp_min") floatValue];
        float maxTemperature = [parceWeatherJSON->getSelectParametrsOfMainCloudsWindWithHourIndex(i, @"main", @"temp_max") floatValue];
        float pressure = [parceWeatherJSON->getSelectParametrsOfMainCloudsWindWithHourIndex(i, @"main", @"pressure") floatValue];
        float groundLevel = [parceWeatherJSON->getSelectParametrsOfMainCloudsWindWithHourIndex(i, @"main", @"grnd_level") floatValue];
        float humidity = [parceWeatherJSON->getSelectParametrsOfMainCloudsWindWithHourIndex(i, @"main", @"humidity") floatValue];
        NSString* wetherDescription = parceWeatherJSON->getSelectParametrsOfMainCloudsWindWithHourIndex(i, @"weather", @"description");
        NSString* clouds = parceWeatherJSON->getSelectParametrsOfMainCloudsWindWithHourIndex(i, @"clouds", @"all");
        float windSpeed = [parceWeatherJSON->getSelectParametrsOfMainCloudsWindWithHourIndex(i, @"wind", @"speed") floatValue];
        NSString* time = parceWeatherJSON->getSelectParametrsOfMainCloudsWindWithHourIndex(i, @"dt_txt", @"dt_txt");
        NSString* date = parceWeatherJSON->getSelectParametrsOfMainCloudsWindWithHourIndex(i, @"dt_txt", @"dt_txt");
        
        [weatherPerThreeHour setLocationName:locationName];
        [weatherPerThreeHour setTemperature:temperature];
        [weatherPerThreeHour setMinTemperature:minTemperature];
        [weatherPerThreeHour setMaxTemperature:maxTemperature];
        [weatherPerThreeHour setPressure:pressure];
        [weatherPerThreeHour setGroundLevel:groundLevel];
        [weatherPerThreeHour setHumidity:humidity];
        [weatherPerThreeHour setWetherDescription:wetherDescription];
        [weatherPerThreeHour setClouds:clouds];
        [weatherPerThreeHour setWindSpeed:windSpeed];
        [weatherPerThreeHour setTime:time];
        [weatherPerThreeHour setDate:date];
        
        this->m_weatherCollection.push_back(weatherPerThreeHour);
    }
}
void WeatherCollection::updateWetherCollection(NSArray* arrayOfCityForUpdate)
{
    this->removeAll();
    for(int i = 0; i < [arrayOfCityForUpdate count]-1; ++i)
    {
        this->addCity(arrayOfCityForUpdate[i]);
    }
}
WeatherPerThreeHour* WeatherCollection::getElementForIndex(long index)
{
    if(index > 0  && index < this->m_weatherCollection.size())
    {
        return this->m_weatherCollection[index];
    }
    return nullptr;
}
void WeatherCollection::removeAll()
{
    this->m_weatherCollection.clear();
}
NSMutableArray* WeatherCollection::findIndexForValue(NSString* value)
{
    NSMutableArray* array = [[NSMutableArray alloc]init];
    for(int i = 0; i < this->count(); ++i)
    {
        if([value isEqualToString:[this->getElementForIndex(i) locationName]])
        {
            [array addObject:[NSString stringWithFormat:@"%i",i]];
        }
    }
    return array;
}
void WeatherCollection::removeElementForValue(NSString* value)
{
    NSMutableArray* array = this->findIndexForValue(value);
    long startIndex = [array[0] integerValue];
    long lasIndex = [array[[array count]-1] integerValue];
    
    this->m_weatherCollection.erase(this->m_weatherCollection.begin() + startIndex,this->m_weatherCollection.begin() + lasIndex);
}
long WeatherCollection::count()
{
    return this->m_weatherCollection.size();
}
