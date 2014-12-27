//
//  PlayingCardView.m
//  SuperCard
//
//  Created by Andrew Codispoti on 2014-12-23.
//  Copyright (c) 2014 Andrew Codispoti. All rights reserved.
//

#import "PlayingCardView.h"
@interface PlayingCardView()
@property (nonatomic) CGFloat faceCardScaleFactor;
@end
@implementation PlayingCardView
@synthesize faceCardScaleFactor=_faceCardScaleFactor;
#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.90;
-(CGFloat) faceCardScaleFactor{
    if (!_faceCardScaleFactor)_faceCardScaleFactor=DEFAULT_FACE_CARD_SCALE_FACTOR;
    return _faceCardScaleFactor;
}
-(void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor  {
    _faceCardScaleFactor=faceCardScaleFactor;
    [self setNeedsDisplay];
}
-(void)setSuit:(NSString *)suit{
    _suit=suit;
    [self setNeedsDisplay];
}
-(void )setRank:(NSUInteger)rank{
    _rank=rank;
    [self setNeedsDisplay];
    
}
-(void )   setFaceup:(BOOL)faceup{
    _faceup=faceup;
    [self setNeedsDisplay  ];
}
#define CORNER_FRONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0
-(CGFloat)cornerScaleFactor{return self.bounds.size.height/CORNER_FRONT_STANDARD_HEIGHT;}
-(CGFloat)cornerRadius{return CORNER_RADIUS*[self cornerScaleFactor];}
-(CGFloat)cornerOffset{return [self cornerRadius]/3.0;}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath *roundedRect=[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius: [self cornerRadius] ];
    [roundedRect addClip];[[UIColor whiteColor]setFill];
    UIRectFill(self.bounds);
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    if(self.faceup){
    UIImage *faceImage=[UIImage imageNamed:[NSString stringWithFormat:@"%@%@",[self rankAsString],self.suit]];
    if(faceImage){
        CGRect imageRect=CGRectInset(self.bounds, self.bounds.size.width*(1.0-self.faceCardScaleFactor), self.bounds.size.height*(1.0-self.faceCardScaleFactor));
    }
    else [self drawPips];
        [self drawCorners];

    }else{
        [[UIImage imageNamed:@"cardback"] drawInRect:self.bounds ];
    }
}
-(void)pinch:(UIPinchGestureRecognizer *)gesture{
    if((gesture.state==UIGestureRecognizerStateChanged)||(gesture.state==UIGestureRecognizerStateEnded)){
        self.faceCardScaleFactor*=gesture.scale;
        gesture.scale=1.0;
    }
}
-(void) drawPips{
    
}
-(void)drawCorners{
    NSMutableParagraphStyle *paragraphStyle=[[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment=NSTextAlignmentCenter;
    UIFont *cornerFont=[UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    cornerFont=[cornerFont fontWithSize:cornerFont.pointSize*[self  cornerScaleFactor]];
    NSAttributedString *cornerText= [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",[self rankAsString],self.suit] attributes:@{NSFontAttributeName:cornerFont,NSParagraphStyleAttributeName   : paragraphStyle                                                                                           }];
    CGRect textBounds;
    textBounds  .origin=CGPointMake([self cornerOffset],[self cornerOffset]);
    textBounds.size=[cornerText size];
    [cornerText drawInRect:textBounds];
    CGContextRef context=UIGraphicsGetCurrentContext() ;
    CGContextTranslateCTM(context, self.bounds.size.width,self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
    [cornerText drawInRect:textBounds];
    
}

-(NSString *)rankAsString{
    return @[@"A"][self.rank];
}
#pragma mark - Initialization
-(void) setup{
    self.backgroundColor =nil;
    self.opaque=NO;
    self.contentMode=UIViewContentModeRedraw;
}
-(void)awakeFromNib{
    [self setup];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
@end
