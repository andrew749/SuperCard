//
//  ViewController.m
//  SuperCard
//
//  Created by Andrew Codispoti on 2014-12-23.
//  Copyright (c) 2014 Andrew Codispoti. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;

@end

@implementation ViewController
- (IBAction)swipe:(UISwipeGestureRecognizer *)sender {self.playingCardView.faceup=!self.playingCardView.faceup;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.playingCardView.suit=@"♥️";
    self.playingCardView.rank=0;
    [self.playingCardView addGestureRecognizer:[[UIPinchGestureRecognizer alloc]initWithTarget:self.playingCardView action:@selector(pinch:)]];
}



@end
