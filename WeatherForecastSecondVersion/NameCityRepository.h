//
//  NameCityRepository.h
//  WeatherForecastSecondVersion
//
//  Created by Анюта on 11.08.18.
//  Copyright © 2018 Roman. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma once
#include <iostream>

class NameCityRepository
{
public:
    static NameCityRepository* Instance();
    
    void setFileName(NSString* fileName);
    void addCity(NSString* nameCity);
    void removeCity(NSString* nameCity);
    NSArray* getArrayOfCity();
    long getAmountOfCity();
    BOOL isCityExist(NSString* nameCity);
private:
    NameCityRepository(){};
    NameCityRepository(NameCityRepository const&) = delete;
    NameCityRepository& operator= (NameCityRepository const&) = delete;
    
    static NameCityRepository* m_pInstance;
    NSString* m_pathToFile;
    NSMutableString* m_fileContent;
};