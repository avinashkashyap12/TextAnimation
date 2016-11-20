//
//  ViewController.m
//  TextAnimation
//
//  Created by Avinash Kashyap on 11/20/16.
//  Copyright © 2016 Headerlabs. All rights reserved.
//

#import "ViewController.h"
#import "TextAnimationView.h"

@interface ViewController ()
{
    TextAnimationView *textAnimationView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self addTextAnimationView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
-(void) addTextAnimationView{
    textAnimationView = [[TextAnimationView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 100) withMessage:@"It's a sample marquee message."];
    [self.view addSubview:textAnimationView];
    [textAnimationView displayMessageViewWithPresentationType:TextAnimationViewPresentWithCenterAnimation withSpinAnimation:YES];
}

-(IBAction)buttonAction:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
            //display text with scale transform
            
            [textAnimationView displayMessageViewWithPresentationType:TextAnimationViewPresentWithCenterAnimation withSpinAnimation:YES];
            break;
        case 2:
            
            // display text animation view from top of the screen to declared frame with simple animation.
            [textAnimationView displayMessageViewWithPresentationType:TextAnimationViewPresentWithTopAnimation withSpinAnimation:NO];
            break;
            
        case 3:
            // display text animation view from left of the screen to declared frame with spin animation.
            
            [textAnimationView displayMessageViewWithPresentationType:TextAnimationViewPresentWithLeftAnimation withSpinAnimation:YES];
            break;
        case 4:
            // display text animation view from alpha value animation with spin animation.
            
            [textAnimationView displayMessageViewWithPresentationType:TextAnimationViewPresentWithAlpha withSpinAnimation:YES];
            break;
        case 5:
            // display text animation view from the bottom of the screen to declared frame with spin animation.
            
            [textAnimationView displayMessageViewWithPresentationType:TextAnimationViewPresentWithBottomAnimation withSpinAnimation:YES];
            break;
        case 6:
            // display text animation view from right of the screen to declared frame with out spin animation.
            
            [textAnimationView displayMessageViewWithPresentationType:TextAnimationViewPresentWithRightAnimation withSpinAnimation:NO];
            break;
        case 7:
            // display text animation view with marquee animation from right
            
            [textAnimationView setTextMarquee:YES withDirectionType:TextMarqueeFromRight];
            break;
        case 8:
            // display text animation view with marquee animation from left
            [textAnimationView setTextMarquee:YES withDirectionType:TextMarqueeFromLeft];
            break;
        case 9:
            // display text animation view with marquee animation from Top
            [textAnimationView setTextMarquee:YES withDirectionType:TextMarqueeFromTop];
            break;
        case 10:
            // display text animation view with character animation(one by one character animation)
            
            [textAnimationView displayTextWithTypingAnimation:@"It's a sample marquee message."];
            break;
            
        default:
            break;
    }
}
@end
