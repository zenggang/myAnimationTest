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
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
    anim.duration = 1;
    
     CATransform3D form = CATransform3DMakeTranslation(100, 150, 0);
     anim.toValue = [NSValue valueWithCATransform3D:form];
    anim.autoreverses=YES;
    [_theView.layer addAnimation:anim forKey:nil];

}


-(IBAction)changeBorder:(id)sender
{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"borderWidth"];
    anim.duration = 1;
    
    
    anim.toValue = [NSValue valueWithNonretainedObject:[NSNumber numberWithFloat:5.0f]];
    
    [_theView.layer addAnimation:anim forKey:nil];
}

+(NSString *) displayName
{
    return @"Base Animation";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
