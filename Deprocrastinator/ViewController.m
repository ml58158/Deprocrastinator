//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Matt Larkin on 3/16/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITextField *taskTextField;
@property (strong, nonatomic) IBOutlet UITableView *taskTableView;
@property BOOL isEditing;
@property BOOL deletingByClickingOnDeleteButton;
@property NSIndexPath *indexPathToDelete;
@property NSMutableArray *taskArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //Preload objects into Array
    self.taskArray = [NSMutableArray new];

    //Disable editing
    self.editing = false;
}

// Method: OnAddButtonPressed
// Action: Takes data from text field, passes it into array and reloads data.
-(IBAction)onAddButtonPressed:(id)sender
{
    if ([self.taskTextField.text length] > 0) {
        [self.taskArray addObject:self.taskTextField.text];
        [self.taskTableView reloadData];
         self.taskTextField.text = nil;
        [self.taskTextField resignFirstResponder];
}


}
- (IBAction)onEditButtonPressed:(UIButton *)sender {

    // toggle text
    if (!self.isEditing) {
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        [self.taskTableView setEditing:YES animated:YES];
    }
    else {
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        [self.taskTableView setEditing:NO animated:YES];
    }

    self.isEditing = !self.isEditing;
}

//Set editing on Cell
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.taskArray removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
}
}


#pragma marks - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.taskArray count];

}

//Allows deletion of data from table
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

    return YES;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReminderCell"];
    cell.textLabel.text = [self.taskArray objectAtIndex:indexPath.row];

    return cell;
}




# pragma mark - Mark task as complete

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    cell.textLabel.textColor = [UIColor greenColor];


}






# pragma mark - Gesture Handler

- (IBAction)onSwipe:(UISwipeGestureRecognizer *)gestureRecognizer
{
    // find the cell that was tapped
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint location = [gestureRecognizer locationInView:self.taskTableView];
        NSIndexPath *indexPath = [self.taskTableView indexPathForRowAtPoint:location];
        UITableViewCell *cell = [self.taskTableView cellForRowAtIndexPath:indexPath];

        // if the cell exists and it has text, change its text color
        if (cell && [cell.textLabel.text length] > 0) {
            [self setCellTextLabelPriorityColor:cell];

            // save the color in the array
            NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
            [self.todoListBackgroundColors setObject:cell.backgroundColor atIndexedSubscript:cellIndexPath.row];

        }
    }
}




@end