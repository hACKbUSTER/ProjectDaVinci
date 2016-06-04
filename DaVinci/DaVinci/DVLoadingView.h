//
//  DVLoadingView.h
//  DVLoading
//
//  Created by Alex Ling on 4/6/2016.
//  Copyright © 2016 Alex Ling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVLoadingView : UIView

@property (strong, nonatomic) NSMutableArray *bars;
@property CGFloat maxHeight;
@property CGFloat minHeight;
@property CGFloat width;
@property CGFloat minAlpha;
@property CGFloat spacing;
@property UIColor *color;

- (id) initWithMaxHeight: (CGFloat) maxHeight minHeight: (CGFloat) minHeight width: (CGFloat) width minAlpha: (CGFloat) minAlpha spacing: (CGFloat) spacing color: (UIColor*) color;

@end
