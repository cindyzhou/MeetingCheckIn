//
//  MUShakeViewController.h
//  detailpage
//
//  Created by cindyzhou on 9/6/13.
//  Copyright (c) 2013 cindyzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MUShakeViewController : UIViewController
{
    NSInteger isWordFirstShakeFlag;
    NSInteger isFirstShakeFlag;
    NSInteger isLandmarkShakeFlag;
    
    NSString *name;
    NSString *company;
}

@property (strong, nonatomic) IBOutlet UIButton *bingo;
- (IBAction)bingoClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *nameLbl;
@property (strong, nonatomic) IBOutlet UILabel *companyLbl;
@property (strong, nonatomic) IBOutlet UIImageView *BillBoardBg;
@property (strong, nonatomic) IBOutlet UIImageView *BillBoardWood;
@property (assign, nonatomic) NSInteger meetingId;

@end
