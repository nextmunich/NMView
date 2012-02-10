//
//  NMViewLayoutManager.h
//  NMView
//
//  Created by Benjamin Broll on 29.06.11.
//  Copyright 2011 NEXT Munich. The App Agency. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 * The NMViewLayoutManager defines the contract for a class that wants
 * to change the layout of a UIView.
 *
 * It can be subclassed and used as the [NMView layoutManager] to e.g.
 * provide a grid-based layout for the subclasses of your view.
 */
@interface NMViewLayoutManager : NSObject {

}

/**
 * Called by NMView to ask the NMViewLayoutManager to check the current
 * layout of the passed in view and, if necessary, update its' layout.
 *
 * @param view The view to layout.
 * @return Whether the layout manager changed the layout of the view.
 */
- (BOOL)layoutSubviews:(UIView *)view;

@end
