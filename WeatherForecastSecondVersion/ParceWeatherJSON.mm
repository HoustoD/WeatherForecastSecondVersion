//
//  ParceWeatherJSON.m
//  WeatherForecastSecondVersion
//
//  Created by Анюта on 11.08.18.
//  Copyright © 2018 Roman. All rights reserved.
//

#import "ParceWeatherJSON.h"

ParceWeatherJSON* ParceWeatherJSON::m_pInstance = NULL;

ParceWeatherJSON* ParceWeatherJSON::Instance()
{
    if (!m_pInstance)
    {
        m_pInstance = new ParceWeatherJSON;
    }
    return m_pInstance;
}

void ParceWeatherJSON::takeDataFromUrlString(NSString* urlString)
{
    NSError* error;
    NSURLResponse* response;
    
    this->m_data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] returningResponse:&response error:&error];
}
NSString* ParceWeatherJSON::getSelectParametrsOfMainCloudsWindWithHourIndex(int hourIndex, NSString* key, NSString* selectorParametr)
{
    if(this->m_data)
    {
        NSError* error;
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:this->m_data options:kNilOptions error:&error];
        NSArray* listOfItemForHourIndexArray = [jsonDict objectForKey:@"list"];
        
        NSDictionary *elementForKey = [NSDictionary new];
        NSDictionary *arrayItemForHourIndex = listOfItemForHourIndexArray[hourIndex];
        
        if([key isEqualToString:@"weather"])
        {
            NSArray* arrayForWeather = [arrayItemForHourIndex objectForKey:@"weather"];
            NSDictionary * elementOfarrayForWeather = arrayForWeather[0];
            elementForKey = [elementOfarrayForWeather objectForKey:@"description"];
        }
        else if([key isEqualToString:@"dt_txt"])
        {
            elementForKey = [arrayItemForHourIndex objectForKey:@"dt_txt"];
            
        }
        else if([key isEqualToString:@"city"])
        {
            elementForKey = [jsonDict objectForKey:key];
            elementForKey = [elementForKey objectForKey:selectorParametr];
        }
        else
        {
            NSDictionary *forSelectedParametr = [arrayItemForHourIndex objectForKey:key];
            elementForKey = [forSelectedParametr objectForKey:selectorParametr];
        }
        
        NSString* stringForKey = [NSString stringWithFormat:@"%@",elementForKey];
        return stringForKey;
    }
    return @"Uncorrect data (check your URL reqest)";
}