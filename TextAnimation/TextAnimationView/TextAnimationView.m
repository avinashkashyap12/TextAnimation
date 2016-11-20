//
//  TextAnimationView.m
//  TextAnimation
//
//  Created by Avinash Kashyap on 11/20/16.
//  Copyright © 2016 Headerlabs. All rights reserved.
//

#import "TextAnimationView.h"

@implementation TextAnimationView

-(instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if (self) {
        [self initilizeUIWithMessage:@""];
    }
    return self;
}
-(instancetype) initWithFrame:(CGRect)frame withMessage:(NSString *)text{
    self = [super initWithFrame: frame];
    if (self) {
        [self initilizeUIWithMessage:text];
    }
    return self;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

#pragma mark -
-(void) initilizeUIWithMessage:(NSString *)text{
    initialRect = self.frame;
    //========
    messageTextView = [[UITextView alloc] initWithFrame:CGRectMake(Padding, Padding, self.frame.size.width - Padding*2, self.frame.size.height - Padding*2)];
    messageTextView.delegate = self;
    messageTextView.textAlignment = NSTextAlignmentCenter;
    messageTextView.font = [UIFont systemFontOfSize:15.0];
    messageTextView.editable = NO;
    messageTextView.backgroundColor = [UIColor clearColor];
    [self addSubview:messageTextView];
    //set message
    messageTextView.text = text;
}
#pragma mark - Marquees Text
-(void) setIsMarqueesText:(BOOL)isMarqueesText{
    _isMarqueesText = isMarqueesText;
    if (isMarqueesText == YES) {
        NSLog(@"Update text view frame from left to right");
    }
}
-(void) setTextMarquee:(BOOL)isMarqueesText withDirectionType:(MarqueeDirection)direction{
    if (isMarqueesText == NO) {
        //return id value is no
        return;
    }
    //add animation
    
    //check animation direction
    CGPoint startPoint, endPoint;
    [self removeAnimation];
    switch (direction) {
        case TextMarqueeFromLeft:
            startPoint = CGPointMake(-initialRect.size.width, initialRect.origin.y);
            endPoint = CGPointMake(initialRect.size.width, initialRect.origin.y);
            break;
        case TextMarqueeFromTop:
            startPoint = CGPointMake(initialRect.origin.x, -(initialRect.origin.y+initialRect.size.height));
            endPoint = CGPointMake(initialRect.origin.x, [UIScreen mainScreen].bounds.size.height+initialRect.size.height);
            break;
        case TextMarqueeFromBottom:
            startPoint = CGPointMake(initialRect.origin.x, [UIScreen mainScreen].bounds.size.height+initialRect.size.height);
            endPoint = CGPointMake(initialRect.origin.x, -initialRect.size.height);
            break;
        default:
            startPoint = CGPointMake(initialRect.size.width, initialRect.origin.y);
            endPoint = CGPointMake(-initialRect.size.width, initialRect.origin.y);
            break;
    }
    [self addBasicAnimationWithStartPosition:startPoint andEndValue:endPoint withAnimationKey:@"position" andTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
}
#pragma mark Add animation
-(void) addBasicAnimationWithStartPosition:(CGPoint)startPoint andEndValue:(CGPoint)endPoint withAnimationKey:(NSString *)key andTimingFunction:(CAMediaTimingFunction*)timingFunction{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:key];
    animation.duration = 12;
    animation.fromValue = [NSValue valueWithCGPoint:startPoint];
    animation.toValue = [NSValue valueWithCGPoint:endPoint];
    animation.repeatCount = MAXFLOAT;
    if (timingFunction != nil) {
        animation.timingFunction = timingFunction;
    }
    // self.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
    [self.layer addAnimation:animation forKey:key];
    NSLog(@"self .layer position = %@",NSStringFromCGPoint(self.layer.position));
    NSLog(@"self .layer anchor point = %@",NSStringFromCGPoint(self.layer.anchorPoint));
    
    self.layer.position = endPoint;
    self.layer.anchorPoint = CGPointZero;
}
-(void) removeAnimation{
    [self.layer removeAnimationForKey:@"position"];
    self.layer.position = CGPointMake(initialRect.origin.x + initialRect.size.width/2, initialRect.origin.y + initialRect.size.height/2);
    self.layer.anchorPoint = CGPointMake(0.5, 0.5);
}
#pragma mark - Announcement Message
-(void) setAnnouncementMessage:(NSString *)text{
    messageTextView.text = text;
}
-(void) setFont:(UIFont *)font{
    messageTextView.font = font;
}
-(void) setMessageColor:(UIColor *)color{
    messageTextView.textColor = color;
}
#pragma mark - Animation Presentation
-(void) displayMessageViewWithPresentationType:(PresentationType)type withSpinAnimation:(BOOL)isSpinAnimation{
    [self removeAnimation];
    switch (type) {
        case TextAnimationViewPresentWithAlpha:
            [self presentViewWithAlphaSpinTransition:isSpinAnimation];
            break;
        case TextAnimationViewPresentWithTopAnimation:
            [self presentViewWithTopSpinAnimation:isSpinAnimation];
            break;
        case TextAnimationViewPresentWithLeftAnimation:
            [self presentViewWithLeftSpinAnimation:isSpinAnimation];
            break;
        case TextAnimationViewPresentWithRightAnimation:
            [self presentViewWithRightSpinAnimation:isSpinAnimation];
            break;
        case TextAnimationViewPresentWithBottomAnimation:
            [self presentViewWithBottomSpinAnimation:isSpinAnimation];
            break;
        case TextAnimationViewPresentWithCenterAnimation:
            [self presentViewWithCenterSpinAnimation:isSpinAnimation];
            break;
            
        default:
            break;
    }
}
#pragma mark -
-(void) presentViewWithAlphaSpinTransition:(BOOL)value{
    self.alpha = 0.0;
    if (value == YES) {
        [UIView animateWithDuration:0.6 delay:0.4 usingSpringWithDamping:0.6 initialSpringVelocity:0.3 options:0 animations:^{
            self.alpha = 1.0;
        } completion:^(BOOL finished) {
            
        }];
    }
    else{
        [UIView animateWithDuration:0.5 animations:^{
            self.alpha = 1.0;
        }];
    }
    
}
-(void) presentViewWithTopSpinAnimation:(BOOL)value{
    //get old frame
    CGRect oldRect = self.frame;
    //get screen size
    //CGSize screeneSize = [UIScreen mainScreen].bounds.size;
    //set new frame for start animation
    self.frame = CGRectMake(oldRect.origin.x, -(oldRect.origin.y + oldRect.size.height), oldRect.size.width, oldRect.size.height);
    
    if (value) {
        [UIView animateWithDuration:0.6 delay:0.4 usingSpringWithDamping:0.6 initialSpringVelocity:0.3 options:0 animations:^{
            self.frame = oldRect;
        } completion:^(BOOL finished) {
            self.frame = oldRect;
        }];
    }
    else{
        [UIView animateWithDuration:0.5 animations:^{
            self.frame = oldRect;
        }];
    }
}
-(void) presentViewWithLeftSpinAnimation:(BOOL)value{
    //get old frame
    CGRect oldRect = self.frame;
    //get screen size
    //CGSize screeneSize = [UIScreen mainScreen].bounds.size;
    //set new frame for start animation
    self.frame = CGRectMake(-(oldRect.origin.x+oldRect.size.width), oldRect.origin.y, oldRect.size.width, oldRect.size.height);
    if (value) {
        [UIView animateWithDuration:0.6 delay:0.4 usingSpringWithDamping:0.6 initialSpringVelocity:0.3 options:0 animations:^{
            self.frame = oldRect;
        } completion:^(BOOL finished) {
            
        }];
    }
    else{
        [UIView animateWithDuration:0.5 animations:^{
            self.frame = oldRect;
        }];
    }
}
-(void) presentViewWithRightSpinAnimation:(BOOL)value{
    //get old frame
    CGRect oldRect = self.frame;
    //get screen size
    CGSize screeneSize = [UIScreen mainScreen].bounds.size;
    //set new frame for start animation
    self.frame = CGRectMake(screeneSize.width, oldRect.origin.y, oldRect.size.width, oldRect.size.height);
    if (value) {
        [UIView animateWithDuration:0.6 delay:0.4 usingSpringWithDamping:0.6 initialSpringVelocity:0.3 options:0 animations:^{
            self.frame = oldRect;
        } completion:^(BOOL finished) {
            
        }];
    }
    else{
        [UIView animateWithDuration:0.5 animations:^{
            self.frame = oldRect;
        }];
    }
}
-(void) presentViewWithBottomSpinAnimation:(BOOL)value{
    //get old frame
    CGRect oldRect = self.frame;
    //get screen size
    CGSize screeneSize = [UIScreen mainScreen].bounds.size;
    //set new frame for start animation
    self.frame = CGRectMake(oldRect.origin.x, screeneSize.height, oldRect.size.width, oldRect.size.height);
    if (value) {
        [UIView animateWithDuration:0.6 delay:0.4 usingSpringWithDamping:0.6 initialSpringVelocity:0.3 options:0 animations:^{
            self.frame = oldRect;
        } completion:^(BOOL finished) {
            
        }];
    }
    else{
        [UIView animateWithDuration:0.5 animations:^{
            self.frame = oldRect;
        }];
    }
}
-(void) presentViewWithCenterSpinAnimation:(BOOL)value{
    
    self.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    if (value) {
        [UIView animateWithDuration:0.6 delay:0.4 usingSpringWithDamping:0.6 initialSpringVelocity:0.3 options:0 animations:^{
            self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {
            
        }];
    }
    else{
        [UIView animateWithDuration:0.5 animations:^{
            self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }
}
#pragma mark -
-(void) displayTextWithTypingAnimation:(NSString *)text{
    if (text.length<1) {
        text = messageTextView.text;
    }
    NSInteger len = text.length;
    CGFloat delay = len/5.23;
    delay = delay/100;
    messageTextView.text = @"";
    //
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for(int i= 0; i<text.length; i++){
            dispatch_async(dispatch_get_main_queue(), ^{
                [messageTextView setText:[NSString stringWithFormat:@"%@%C", messageTextView.text, [text characterAtIndex:i]]];
            });
            [NSThread sleepForTimeInterval:delay];
        }//end for loop
    });
}

@end
