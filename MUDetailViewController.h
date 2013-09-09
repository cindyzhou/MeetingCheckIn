//
//  MUDetailViewController.h
//  MeetingCheckIn
//
//  Created by Admin on 13-9-4.
//  Copyright (c) 2013年 shjmg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MUDetailViewController : UIViewController <UISplitViewControllerDelegate>
{
    
}
@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UITextField *userIdText;

- (IBAction)bingoClicked:(id)sender;
- (IBAction)checkInClicked:(id)sender;

@end
