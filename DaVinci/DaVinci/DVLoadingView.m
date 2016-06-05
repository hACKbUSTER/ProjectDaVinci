//
//  DVLoadingView.m
//  DVLoading
//
//  Created by Alex Ling on 4/6/2016.
//  Copyright © 2016 Alex Ling. All rights reserved.
//

#import "DVLoadingView.h"

@implementation DVLoadingView

- (id) initWithMaxHeight:(CGFloat)maxHeight minHeight:(CGFloat)minHeight width:(CGFloat)width minAlpha:(CGFloat)minAlpha spacing:(CGFloat)spacing color:(UIColor*)color {
	self = [super initWithFrame:CGRectMake(0, 0, 4 * width + 3 * spacing, maxHeight)];
	
	self.maxHeight = maxHeight;
	self.minHeight = minHeight;
	self.width = width;
	self.minAlpha = minAlpha;
	self.spacing = spacing;
	self.color = color;
	self.bars = [[NSMutableArray alloc] init];
	
	[self createViews];
	[self preset];
	[self setUpAnimation];
	
	return self;
}

- (void) createViews {
	for (int i = 0; i < 4; i ++) {
		UIView *bar = [[UIView alloc] init];
		[bar setBackgroundColor:_color];
		[bar setFrame:CGRectMake(i * (_width + _spacing), 0, _width, _maxHeight)];
		bar.layer.cornerRadius = bar.frame.size.width/3;
		bar.clipsToBounds = TRUE;
		[self addSubview:bar];
		[_bars addObject:bar];
	}
}

- (void) preset {
	for (int i = 0; i < _bars.count; i ++) {
		UIView *bar = _bars[i];
		CGFloat alphaStep = (1 - _minAlpha)/3;
		CGFloat heightStep = (_maxHeight - _minHeight)/3;
		[bar setAlpha: _minAlpha + alphaStep * i];
		[self setBar:bar to:(1 + i) * heightStep];
	}
}

- (void) setUpAnimation {
	for (int i = 0; i < _bars.count; i ++) {
		UIView *bar = _bars[i];
		[self animateBar:bar with:(NSTimeInterval)i * 0.1];
	}
}

- (void) animateBar: (UIView*) bar with: (NSTimeInterval) delay {
	[UIView animateWithDuration:0.5 delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
		if (bar.frame.size.height < _maxHeight - 1.0) {
			[self setBar:bar to:_maxHeight];
			[bar setAlpha:1];
		}
		else {
			[self setBar:bar to:_minHeight];
			[bar setAlpha:_minAlpha];
		}
	} completion:^(BOOL finished){
		[self animateBar:bar with:0];
	}];
}

- (void) setBar: (UIView*) bar to: (CGFloat) height {
	CGRect frame = bar.frame;
	CGPoint center = bar.center;
	frame.size.height = height;
	[bar setFrame:frame];
	[bar setCenter:center];
}

@end
