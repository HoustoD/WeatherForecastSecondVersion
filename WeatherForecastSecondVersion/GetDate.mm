//
//  GetDate.m
//  WeatherForecastSecondVersion
//
//  Created by Анюта on 11.08.18.
//  Copyright © 2018 Roman. All rights reserved.
//

#import "GetDate.h"

GetDate* GetDate::m_pInstance = NULL;

GetDate* GetDate::Instance()
{
    if (!m_pInstance)
    {
        m_pInstance = new GetDate;
    }
    return m_pInstance;
}

NSString* GetDate::checkDate(int year, int month, int day)
{
    NSString* dday = @"";
    NSString* mmonth = @"";
    
    
    if(year < 0){
        year *= -1;
    }
    else if(month < 0){
        month *= -1;
    }
    if(day < 0){
        day *= -1;
    }


    
    if((day - 10) < 0)
    {
        dday = [NSString stringWithFormat:@"0%i",day];
    }
    else
    {
        dday = [NSString stringWithFormat:@"%i",day];
    }
    
    if((month - 10) < 0)
    {
        mmonth = [NSString stringWithFormat:@"0%i",month];
    }
    else
    {
        mmonth = [NSString stringWithFormat:@"%i",month];
    }
    
    return [NSString stringWithFormat:@"%i-%@-%@",year,mmonth, dday];
}
NSString* GetDate::getCurentDate()
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    
    return this->checkDate([components year], [components month], [components day]) ;
}

NSString* GetDate::plas_x_nambersToDateDay(int x)
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    
    return this->checkDate([components year], [components month], [components day] + x);
}