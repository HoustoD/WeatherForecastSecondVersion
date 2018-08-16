//
//  ParceWeatherJSON.h
//  WeatherForecastSecondVersion
//
//  Created by Анюта on 11.08.18.
//  Copyright © 2018 Roman. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma once
#include <iostream>

class ParceWeatherJSON
{
public:
    static ParceWeatherJSON* Instance();
    
    void takeDataFromUrlString(NSString* urlString);
    NSString* getSelectParametrsOfMainCloudsWindWithHourIndex(int hourIndex, NSString* key, NSString* selectorParametr);
private:
    ParceWeatherJSON(){};
    ParceWeatherJSON(ParceWeatherJSON const&) = delete;
    ParceWeatherJSON& operator= (ParceWeatherJSON const&) = delete;
    
    static ParceWeatherJSON* m_pInstance;
    NSData* m_data;
};