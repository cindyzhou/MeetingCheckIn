//
//  MUShakeViewController.m
//  detailpage
//
//  Created by cindyzhou on 9/6/13.
//  Copyright (c) 2013 cindyzhou. All rights reserved.
//

#import "MUShakeViewController.h"
#import<QuartzCore/QuartzCore.h>

@interface MUShakeViewController ()

@end

@implementation MUShakeViewController

static NSString *const BaseURLString = @"http://shjmg.cn/api/";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"抽奖", @"抽奖");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.BillBoardBg.layer.zPosition = 400;
    self.BillBoardWood.layer.zPosition =200;
    self.nameLbl.layer.zPosition = 600;
    self.companyLbl.layer.zPosition = 600;
    self.bingo.layer.zPosition = 800;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)bingoClicked:(id)sender {
    
    isWordFirstShakeFlag = 0;
    isFirstShakeFlag = 0;
    isLandmarkShakeFlag = 0;
    
    [self getLuckyDraw];
    
    [self performSelector:@selector(billboradAnimateFirst) withObject:nil afterDelay:0];
    [self performSelector:@selector(landmarkAnimateFirst) withObject:nil afterDelay:0];
    [self performSelector:@selector(nameAnimation) withObject:nil afterDelay:0.3];
    [self performSelector:@selector(companyAnimation) withObject:nil afterDelay:0.2];
}

- (void)reloadView {
    
    self.nameLbl.text = name;
    self.companyLbl.text = company;
    [self.nameLbl setTransform:CGAffineTransformIdentity];
    [self.companyLbl setTransform:CGAffineTransformIdentity];
}

- (void)getLuckyDraw {
    NSString *weatherUrl = [NSString stringWithFormat:@"%@lottery.php?mid=%d", BaseURLString, self.meetingId];
    NSURL *url = [NSURL URLWithString:weatherUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 2
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSDictionary *result = (NSDictionary *)JSON;
        NSInteger eid = [[result objectForKey:@"eid"] integerValue];
        name = (NSString*)[result objectForKey:@"username"];
        company = (NSString*)[result objectForKey:@"company"];
        if (eid != 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                            message:@"Wrong!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"关闭"
                                                  otherButtonTitles:nil];
            [alert show];
            return;
        }                                                  
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                         message:[NSString stringWithFormat:@"%@",error]
                                                        delegate:nil
                                               cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [av show];
        }];

    [operation start];
    
}


// 商户背景板抖动（往后）
- (void)billboradAnimateFirst {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.05];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(billboradAnimateSecond)];
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.0005; // 透视效果
    transform = CATransform3DRotate(transform,(M_PI/180 * 20), 0, 1, 0);
    [self.BillBoardBg.layer setTransform:transform];
    [UIView commitAnimations];
}

// 商户背景板抖动（从前往后）
- (void)billboradAnimateSecond {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.05];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(billboradAnimateThired)];
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.0005; // 透视效果
    transform = CATransform3DRotate(transform,-(M_PI/180 * 20), 0, 1, 0);
    [self.BillBoardBg.layer setTransform:transform];
    [UIView commitAnimations];
}

// 商户背景板抖动（从后往前）
- (void)billboradAnimateThired {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.05];
    [UIView setAnimationDelegate:self];
    if (isFirstShakeFlag < 7) {
        //抖十次
        [UIView setAnimationDidStopSelector:@selector(billboradAnimateFirst)];
        isFirstShakeFlag ++;
    }
    //    } else {
    //        [UIView setAnimationDidStopSelector:@selector(animateFinished)];
    //    }
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.0005; // 透视效果
    transform = CATransform3DRotate(transform,0, 0, 1, 0);
    [self.BillBoardBg.layer setTransform:transform];
    [UIView commitAnimations];
}

