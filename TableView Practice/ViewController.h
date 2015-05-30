//
//  ViewController.h
//  TableView Practice
//
//  Created by cisapp-20m on 5/28/15.
//  Copyright (c) 2015 Harper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *xField;
@property (weak, nonatomic) IBOutlet UITextField *yField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)addData:(id)sender;
- (IBAction)linReg:(id)sender;

@end

