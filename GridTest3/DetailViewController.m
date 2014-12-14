#import "DetailViewController.h"
#import "UIImageView+LBBlurredImage.h"

#import <AVFoundation/AVFoundation.h>

@interface DetailViewController ()

@end

@implementation DetailViewController {
    NSArray *topics;
    AVAudioPlayer *audioPlayer;
    BOOL isPlaying;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // background
    UIImage *background = [UIImage imageNamed:@"bg2"];
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:background];
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [backgroundImageView setImageToBlur:background blurRadius:50 completionBlock:nil]; // blur image
    [self.view addSubview:backgroundImageView];
    [self.view sendSubviewToBack:backgroundImageView];

    // today's day
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];
    NSInteger dayNumber = [components day];
    
    // content
    topics = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"result" ofType:@"plist"]];
    NSDictionary *obj = [topics objectAtIndex:(dayNumber - 1)];
    if (self.map == nil) { // if loaded from home screen
        self.map = obj;
    }
    self.topicLabel.text = [self.map valueForKey:@"title"];
    self.verse.text = [self.map valueForKey:@"reference"];
    self.passage.text = [self.map valueForKey:@"scripture"];
    self.passage.editable = NO;
    self.prayer.text = [self.map valueForKey:@"prayer"];
    self.prayer.editable = NO;
    self.dayLabel.text = [NSString stringWithFormat:@"Day %@", [self.map valueForKey:@"day"]];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (IBAction)sound:(id)sender {
    NSLog(@"button was clicked, day %@.mp3",[self.map valueForKey:@"day"]);
    NSString *day = [self.map valueForKey:@"day"];
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:day ofType:@"mp3"]];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    if (isPlaying) {
        [audioPlayer stop];
        isPlaying = NO;
    } else {
        [audioPlayer play];
        isPlaying = YES;
    }

}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:(BOOL)animated];    // Call the super class implementation.
    // Usually calling super class implementation is done before self class implementation, but it's up to your application.
    if (isPlaying)
        [audioPlayer stop];
}

@end
