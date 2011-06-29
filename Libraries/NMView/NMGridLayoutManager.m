//
//  NMGridLayoutManager.m
//  NMView
//
//  Created by Benjamin Broll on 29.06.11.
//  Copyright 2011 NEXT Munich. The App Agency. All rights reserved.
//

#import "NMGridLayoutManager.h"


@interface NMGridLayoutManager (Private)

- (CGSize)layoutViews:(NSArray *)views constrainedToSize:(CGSize)containerSize;
- (CGSize)layoutViews:(NSArray *)views constrainedToSize:(CGSize)containerSize
		  viewsPerRow:(NSInteger)viewsPerRow viewsPerCol:(NSInteger)viewsPerCol;
- (CGSize)layoutViews:(NSArray *)views constrainedToSize:(CGSize)containerSize
		  viewsPerRow:(NSInteger)viewsPerRow viewsPerCol:(NSInteger)viewsPerCol
	  skipHiddenViews:(BOOL)skipHiddenViews;

@end



@implementation NMGridLayoutManager

#pragma mark Properties

@synthesize direction, extension, extensionDirection;


#pragma mark Layouting

- (BOOL)layoutSubviews:(UIView *)view {
	[self layoutViews:view.subviews constrainedToSize:view.bounds.size];
	
	return YES;
}


#pragma mark Private API

- (CGSize)layoutViews:(NSArray *)views constrainedToSize:(CGSize)containerSize {
	return [self layoutViews:views constrainedToSize:containerSize viewsPerRow:0 viewsPerCol:0];
}

- (CGSize)layoutViews:(NSArray *)views constrainedToSize:(CGSize)containerSize
		  viewsPerRow:(NSInteger)viewsPerRow viewsPerCol:(NSInteger)viewsPerCol {
	
	
	return [self layoutViews:views constrainedToSize:containerSize
				 viewsPerRow:viewsPerRow viewsPerCol:viewsPerCol
			 skipHiddenViews:YES];
}

- (CGSize)layoutViews:(NSArray *)views constrainedToSize:(CGSize)containerSize
		  viewsPerRow:(NSInteger)viewsPerRow viewsPerCol:(NSInteger)viewsPerCol
	  skipHiddenViews:(BOOL)skipHiddenViews {
	
	if ([views count] == 0) return CGSizeZero;
	
	// calculate layouting parameters
	CGSize viewSize = [[views objectAtIndex:0] bounds].size;
	viewsPerRow = (viewsPerRow <= 0 ? (NSInteger) (containerSize.width/viewSize.width) : viewsPerRow);
	viewsPerCol = (viewsPerCol <= 0 ? (NSInteger) (containerSize.height/viewSize.height) : viewsPerCol);
	NSInteger viewsPerPage = (viewsPerRow*viewsPerCol);
	
	CGFloat horizontalGap = (containerSize.width-viewsPerRow*viewSize.width)/(viewsPerRow+1);
	CGFloat verticalGap = (containerSize.height-viewsPerCol*viewSize.height)/(viewsPerCol+1);
	
	// arrange views
	NSUInteger viewIndex = 0;
	for (UIView *view in views) {
		NSUInteger page = (viewIndex / viewsPerPage);
		CGSize pageOffset = CGSizeMake(page*containerSize.width, page*containerSize.height);
		
		NSUInteger row = 0;
		NSUInteger col = 0;
		
		// determine the row and column of the view on the current page
		if (direction == NMGridLayoutDirectionLeftToRightTopToBottom) {
			row = (viewIndex / viewsPerRow) % viewsPerCol;
			col = (viewIndex % viewsPerRow);
		} else if (direction == NMGridLayoutDirectionTopToBottomLeftToRight) {
			row = (viewIndex % viewsPerCol);
			col = (viewIndex / viewsPerCol) % viewsPerRow;
		}
		
		// in case we're no longer on the first page, remove the "big gap" that
		// is required for an extension to the next full page in case we're
		// using an extension to the last item only
		if (extension == NMGridLayoutExtensionLastItem) {
			pageOffset.width = MAX(0, pageOffset.width-horizontalGap);
			pageOffset.height = MAX(0, pageOffset.height-verticalGap);
		}
		
		// adjust the page offset based on the direction in which we would like
		// to extend
		if (extensionDirection == NMGridLayoutExtensionDirectionRight) {
			pageOffset.height = 0;
		} else if (extensionDirection == NMGridLayoutExtensionDirectionDown) {
			pageOffset.width = 0;
		}
		
		// position the view
		view.frame = CGRectMake(horizontalGap+pageOffset.width+col*(horizontalGap+viewSize.width),
								verticalGap+pageOffset.height+row*(verticalGap+viewSize.height),
								viewSize.width, viewSize.height);
		
		// increase view index if necessary
		if (!view.hidden || !skipHiddenViews) viewIndex++;
	}
	
	// calculate size
	if (extension == NMGridLayoutExtensionNextFullPage) {
		NSUInteger pageOfLastButton = (viewIndex-1)/viewsPerPage;
		
		if (extensionDirection == NMGridLayoutExtensionDirectionRight) {
			return CGSizeMake((pageOfLastButton+1)*containerSize.width, containerSize.height);
		} else {
			return CGSizeMake(containerSize.width, (pageOfLastButton+1)*containerSize.height);
		}
	} else if (extension == NMGridLayoutExtensionLastItem) {
		UIView *firstView = [views objectAtIndex:0];
		UIView *lastView = [views lastObject];
		
		return CGSizeMake(2*horizontalGap+(CGRectGetMaxX(lastView.frame)-CGRectGetMinX(firstView.frame)),
						  2*verticalGap+(CGRectGetMaxY(lastView.frame)-CGRectGetMinY(firstView.frame)));
	} else {
		return containerSize;
	}
}

@end
