//
//  NMExplicitLayoutManager.h
//  NMView
//
//  Created by Benjamin Broll on 29.06.11.
//  Copyright 2011 NEXT Munich. The App Agency. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NMViewLayoutManager.h"

@class NMExplicitLayout;


/**
 * An NMViewLayoutManager implementation that records alternative layouts
 * for a view that are applied based on the layout that best matches the
 * current aspect-ration of the view.
 */
@interface NMExplicitLayoutManager : NMViewLayoutManager {

	NMExplicitLayout *currentLayout; // weak ref
	NSMutableArray *layouts;
	
}

@property (nonatomic, readonly) NMExplicitLayout *currentLayout;

/**
 * Records the changes required to produce the given alternative layout for
 * the provided original view.
 *
 * Whenever the NMExplicitLayoutManager is subsequently asked to layout the
 * original view, the recorded alternative layout is considered and will be
 * applied in case its aspect-ratio best matches the aspect-ratio of the
 * original view at the time of the call to [NMView changeLayoutIfNecessary].
 *
 * @param alternative A view that contains the same subview hierarchy as the
 *                    original view. The only changes recorded are the center
 *                    and bounds of the alternative view.
 * @param original The original view for which an alternative layout is
 *                 provided.
 */
- (void)addExplicitLayoutAlternative:(UIView *)alternative forView:(UIView *)original;

@end
