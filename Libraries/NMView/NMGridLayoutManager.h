//
//  NMGridLayoutManager.h
//  NMView
//
//  Created by Benjamin Broll on 29.06.11.
//  Copyright 2011 NEXT Munich. The App Agency. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NMViewLayoutManager.h"

typedef enum {
    /** Arranges subviews one row (from left to right) at a time, from top to bottom. */
	NMGridLayoutDirectionLeftToRightTopToBottom,
    /** Arranges subviews one column (from top to bottom) at a time, from left to right. */
	NMGridLayoutDirectionTopToBottomLeftToRight
} NMGridLayoutDirection;

typedef enum {
    /** 
     * Stops layouting subviews once the first subview is encountered which does not fit
     * within its' superview's bounds.
     */
	NMGridLayoutExtensionNone,
    /**
     * Layouts consecutive subviews to fill full 'pages' (multiples of the bounds with same
     * left/right and top/bottom margins) of subviews. Useful for layouting UIScrollViews
     * with pagingEnabled set to YES.
     */
	NMGridLayoutExtensionNextFullPage,
    /**
     * Layouts consecutive subviews continuing with the same spacing as used for all
     * previous subviews. Useful for layouting UIScrollViews with pagingEnabled set to NO.
     */
	NMGridLayoutExtensionLastItem
} NMGridLayoutExtension;

typedef enum {
    /** Extends at the right of the superview's bounds. */
	NMGridLayoutExtensionDirectionRight,
    /** Extends at the bottom of the superview's bounds. */
	NMGridLayoutExtensionDirectionDown
} NMGridLayoutExtensionDirection;


/**
 * An NMViewLayoutManager implementation that provides a generic grid layout
 * algorithm for arranging the subviews of a UIView.
 *
 * The algorithm uses the subviews' sizes 'as is' and lays them out one by one
 * in the specified direction. Once the algorithm encounters the first subview
 * that can no longer be placed within its' superviews' bounds, it uses the
 * specified extension mode and extensionDirection to determine how the subview
 * (and any subsequent subviews) will be placed outside of their superview's
 * bounds.
 */
@interface NMGridLayoutManager : NMViewLayoutManager {

	// Layouting Parameters
	NMGridLayoutDirection direction;
	NMGridLayoutExtension extension;
	NMGridLayoutExtensionDirection extensionDirection;
	
}

/**
 * Specifies the direction in which a view's subviews are layed out within
 * their superview.
 */
@property (nonatomic, assign) NMGridLayoutDirection direction;

/**
 * Specifies how subviews are layed out in case they do not fit within their
 * superview's bounds (i.e. how they are 'extended' beyond their superview's
 * bounds).
 */
@property (nonatomic, assign) NMGridLayoutExtension extension;

/**
 * Specifies the direction in which subviews that do not fit within their
 * superview's bounds are extended beyond their superview's bounds.
 */
@property (nonatomic, assign) NMGridLayoutExtensionDirection extensionDirection;


@end
