//
//  CardsViewController.m
//  YTinder
//
//  Created by Tejas Lagvankar on 2/19/15.
//  Copyright (c) 2015 Yahoo!. All rights reserved.
//

#import "CardsViewController.h"
#import "ProfileViewController.h"

@interface CardsViewController () <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>
@property (weak, nonatomic) IBOutlet UIImageView *cardImageView;
@property (nonatomic, assign) BOOL isPresenting;
@end

@implementation CardsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)onImageTapped:(UITapGestureRecognizer *)sender {
    ProfileViewController *pvc = [[ProfileViewController alloc] init];
    pvc.modalPresentationStyle = UIModalPresentationCustom;
    pvc.transitioningDelegate = self;
    [self presentViewController:pvc animated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate methods

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.isPresenting = YES;
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.isPresenting = NO;
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning methods

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    UIViewController *toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.cardImageView.image];
    imageView.frame = self.cardImageView.frame;
    imageView.contentMode = self.cardImageView.contentMode;
    imageView.clipsToBounds = self.cardImageView.clipsToBounds;

    [[[UIApplication sharedApplication] keyWindow] addSubview:imageView];
    if (self.isPresenting) {

        [self.cardImageView setHidden:YES];

        NSLog(@"I'm presenting"); //i'm from controller
        toController.view.frame = fromController.view.frame;
        [containerView addSubview:toController.view];
        toController.view.alpha = 0;
        [UIView animateWithDuration:0.4 animations:^{
            toController.view.alpha = 1;
            imageView.transform = CGAffineTransformScale(imageView.transform, 1.1, 1.1);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
            [imageView removeFromSuperview];
        }];
    } else {
        NSLog(@"I'm dismissing"); // i'm toController
        [UIView animateWithDuration:0.4 animations:^{
            [((ProfileViewController *) fromController).profileImage setHidden:YES];
            fromController.view.alpha = 0;
            imageView.transform = CGAffineTransformScale(imageView.transform, 1, 1);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
            [fromController.view removeFromSuperview];
            [imageView removeFromSuperview];
            [self.cardImageView setHidden:NO];
        }];
    }


}


@end
