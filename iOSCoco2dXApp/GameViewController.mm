//
//  GameViewController.m
//  iOSCoco2dXApp
//
//  Created by Ngoc Tuan Le on 10/10/17.
//  Copyright © 2017 LifeOfCoder. All rights reserved.
//

#import "GameViewController.h"
#import "cocos2d.h"
#import "platform/ios/CCEAGLView-ios.h"
#import "Cocos2dXGameController.h"

@interface GameViewController () <Cocos2dXGameControllerDelegate>

@end

@implementation GameViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    Cocos2dXGameController *gameController = [[Cocos2dXGameController alloc] initWithFrame:self.view.bounds];
    gameController.delegate = self;
    gameController.view.alpha = 0.0f;
    [self.view addSubview:gameController.view];
    
    
    [UIView animateWithDuration:0.3f animations:^{
        gameController.view.alpha = 1.0f;
    }];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}


// For ios6, use supportedInterfaceOrientations & shouldAutorotate instead
#ifdef __IPHONE_6_0
- (NSUInteger) supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}
#endif

- (BOOL) shouldAutorotate {
    return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    
    auto glview = cocos2d::Director::getInstance()->getOpenGLView();
    
    if (glview)
    {
        CCEAGLView *eaglview = (__bridge CCEAGLView *)glview->getEAGLView();
        
        if (eaglview)
        {
            CGSize s = CGSizeMake([eaglview getWidth], [eaglview getHeight]);
            cocos2d::Application::getInstance()->applicationScreenSizeChanged((int) s.width, (int) s.height);
        }
    }
}

//fix not hide status on ios7
- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Cocos2dXGameControllerDelegate

- (void)backToAppFromGameController:(Cocos2dXGameController *)gameController {
    [UIView animateWithDuration:0.3f animations:^{
        gameController.view.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [gameController backToApp];
        [self.view removeFromSuperview];
    }];
}

@end
