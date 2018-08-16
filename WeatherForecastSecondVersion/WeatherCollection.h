//
//  WeatherCollection.h
//  WeatherForecastSecondVersion
//
//  Created by Анюта on 11.08.18.
//  Copyright © 2018 Roman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherPerThreeHour.h"
#import "ParceWeatherJSON.h"
#import "GetDate.h"

#pragma once
#include <iostream>
#include <vector>

class WeatherCollection
{
public:
    static WeatherCollection* Instance();
    
    void addCity(NSString* cityName);
    void updateWetherCollection(NSArray* arrayOfCityForUpdate);
    WeatherPerThreeHour* getElementForIndex(long index);
    void removeAll();
    void removeElementForValue(NSString* value);
    //NSMutableArray* findIndexForValue(NSString* value);
    long count();
private:
    WeatherCollection(){};
    WeatherCollection(WeatherCollection const&) = delete;
    WeatherCollection& operator= (WeatherCollection const&) = delete;
    
    static WeatherCollection* m_pInstance;
    std::vector<WeatherPerThreeHour*> m_weatherCollection;
    NSMutableArray* findIndexForValue(NSString* value);
};