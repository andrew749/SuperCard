//
//  PlayingCardView.h
//  SuperCard
//
//  Created by Andrew Codispoti on 2014-12-23.
//  Copyright (c) 2014 Andrew Codispoti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView
@property (nonatomic) NSUInteger    rank;
@property (strong,nonatomic)NSString *suit;
@property (nonatomic)BOOL faceup;
-(void)pinch:(UIPinchGestureRecognizer *)gesture;
@end
