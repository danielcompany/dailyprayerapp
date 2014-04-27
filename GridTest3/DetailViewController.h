#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *topicLabel;

@property (weak, nonatomic) IBOutlet UILabel *verse;

@property (weak, nonatomic) IBOutlet UITextView *passage;
@property (weak, nonatomic) IBOutlet UITextView *prayer;

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (strong, nonatomic) NSString *topic;
@property (strong, nonatomic) NSDictionary *map;
@end
