//
//  MUDetailViewController.m
//  MeetingCheckIn
//
//  Created by Admin on 13-9-4.
//  Copyright (c) 2013年 shjmg. All rights reserved.
//

#import "MUDetailViewController.h"
#import "MUShakeViewController.h"
#import "MUMeeting.h"

@interface MUDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation MUDetailViewController

static NSString *const BaseURLString = @"http://shjmg.cn/api/";

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"签到", @"签到");
    }
    return self;
}
							
#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"切换城市", @"切换城市");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

- (void)getPerticipantList {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", BaseURLString]];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    [httpClient setDefaultHeader:@"Content-Type"
                           value:@"application/x-www-form-urlencoded"];
    
    NSDictionary *params = [NSDictionary dictionaryWithObject:self.userIdText.text forKey:@"uid"];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"attend.php" parameters:params];
    AFHTTPRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request  success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        NSDictionary *result = (NSDictionary *)JSON;
        NSInteger eid = [[result objectForKey:@"eid"] integerValue];

        if (eid != 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"出错"
                                                            message:@"再来一次吧！"
                                                           delegate:nil
                                                  cancelButtonTitle:@"关闭"
                                                  otherButtonTitles:nil];
            [alert show];
            return;
        } else {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"恭喜"
                                                            message:@"签到成功！"
                                                           delegate:nil
                                                  cancelButtonTitle:@"关闭"
                                                  otherButtonTitles:nil];
            [alert show];
            return;
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
                                         {
                                             UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                                                          message:[NSString stringWithFormat:@"%@",error]
                                                                                         delegate:nil
                                                                                cancelButtonTitle:@"OK"
                                                                                otherButtonTitles:nil];
                                             [av show];
                                         }];
    
    [operation start];
    
}

- (IBAction)bingoClicked:(id)sender {
    MUShakeViewController *viewController = [[MUShakeViewController alloc] initWithNibName:@"MUShakeViewController" bundle:[NSBundle mainBundle]];
    viewController.meetingId = ((MUMeeting*)self.detailItem).mid;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)checkInClicked:(id)sender {
    NSString *userId = self.userIdText.text;
    if (![userId isEqualToString:@""]) {
        
        [self getPerticipantList];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入用户确认号" message:@"用户确认编号不能为空" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
        [alert show];
    }
}

@end
