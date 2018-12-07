//
//  ViewController.m
//  WeatherForecastSecondVersion
//
//  Created by Анюта on 11.08.18.
//  Copyright © 2018 Roman. All rights reserved.
//

#import "ViewController.h"
#import "UpdateWetherOnUI.h"
#import "NameCityRepository.h"

@interface ViewController ()
@property(nonatomic, copy)NSString* curentCity;

@property (weak) IBOutlet NSButton *firstDayPushButton;
@property (weak) IBOutlet NSButton *secondDayPushButton;
@property (weak) IBOutlet NSButton *thirdDayPushButton;
@property (weak) IBOutlet NSButton *fourthDayPushButton;
@property (weak) IBOutlet NSButton *fifthDayPushButton;
@property (weak) IBOutlet NSTextField *selectCityTextField;
@property (weak) IBOutlet NSTextField *warningMassegLabel;

@property (weak) IBOutlet NSButton *londonCheckBox;
@property (weak) IBOutlet NSButton *odessaCheckBox;
@property (weak) IBOutlet NSButton *polenCheckBox;
@property (weak) IBOutlet NSButton *volgaCheckBox;
@property (weak) IBOutlet NSButton *berlinCheckBox;
@property (weak) IBOutlet NSButton *dresdenCheckBox;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    GetDate* date = GetDate::Instance();
    NameCityRepository* cityRepository = NameCityRepository::Instance();
    cityRepository->setFileName(@"file1.txt");
    
    
    long amountOfCity = cityRepository->getAmountOfCity();
    
    if(amountOfCity)
    {
        [NSTimer scheduledTimerWithTimeInterval: 0.01
                                         target: self
                                       selector: @selector(handleTimer:)
                                       userInfo: nil
                                        repeats: NO];
        
    }
    [NSTimer scheduledTimerWithTimeInterval: 3600
                                     target: self
                                   selector: @selector(handleTimer:)
                                   userInfo: nil
                                    repeats: YES];
    
    self.firstDayPushButton.stringValue = date->getCurentDate();
    self.secondDayPushButton.title = date->plas_x_nambersToDateDay(1);
    self.thirdDayPushButton.title = date->plas_x_nambersToDateDay(2);
    self.fourthDayPushButton.title = date->plas_x_nambersToDateDay(3);
    self.fifthDayPushButton.title = date->plas_x_nambersToDateDay(4);
}

