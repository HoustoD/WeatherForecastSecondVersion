//
//  GetDate.h
//  WeatherForecastSecondVersion
//
//  Created by Анюта on 11.08.18.
//  Copyright © 2018 Roman. All rights reserved.
//

#pragma once
#import <Foundation/Foundation.h>
#include <iostream>

class GetDate
{
public:
    static GetDate* Instance();
    
    NSString* getCurentDate();
    NSString* checkDate(int year, int month, int day);
    NSString* plas_x_nambersToDateDay(int x);
private:
    GetDate(){};
    GetDate(GetDate const&) = delete;
    GetDate& operator= (GetDate const&) = delete;
    
    static GetDate* m_pInstance;
    NSString* m_temp;
};
