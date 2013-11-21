//
//  radarViewController.m
//  myAnimationTest
//
//  Created by gang zeng on 13-11-19.
//  Copyright (c) 2013年 gang zeng. All rights reserved.
//

#import "radarViewController.h"

@interface radarViewController ()

@property (nonatomic,weak) IBOutlet UIImageView *radarImageView;

@end

@implementation radarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

+(NSString *) displayName
{
    return @"radar Animation";
}


-(IBAction)startRadar:(id)sender
{
    _radarImageView.hidden=NO;
    int direction = 1;
    CGPoint oldAnchorPoint=_radarImageView.layer.anchorPoint;
    _radarImageView.layer.anchorPoint = CGPointMake(0.5, 0.73);
    [_radarImageView.layer setPosition:CGPointMake(_radarImageView.layer.position.x + _radarImageView.layer.bounds.size.width * (_radarImageView.layer.anchorPoint.x - oldAnchorPoint.x), _radarImageView.layer.position.y + _radarImageView.layer.bounds.size.height * (_radarImageView.layer.anchorPoint.y - oldAnchorPoint.y))];
    
    
    
	CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.timingFunction = [CAMediaTimingFunction
                                   functionWithName:kCAMediaTimingFunctionLinear];

	rotationAnimation.toValue = @(2*(M_PI) * direction);
	rotationAnimation.duration = 2.0f;
    rotationAnimation.repeatCount=10086;
    
	[_radarImageView.layer addAnimation:rotationAnimation forKey:@"scanAnimation"];
    
}

-(IBAction)stopScanAnimation:(id)sender
{
    _radarImageView.hidden=YES;
    [_radarImageView.layer removeAnimationForKey:@"scanAnimation"];
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
