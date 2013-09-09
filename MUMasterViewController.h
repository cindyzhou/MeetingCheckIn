//
//  MUMasterViewController.h
//  MeetingCheckIn
//
//  Created by Admin on 13-9-4.
//  Copyright (c) 2013年 shjmg. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MUDetailViewController;

@interface MUMasterViewController : UITableViewController
{
}
@property (strong, nonatomic) MUDetailViewController *detailViewController;
@property (strong, nonatomic) NSMutableArray *meetingList;
@end
