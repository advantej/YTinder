//
//  DraggableImageView.m
//  YTinder
//
//  Created by Tejas Lagvankar on 2/19/15.
//  Copyright (c) 2015 Yahoo!. All rights reserved.
//

#import "DraggableImageView.h"

@interface DraggableImageView()

@property (nonatomic, assign) CGPoint originalImgCenter;
@property (nonatomic, assign) int degrees;

@end

@implementation DraggableImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setUp];
    return  self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [self setUp];
    return  self;
}


- (void) setUp{

    self.degrees = 10;
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onViewPaned:)];
    [self addGestureRecognizer:panGestureRecognizer];

}

- (void)onViewPaned:(UIPanGestureRecognizer *)sender{
    CGPoint translation = [sender translationInView:self];
    CGPoint velocity = [sender velocityInView:self];

    if (sender.state == UIGestureRecognizerStateBegan) {
        self.originalImgCenter = self.center;
        if (velocity.x > 0) {
            self.transform = CGAffineTransformRotate(self.transform, self.degrees * M_PI / 180);
        } else {
            self.transform = CGAffineTransformRotate(self.transform, -self.degrees * M_PI / 180);

        }
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        self.center = CGPointMake(self.originalImgCenter.x + translation.x, self.originalImgCenter.y);

    } else if (sender.state == UIGestureRecognizerStateEnded) {
        int deg = self.degrees;
        if (velocity.x > 0) {
            deg = -deg;
        }
        self.transform = CGAffineTransformRotate(self.transform, deg * M_PI / 180);
    }


}


@end
