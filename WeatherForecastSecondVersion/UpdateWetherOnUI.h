//
//  UpdateWetherOnUI.h
//  WeatherForecastSecondVersion
//
//  Created by Анюта on 11.08.18.
//  Copyright © 2018 Roman. All rights reserved.
//

#import <Foundation/Foundation.h>
#pragma once
#import "WeatherCollection.h"

#include <iostream>

class UpdateWetherOnUI
{
public:
    static UpdateWetherOnUI* Instance();
    
    
    NSMutableDictionary* getMainDictForUpdatingWetherOnUI(NSString* cityName, NSString* date);
private:
    UpdateWetherOnUI(){};
    UpdateWetherOnUI(UpdateWetherOnUI const&) = delete;
    UpdateWetherOnUI& operator= (UpdateWetherOnUI const&) = delete;
    
    static UpdateWetherOnUI* m_pInstance;
    //NSMutableDictionary* m_dictOfUpdatingWeather;
    NSMutableArray* getArrayOfCountryPerDay(WeatherCollection* weatherCollection, NSString* date, NSString* cityName);
};