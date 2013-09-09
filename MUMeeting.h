//
//  MUMeeting.h
//  MeetingCheckIn
//
//  Created by Admin on 13-9-4.
//  Copyright (c) 2013年 shjmg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MUMeeting : NSObject
{
    NSInteger _mid;
    NSString *_location;
    NSString *_description;
    NSString *_date;
    NSString *_address;
}
@property (assign, nonatomic) NSInteger mid;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *address;

-(id)initWithMid:(NSInteger)mid location:(NSString*)location
     description:(NSString*)description date:(NSString*)date address:(NSString*)address;
@end
