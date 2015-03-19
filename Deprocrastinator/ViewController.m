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


/**
 *  Setups reusuable Cell
 *
 *  @param tableView taskTableView
 *  @param indexPath indexpath
 *
 *  @return cell
 */
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

#pragma mark - Reorder cells

//Reorder in Array based upon position that it was dragged to.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {

    NSString *taskItem = [self.taskArray objectAtIndex:sourceIndexPath.row];
    [self.taskArray removeObject:taskItem];
    [self.taskArray insertObject:taskItem atIndex:destinationIndexPath.row];
    [self.taskTableView reloadData];
}


# pragma mark - Gesture Handler






@end