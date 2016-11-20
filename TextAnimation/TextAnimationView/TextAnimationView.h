//
//  TextAnimationView.h
//  TextAnimation
//
//  Created by Avinash Kashyap on 11/20/16.
//  Copyright © 2016 Headerlabs. All rights reserved.
//


#import <UIKit/UIKit.h>
//padding for messages from container
#define Padding 20
//time duaration for dismiss/hide announcement view
#define HideDuration 0.4

typedef NS_ENUM(NSInteger, PresentationType){
    TextAnimationViewPresentWithAlpha,
    TextAnimationViewPresentWithBottomAnimation,
    TextAnimationViewPresentWithTopAnimation,
    TextAnimationViewPresentWithRightAnimation,
    TextAnimationViewPresentWithLeftAnimation,
    TextAnimationViewPresentWithCenterAnimation
};
typedef NS_ENUM(NSInteger, MarqueeDirection){
    TextMarqueeFromLeft,
    TextMarqueeFromRight,
    TextMarqueeFromTop,
    TextMarqueeFromBottom
};

@interface TextAnimationView : UIView<UITextViewDelegate>
{
    UITextView *messageTextView;
    CGRect initialRect;
}
@property (nonatomic, assign) BOOL isMarqueesText;
//create instance
-(instancetype) initWithFrame:(CGRect)frame withMessage:(NSString *)text;
//update message
-(void) setAnnouncementMessage:(NSString *)text;
//Add marquee
-(void) setTextMarquee:(BOOL)isMarqueesText withDirectionType:(MarqueeDirection)direction;
//set announcement message fone size
-(void) setFont:(UIFont *)font;
//set announcement message color
-(void) setMessageColor:(UIColor *)color;
//present view with animation
-(void) displayMessageViewWithPresentationType:(PresentationType)type withSpinAnimation:(BOOL)isSpinAnimation;
//display text with typing animation
-(void) displayTextWithTypingAnimation:(NSString *)text;
@end
