//
//  MUMasterViewController.m
//  MeetingCheckIn
//
//  Created by Admin on 13-9-4.
//  Copyright (c) 2013年 shjmg. All rights reserved.
//

#import "MUMasterViewController.h"
#import "MUMeeting.h"
#import "MUDetailViewController.h"


@interface MUMasterViewController () {
    NSMutableArray *_objects;
}
@end

static NSString *const BaseURLString = @"http://shjmg.cn/api/";

@implementation MUMasterViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"城市", @"城市");
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(520.0, 600.0);
        self.meetingList = [[NSMutableArray alloc] initWithCapacity:2];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    [self getMeetingList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getMeetingList {
    
    if (self.meetingList && [self.meetingList count]>0) {
        self.meetingList = nil;
    }
    
    NSString *weatherUrl = [NSString stringWithFormat:@"%@mlist.php?", BaseURLString];
    NSURL *url = [NSURL URLWithString:weatherUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
     {
         NSDictionary *result = (NSDictionary *)JSON;
         NSInteger eid = [[result objectForKey:@"eid"] integerValue];
         NSArray *list = (NSArray*)[result objectForKey:@"s"];
         [self saveMeetingLists:list];
         if (eid != 0) {
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                         message:@"Wrong!"
                                                        delegate:nil
                                               cancelButtonTitle:@"关闭"
                                               otherButtonTitles:nil];
             [alert show];
             return;
         }
         [self.tableView reloadData];
     } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
     {
         UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                      message:[NSString stringWithFormat:@"%@",error]
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
         [av show];
     }];
    
    // 5
    [operation start];
    
}

- (void)saveMeetingLists:(NSArray*) list {
    for (int i=0; i < [list count]; i++) {
        NSDictionary *meetting = [list objectAtIndex:i];
        MUMeeting *newMeeting = [[MUMeeting alloc] initWithMid:[[meetting objectForKey:@"mid"] integerValue] location:[meetting objectForKey:@"location"]
    description:[meetting objectForKey:@"description"] date:[meetting objectForKey:@"date"] address:[meetting objectForKey:@"date"]];
        [self.meetingList addObject:newMeeting];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.meetingList.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }


    MUMeeting *object = self.meetingList[indexPath.row];
    cell.textLabel.text = [object location];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MUMeeting *object = self.meetingList[indexPath.row];
    self.detailViewController.detailItem = object;
}

@end
