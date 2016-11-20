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
            [textAnimationView displayMessageViewWithPresentationType:TextAnimationViewPresentWithCenterAnimation withSpinAnimation:YES];
            break;
        case 2:
            [textAnimationView displayMessageViewWithPresentationType:TextAnimationViewPresentWithTopAnimation withSpinAnimation:NO];
            break;
        case 3:
            [textAnimationView displayMessageViewWithPresentationType:TextAnimationViewPresentWithLeftAnimation withSpinAnimation:YES];
            break;
        case 4:
            [textAnimationView displayMessageViewWithPresentationType:TextAnimationViewPresentWithAlpha withSpinAnimation:YES];
            
            break;
        case 5:
            [textAnimationView displayMessageViewWithPresentationType:TextAnimationViewPresentWithBottomAnimation withSpinAnimation:YES];
            break;
        case 6:
            [textAnimationView displayMessageViewWithPresentationType:TextAnimationViewPresentWithRightAnimation withSpinAnimation:NO];
            break;
        case 7:
            [textAnimationView setTextMarquee:YES withDirectionType:TextMarqueeFromRight];
            break;
        case 8:
            [textAnimationView setTextMarquee:YES withDirectionType:TextMarqueeFromLeft];
            break;
        case 9:
            [textAnimationView setTextMarquee:YES withDirectionType:TextMarqueeFromTop];
            break;
        case 10:
            [textAnimationView displayTextWithTypingAnimation:@"It's a sample marquee message."];
            break;
            
        default:
            break;
    }
}
@end
