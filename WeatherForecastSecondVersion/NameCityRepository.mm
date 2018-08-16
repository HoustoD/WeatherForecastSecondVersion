//
//  NameCityRepository.m
//  WeatherForecastSecondVersion
//
//  Created by Анюта on 11.08.18.
//  Copyright © 2018 Roman. All rights reserved.
//

#import "NameCityRepository.h"

NameCityRepository* NameCityRepository::m_pInstance = NULL;

NameCityRepository* NameCityRepository::Instance()
{
    if (!m_pInstance)
    {
        m_pInstance = new NameCityRepository;
    }
    return m_pInstance;
}

void NameCityRepository::setFileName(NSString* fileName)
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pathToFile = [NSString stringWithFormat:@"%@/%@",
                          documentsDirectory, fileName];
    this->m_pathToFile = pathToFile;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:this->m_pathToFile]){
        [fileManager createFileAtPath:this->m_pathToFile contents:nil attributes:nil];
    }
    
    NSMutableString* fileContents = [NSMutableString stringWithContentsOfFile:this->m_pathToFile encoding:NSUTF8StringEncoding error:nil];
    this->m_fileContent = fileContents;
}
void NameCityRepository::addCity(NSString* nameCity)
{    
    nameCity = [nameCity stringByAppendingString:@"\n"];
    
    [this->m_fileContent appendString:nameCity];
    [this->m_fileContent writeToFile:this->m_pathToFile atomically:YES encoding:NSUTF8StringEncoding error:nil];
}
void NameCityRepository::removeCity(NSString* nameCity)
{
    if(this->m_fileContent)
    {
        NSMutableArray* tmpArray = [[NSMutableArray alloc]init];
        tmpArray = [this->m_fileContent componentsSeparatedByCharactersInSet:
                   [NSCharacterSet newlineCharacterSet]];
        long arrayOfCityCount = this->getAmountOfCity();
        
        this->m_fileContent = [[NSMutableString alloc]init];
        for(int i = 0; i < arrayOfCityCount; ++i)
        {
            if(![tmpArray[i] isEqualToString:nameCity])
            {
                [this->m_fileContent appendString:tmpArray[i]];
                [this->m_fileContent appendString:@"\n"];
            }
        }
        [this->m_fileContent writeToFile:this->m_pathToFile atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
}
NSArray* NameCityRepository::getArrayOfCity()
{
    NSMutableArray* tmpArray = [[NSMutableArray alloc]init];
    tmpArray = [this->m_fileContent componentsSeparatedByCharactersInSet:
                [NSCharacterSet newlineCharacterSet]];
    
    return tmpArray;
}
long NameCityRepository::getAmountOfCity()
{
    NSMutableArray* tmpArray = [[NSMutableArray alloc]init];
    tmpArray = [this->m_fileContent componentsSeparatedByCharactersInSet:
                [NSCharacterSet newlineCharacterSet]];
    
    return [tmpArray count] - 1;
}
BOOL NameCityRepository::isCityExist(NSString* nameCity)
{
    return [this->m_fileContent containsString:nameCity];
}
