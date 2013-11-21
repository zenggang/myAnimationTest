//
//  baseAnimationViewController.m
//  myAnimationTest
//
//  Created by gang zeng on 13-11-18.
//  Copyright (c) 2013年 gang zeng. All rights reserved.
//

#import "baseAnimationViewController.h"

@interface baseAnimationViewController ()

@property (nonatomic,weak) IBOutlet UIView *theView;

@end

@implementation baseAnimationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.title=[baseAnimationViewController displayName];
    
    
}
- (void)adjustWidthBy:(CGFloat)value {
	;
}

#pragma mark actions

-(IBAction)changeColorAction:(id)sender
{
    CATransition *animation = [CATransition animation];
    
    [animation setDuration:1.0f];
    CGColorRef redColor = [UIColor redColor].CGColor, blueColor = [UIColor blueColor].CGColor;
	_theView.layer.backgroundColor = (_theView.layer.backgroundColor == redColor) ? blueColor : redColor;
    [_theView.layer addAnimation:animation forKey:nil];
    

}

-(IBAction)changeSizeAction:(id)sender
{
    
    CABasicAnimation *anmation=[CABasicAnimation animationWithKeyPath:@"bounds.size"];
    [anmation setDuration:0.5f];
    anmation.toValue=[NSValue valueWithCGSize:CGSizeMake(_theView.layer.bounds.size.width+100, _theView.layer.bounds.size.height)];
    //保持动画后状态
    anmation.removedOnCompletion = NO;
    anmation.fillMode = kCAFillModeForwards;
    [_theView.layer addAnimation:anmation forKey:nil];
}


#define ORGINAL_POSITION CGPointMake(160, 250)
#define MOVED_POSITON CGPointMake(200, 290)

-(IBAction)changePosition:(id)sender
{
//    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
//    anim.duration = 1;
//    
//     CATransform3D form = CATransform3DMakeTranslation(100, 150, 0);
//     anim.toValue = [NSValue valueWithCATransform3D:form];
//    anim.autoreverses=YES;
//    [_theView.layer addAnimation:anim forKey:nil];

    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CABasicAnimation *anmation=[CABasicAnimation animationWithKeyPath:@"bounds.size"];
        [anmation setDuration:1.0f];
        anmation.toValue=[NSValue valueWithCGSize:CGSizeMake(_theView.layer.bounds.size.width+100, _theView.layer.bounds.size.height)];
        anmation.autoreverses=YES;
        _theView.center=CGPointMake(_theView.center.x, _theView.center.y+50);
        
        [_theView.layer addAnimation:anmation forKey:nil];
    } completion:^(BOOL finished) {
        
    }];
}


-(IBAction)changeBorder:(id)sender
{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"borderWidth"];
    anim.duration = 1;
    
    
    anim.toValue = [NSValue valueWithNonretainedObject:[NSNumber numberWithFloat:5.0f]];
    
    [_theView.layer addAnimation:anim forKey:nil];
}


-(IBAction)otherAnimation:(id)sender
{
    //[baseAnimationViewController animationFlipFromLeft:_theView];
    [self circleAnimate:_theView];
}

+(NSString *) displayName
{
    return @"Base Animation";
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#define CONST_animation_time 0.5
#define CONST_enlarge_proportion 1.5

- (void) circleAnimate:(UIView *)view

{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [UIView beginAnimations:nil context:context];
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    [UIView setAnimationDuration:CONST_animation_time];
    
    //[view setCenter:UpPointOfView(view)];
    
    
    CABasicAnimation *scalingAnimation = (CABasicAnimation *)[view.layer animationForKey:@"scaling"];
    if (!scalingAnimation)
        
    {
        scalingAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        
        scalingAnimation.repeatCount=1;
        scalingAnimation.duration=CONST_animation_time;
        scalingAnimation.autoreverses=NO;
        scalingAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        
        scalingAnimation.fromValue=[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
        
        scalingAnimation.toValue=[NSValue valueWithCATransform3D:CATransform3DMakeScale(CONST_enlarge_proportion, CONST_enlarge_proportion, 1.0)];
        
    }
    
    
    [view.layer addAnimation:scalingAnimation forKey:@"scaling"];
    
    view.layer.transform = CATransform3DMakeScale(CONST_enlarge_proportion, CONST_enlarge_proportion, 1.0);
    
    [UIView commitAnimations];
    
}


+ (void)animationFlipFromLeft:(UIView *)view

{
    [UIView beginAnimations:nil context:NULL];
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    [UIView setAnimationDuration:0.35f];
    
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:view cache:NO];
    
    [UIView commitAnimations];
    
    
    
}




//
+(void)animationRotateAndScaleEffects:(UIView *)view

{
    CGPoint oldAnchorPoint=view.layer.anchorPoint;
    view.layer.anchorPoint=CGPointMake(0.5, 1);
    [view.layer setPosition:CGPointMake(view.layer.position.x + view.layer.bounds.size.width * (view.layer.anchorPoint.x - oldAnchorPoint.x), view.layer.position.y + view.layer.bounds.size.height * (view.layer.anchorPoint.y - oldAnchorPoint.y))];
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    rotationAnimation.toValue = [NSNumber numberWithFloat:(2 * M_PI) * 2];
    
    rotationAnimation.duration = 1.35f;
    
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    scaleAnimation.toValue = [NSNumber numberWithFloat:0.0];
    
    scaleAnimation.duration = 1.35f;
    
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    
    animationGroup.duration = 1.35f;
    
    //animationGroup.autoreverses = YES;
    
    animationGroup.repeatCount = 1;
    
    animationGroup.animations =[NSArray arrayWithObjects:rotationAnimation, scaleAnimation, nil];
    
    animationGroup.removedOnCompletion=NO;
    [animationGroup setFillMode:kCAFillModeForwards];
    
    [view.layer addAnimation:animationGroup forKey:@"animationGroup"];
    

}
@end
