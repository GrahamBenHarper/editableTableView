//
//  ViewController.m
//  TableView Practice
//
//  Created by cisapp-20m on 5/28/15.
//  Copyright (c) 2015 Harper. All rights reserved.
//

#import "ViewController.h"

// global variables because 'murica
int t = 0;
int position = 0;

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
    
    
    cell.textLabel.font = [UIFont fontWithName:@"ArialMT" size:14]; // make stuff pretty
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    if(t==0){
        cell.textLabel.text = [NSString stringWithFormat:@"Type in data values and press 'add data'"]; // if there's no data, help the poor user out
        return cell;
    }
    else{
        cell.textLabel.text = [NSString stringWithFormat:@"(%3.3f,%3.3f)",[self.inputXValues[indexPath.row] doubleValue],[self.inputYValues[indexPath.row] doubleValue]]; // display the ordered pairs (x,y) in the table
        return cell;
    }
}


// what to do if something is selected
- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (t == 0) {
        return nil; // if they selected the "add data" message, don't do anything
    } else {
        return indexPath;
    }
}


- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    position = indexPath.row;
    NSString *message = [[NSString alloc] initWithFormat:
                         @"Would you like to delete (%3.3f,%3.3f)?", [_inputXValues[position] doubleValue], [_inputYValues[position] doubleValue]];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:message delegate:self cancelButtonTitle:@"No" destructiveButtonTitle:@"Yes, I'm sure" otherButtonTitles:nil];

    [actionSheet showInView:self.view];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


// if they make a decision on the action sheet
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex != [actionSheet cancelButtonIndex])
    {
        [self removeData];
    }
}


// method to add data to the arrays
- (IBAction)addData:(id)sender {
    double x = [_xField.text doubleValue]; // Pick the double values from the text fields
    double y = [_yField.text doubleValue];
    
    _inputXValues[t] = [NSNumber numberWithDouble:x]; // Add the values from the fields to our arrays
    _inputYValues[t] = [NSNumber numberWithDouble:y];
    
    [_tableView reloadData]; // refresh the table to show what we added
    NSLog([NSString stringWithFormat:@"Data added. Count: %d",[_inputXValues count]]); // Log how much data we have just for debugging purposes
    t++;
    
    _xField.text = @""; // reset the text fields to make things purdy
    _yField.text = @"";
}


// method to remove data from the arrays
- (IBAction)removeData
{
    [_inputXValues removeObjectAtIndex:position];
    [_inputYValues removeObjectAtIndex:position]; // rip the data out of the middle
    [_tableView reloadData];
    NSLog([NSString stringWithFormat:@"Data removed. Count: %d",[_inputXValues count]]); // Log how much data we have just for debugging purposes
    t--; // keep track of how much data there is still
}
@end
