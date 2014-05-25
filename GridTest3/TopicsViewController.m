
#import "TopicsViewController.h"
#import "DetailViewController.h"
#import "UIImageView+LBBlurredImage.h"

@interface TopicsViewController ()

@end

@implementation TopicsViewController {
    NSArray *topics;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // sub header
    [[UILabel appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil] setTextColor:[UIColor whiteColor]];
    [[UILabel appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil] setFont:
     [UIFont fontWithName:@"Helvetica-Bold" size:14.0]];
    [[UIView appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil] setBackgroundColor:[UIColor darkGrayColor]];

    topics = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"result" ofType:@"plist"]];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Pray Daily";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [topics count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString *day = [[topics objectAtIndex:indexPath.row] valueForKey:@"day"];
    NSString *title = [[topics objectAtIndex:indexPath.row] valueForKey:@"title"];
    cell.textLabel.text = [ NSString stringWithFormat:@"%@. %@", day, title];
    cell.detailTextLabel.text = [[topics objectAtIndex:indexPath.row] valueForKey:@"reference"];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController *detail = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    // get the dictionary (aka map)
    NSDictionary *obj = [topics objectAtIndex:indexPath.row];
    // assign to the detail controller
    detail.map = obj;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
