
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

    topics = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"result" ofType:@"plist"]];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @" "; // so that we have some space at the top
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [topics count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    cell.textLabel.text = [[topics objectAtIndex:indexPath.row] valueForKey:@"title"];
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

@end