//路标抖1
- (void)landmarkAnimateFirst {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.05];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(landmarkAnimateSecond)];
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.001; // 透视效果
    transform = CATransform3DRotate(transform,(M_PI/180 * 20), 0, 1, 0);
    [self.BillBoardWood.layer setTransform:transform];
    [UIView commitAnimations];
}

//路标抖2
- (void)landmarkAnimateSecond {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.05];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(landmarkAnimateThired)];
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.001; // 透视效果
    transform = CATransform3DRotate(transform,-(M_PI/180 * 20), 0, 1, 0);
    [self.BillBoardWood.layer setTransform:transform];
    
    [UIView commitAnimations];
}

//路标抖3
- (void)landmarkAnimateThired {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.05];
    [UIView setAnimationDelegate:self];
    if (isLandmarkShakeFlag < 6) {
        [UIView setAnimationDidStopSelector:@selector(landmarkAnimateFirst)];
        isLandmarkShakeFlag ++;
    }
    else {
        [UIView setAnimationDidStopSelector:@selector(landmarkAnimationDidStop:context:)];
    }
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.001; // 透视效果
    transform = CATransform3DRotate(transform,0, 0, 1, 0);
    [self.BillBoardWood.layer setTransform:transform];
    [UIView commitAnimations];
    
}


// 商户信息抖动（往后）
- (void)wordAnimateFirst {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.05];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(wordAnimateSecond)];
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.0005; // 透视效果
    transform = CATransform3DRotate(transform,(M_PI/180 * 20), 0, 1, 0);
    [self.nameLbl.layer setTransform:transform];
    //[billBoardView.layer setTransform:transform];
    
    [UIView commitAnimations];
}

// 商户背景板抖动（从前往后）
- (void)wordAnimateSecond {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.05];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(wordAnimateThired)];
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.0005; // 透视效果
    transform = CATransform3DRotate(transform,-(M_PI/180 * 20), 0, 1, 0);
    [self.nameLbl.layer setTransform:transform];

    [UIView commitAnimations];
}

// 商户背景板抖动（从后往前）
- (void)wordAnimateThired {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.05];
    [UIView setAnimationDelegate:self];
    if (isWordFirstShakeFlag < 5) {
        //抖十次
        [UIView setAnimationDidStopSelector:@selector(wordAnimateFirst)];
        isWordFirstShakeFlag ++;
    }
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.0005; // 透视效果
    transform = CATransform3DRotate(transform,0, 0, 1, 0);
    [self.nameLbl.layer setTransform:transform];
    [UIView commitAnimations];
}

//商户名掉落动画
- (void)nameAnimation {
    
    CGPoint center = self.nameLbl.center;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animateFinished)];
    
    //名字
    CATransform3D transform_star = CATransform3DIdentity;
    transform_star.m12 = (M_PI/180 * 10);
    transform_star.m21 = -(M_PI/180 * 10);
    transform_star.m42 = 1400 - center.y;
    transform_star = CATransform3DRotate(transform_star,-(M_PI/180 * 5), 0, 1, 0);
    [self.nameLbl.layer setTransform:transform_star];
    [UIView commitAnimations];
    //nameBtn.center = center;
    
}

- (void)companyAnimation {
    
    CGPoint center = self.companyLbl.center;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    //名字
    CATransform3D transform_star = CATransform3DIdentity;
    transform_star.m12 = -(M_PI/180 * 10);
    transform_star.m21 = +(M_PI/180 * 10);
    transform_star.m42 = 1400 - center.y;
    transform_star = CATransform3DRotate(transform_star,(M_PI/180 * 5), 0, 1, 0);
    [self.companyLbl.layer setTransform:transform_star];
    [UIView commitAnimations];
}

- (void)animateFinished {
    
    /*isAnimationLoading = NO;
    
    if (isTaskLoading) {
        
        self.showLoading = YES;
        return;
    }*/
    
    self.BillBoardBg.layer.transform = CATransform3DIdentity;
    [self reloadView];
    
}


@end