- (void)setRepresentedObject:(id)representedObject
{
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

-(void)handleTimer:(NSTimer *)timer
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
    GetDate* date = GetDate::Instance();
    NameCityRepository* cityRepository = NameCityRepository::Instance();
    NSArray* arrayOfCity = cityRepository->getArrayOfCity();
    WeatherCollection* weatherCollection = WeatherCollection::Instance();
    UpdateWetherOnUI* updateWetherOnUI = UpdateWetherOnUI::Instance();
    long amountOfCity = cityRepository->getAmountOfCity();
    
    weatherCollection->updateWetherCollection(arrayOfCity);
    mainDictForUpdatingWetherOnUI = updateWetherOnUI->getMainDictForUpdatingWetherOnUI(arrayOfCity[0], date->getCurentDate());
        
        if(mainDictForUpdatingWetherOnUI)
        {
            [tableView reloadData];
        }
    
    
    for(long i = 0; i < amountOfCity; ++i)
    {
        if([arrayOfCity[i] isEqualToString:self.londonCheckBox.title])
            self.londonCheckBox.state = 1;
        else if([arrayOfCity[i] isEqualToString:self.odessaCheckBox.title])
            self.odessaCheckBox.state = 1;
        else if([arrayOfCity[i] isEqualToString:self.polenCheckBox.title])
            self.polenCheckBox.state = 1;
        else if([arrayOfCity[i] isEqualToString:self.volgaCheckBox.title])
            self.volgaCheckBox.state = 1;
        else if([arrayOfCity[i] isEqualToString:self.berlinCheckBox.title])
            self.berlinCheckBox.state = 1;
        else if([arrayOfCity[i] isEqualToString:self.dresdenCheckBox.title])
            self.dresdenCheckBox.state = 1;
    }
});
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return 13;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSString* identifierColumn = [tableColumn identifier];
    
    if([identifierColumn isEqualToString:@"Identifier0"])
    {
        return [[mainDictForUpdatingWetherOnUI objectForKey:@"Identifier0"]objectAtIndex:row];
    }
    else if([identifierColumn isEqualToString:@"Identifier3"])
    {
        return [[mainDictForUpdatingWetherOnUI objectForKey:@"Identifier3"]objectAtIndex:row];
    }
    else if([identifierColumn isEqualToString:@"Identifier6"])
    {
        return [[mainDictForUpdatingWetherOnUI objectForKey:@"Identifier6"]objectAtIndex:row];
    }
    else if([identifierColumn isEqualToString:@"Identifier9"])
    {
        return [[mainDictForUpdatingWetherOnUI objectForKey:@"Identifier9"]objectAtIndex:row];
    }
    else if([identifierColumn isEqualToString:@"Identifier12"])
    {
        return [[mainDictForUpdatingWetherOnUI objectForKey:@"Identifier12"]objectAtIndex:row];
    }
    else if([identifierColumn isEqualToString:@"Identifier15"])
    {
        return [[mainDictForUpdatingWetherOnUI objectForKey:@"Identifier15"]objectAtIndex:row];
    }
    else if([identifierColumn isEqualToString:@"Identifier18"])
    {
        return [[mainDictForUpdatingWetherOnUI objectForKey:@"Identifier18"]objectAtIndex:row];
    }
    else if([identifierColumn isEqualToString:@"Identifier21"])
    {
        return [[mainDictForUpdatingWetherOnUI objectForKey:@"Identifier21"]objectAtIndex:row];
    }
    
    return nil;
}
- (IBAction)exitPushButton:(id)sender {
    [NSApp terminate:nil];
}
- (IBAction)checkBoxPressed:(id)sender
{
    NSString* chousenCity = [sender title];
    NameCityRepository* cityRepository = NameCityRepository::Instance();
    WeatherCollection* weatherCollection = WeatherCollection::Instance();
    UpdateWetherOnUI* updateWetherOnUI = UpdateWetherOnUI::Instance();
    GetDate* date = GetDate::Instance();
    
    if(cityRepository->isCityExist(chousenCity))
    {
        cityRepository->removeCity(chousenCity);
        weatherCollection->removeElementForValue(chousenCity);
        self.curentCity = cityRepository->getArrayOfCity()[0];
        [sender setState:0];
    
        if([self.curentCity isEqualToString: @""])
        {
            mainDictForUpdatingWetherOnUI = [[NSMutableDictionary alloc]init];
        }
        else
        {
           mainDictForUpdatingWetherOnUI = updateWetherOnUI->getMainDictForUpdatingWetherOnUI(self.curentCity, date->getCurentDate());
        }
        [tableView reloadData];
    }
    else
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
            cityRepository->addCity(chousenCity);
            weatherCollection->addCity(chousenCity);
            [sender setState:1];
            
            if(cityRepository->getAmountOfCity() == 1)
            {
                self.curentCity = chousenCity;
                mainDictForUpdatingWetherOnUI = updateWetherOnUI->getMainDictForUpdatingWetherOnUI(self.curentCity, date->getCurentDate());
                [tableView reloadData];
            }
        });
    }
}
- (IBAction)selectButtonPressed:(id)sender
{
    NSString* selectedCity = self.selectCityTextField.stringValue;
    NameCityRepository* cityRepository = NameCityRepository::Instance();
    UpdateWetherOnUI* updateWetherOnUI = UpdateWetherOnUI::Instance();
    GetDate* date = GetDate::Instance();
    
    if(cityRepository->isCityExist(selectedCity))
    {
        self.curentCity = selectedCity;
        mainDictForUpdatingWetherOnUI = updateWetherOnUI->getMainDictForUpdatingWetherOnUI(self.curentCity, date->getCurentDate());
        [tableView reloadData];
        self.warningMassegLabel.stringValue = @"";
    }
    else
    {
        self.warningMassegLabel.stringValue = @"Tis city is not selected!";
    }
}
- (IBAction)dateButtonPressed:(id)sender
{
    UpdateWetherOnUI* updateWetherOnUI = UpdateWetherOnUI::Instance();
    NSString* selectedDate = [sender title];
    
    mainDictForUpdatingWetherOnUI = updateWetherOnUI->getMainDictForUpdatingWetherOnUI(self.curentCity, selectedDate);
    [tableView reloadData];
}
@end
