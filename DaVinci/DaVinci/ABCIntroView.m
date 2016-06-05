//
//  IntroView.m
//  DrawPad
//
//  Created by Adam Cooper on 2/4/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import "ABCIntroView.h"

@interface ABCIntroView () <UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) UIButton *doneButton;

@property (strong, nonatomic) UIView *viewOne;
@property (strong, nonatomic) UIView *viewTwo;
@property (strong, nonatomic) UIView *viewThree;


@end

@implementation ABCIntroView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
    
        [self.scrollView addSubview:self.viewOne];
        [self.scrollView addSubview:self.viewTwo];
        [self.scrollView addSubview:self.viewThree];
        
        //Done Button
        [self addSubview:self.doneButton];
            

    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = CGRectGetWidth(self.bounds);
    CGFloat pageFraction = self.scrollView.contentOffset.x / pageWidth;
    self.pageControl.currentPage = roundf(pageFraction);
    
}

-(UIView *)viewOne {
    if (!_viewOne) {
    
        _viewOne = [[UIView alloc] initWithFrame:self.frame];
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f,0.0f, self.frame.size.width, self.frame.size.height)];
        imageview.contentMode = UIViewContentModeScaleAspectFit;
        imageview.image = [UIImage imageNamed:@"Intro1"];
        [_viewOne addSubview:imageview];
        
    }
    return _viewOne;
    
}

-(UIView *)viewTwo {
    if (!_viewTwo) {
        CGFloat originWidth = self.frame.size.width;
        CGFloat originHeight = self.frame.size.height;
        
        _viewTwo = [[UIView alloc] initWithFrame:CGRectMake(originWidth, 0, originWidth, originHeight)];
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f,0.0f, self.frame.size.width, self.frame.size.height)];
        imageview.contentMode = UIViewContentModeScaleAspectFit;
        imageview.image = [UIImage imageNamed:@"Intro2"];
        [_viewTwo addSubview:imageview];
    }
    return _viewTwo;
    
}

-(UIView *)viewThree{
    
    if (!_viewThree) {
        CGFloat originWidth = self.frame.size.width;
        CGFloat originHeight = self.frame.size.height;
        
        _viewThree = [[UIView alloc] initWithFrame:CGRectMake(originWidth*2, 0, originWidth, originHeight)];
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f,0.0f, self.frame.size.width, self.frame.size.height)];
        imageview.contentMode = UIViewContentModeScaleAspectFit;
        imageview.image = [UIImage imageNamed:@"Intro3"];
        [_viewThree addSubview:imageview];
    }
    return _viewThree;
    
}

-(UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        [_scrollView setDelegate:self];
        [_scrollView setPagingEnabled:YES];
        [_scrollView setContentSize:CGSizeMake(self.frame.size.width*3, self.scrollView.frame.size.height)];
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    return _scrollView;
}

-(UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height-80, self.frame.size.width, 10)];
        [_pageControl setCurrentPageIndicatorTintColor:self.tintColor];
        [_pageControl setNumberOfPages:3];
    }
    return _pageControl;
}

-(UIButton *)doneButton {
    if (!_doneButton) {
        _doneButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.frame.size.height-60, self.frame.size.width, 60)];
        [_doneButton setTintColor:[UIColor whiteColor]];
        [_doneButton setTitle:@"Go for my First Personal App!" forState:UIControlStateNormal];
        [_doneButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [_doneButton setBackgroundColor:self.tintColor];
        [_doneButton addTarget:self.delegate action:@selector(onDoneButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneButton;
}

@end