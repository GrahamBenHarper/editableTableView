//
//  ViewController.m
//  TableView Practice
//
//  Created by cisapp-20m on 5/28/15.
//  Copyright (c) 2015 Harper. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray* inputXValues;
@property (strong, nonatomic) NSMutableArray* inputYValues;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.inputXValues = [@[@0.] mutableCopy];
    self.inputYValues = [@[@0.] mutableCopy];
    // Initialize the x and y lists to have 0 in them
    
    UITableView *tableView = (id)[self.view viewWithTag:1];
    UIEdgeInsets contentInset = tableView.contentInset;
    contentInset.top = 20;
    [tableView setContentInset:contentInset];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.inputXValues count]; // we want as many rows as we have data for
}


// method called by the table (mandatory stuff to build it)
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:SimpleTableIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"(%3.2f,%3.2f)",[self.inputXValues[indexPath.row] doubleValue],[self.inputYValues[indexPath.row] doubleValue]]; // display the ordered pairs (x,y) in the table
    return cell;
}

- (IBAction)addData:(id)sender {
    double x = [_xField.text doubleValue]; // Pick the double values from the text fields
    double y = [_yField.text doubleValue];
    
    [_inputXValues addObject:[NSNumber numberWithDouble:x]]; // Add the values from the fields to our arrays
    [_inputYValues addObject:[NSNumber numberWithDouble:y]];
    
    [_tableView reloadData]; // refresh the table to show what we added
    NSLog([NSString stringWithFormat:@"%d",[_inputXValues count]]); // Log how much data we have just for debugging purposes
}
@end
