//
//  MUMeeting.m
//  MeetingCheckIn
//
//  Created by Admin on 13-9-4.
//  Copyright (c) 2013年 shjmg. All rights reserved.
//

#import "MUMeeting.h"

@implementation MUMeeting

@synthesize mid = _mid, location=_location, description=_description, date=_date, address=_address;

-(id)initWithMid:(NSInteger)mid location:(NSString*)location
     description:(NSString*)description date:(NSString*)date address:(NSString*)address {
    self = [super init];
    _mid = mid;
    _location = location;
    _description = description;
    _date = date;
    _address = address;
    return self;
}
@end
