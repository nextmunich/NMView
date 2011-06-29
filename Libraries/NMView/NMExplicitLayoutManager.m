//
//  NMExplicitLayoutManager.m
//  NMView
//
//  Created by Benjamin Broll on 29.06.11.
//  Copyright 2011 NEXT Munich. The App Agency. All rights reserved.
//

#import "NMExplicitLayoutManager.h"

#import "NMExplicitLayout.h"
#import "NMViewLayoutView.h"


@implementation NMExplicitLayoutManager

#pragma mark Properties

@synthesize currentLayout;


#pragma mark Public API

- (void)addExplicitLayoutAlternative:(UIView *)alternative forView:(UIView *)original {
	if (alternative == original
		|| alternative.tag == NMViewLayoutTag
		|| [alternative isKindOfClass:[NMViewLayoutView class]]) {
	
		[layouts addObject:[NMExplicitLayout layoutForView:original
									   withAlternativeView:alternative]];
	}
}


#pragma mark Layouting

- (BOOL)layoutSubviews:(UIView *)view {
	CGFloat aspectRatio = view.bounds.size.width/view.bounds.size.height;
	CGFloat smallestDifference = 100;
	NMExplicitLayout *closestLayout = nil;
	
	for (NMExplicitLayout *layout in layouts) {
		if (ABS(layout.aspectRatio-aspectRatio) < smallestDifference) {
			smallestDifference = ABS(layout.aspectRatio-aspectRatio);
			closestLayout = layout;
		}
	}
	
	
	if (closestLayout != nil) {
		[closestLayout applyToView:view];
		currentLayout = closestLayout;
		return YES;
	} else {
		return NO;
	}
}


#pragma mark Init & Dealloc

- (id)init {
	if ((self = [super init])) {
		layouts = [[NSMutableArray alloc] init];
	}
	
	return self;
}

- (void)dealloc {
	[layouts release];
	
	[super dealloc];
}

@end
