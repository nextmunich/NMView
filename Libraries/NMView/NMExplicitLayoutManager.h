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


@interface NMExplicitLayoutManager : NMViewLayoutManager {

	NMExplicitLayout *currentLayout; // weak ref
	NSMutableArray *layouts;
	
}

@property (nonatomic, readonly) NMExplicitLayout *currentLayout;

- (void)addExplicitLayoutAlternative:(UIView *)alternative forView:(UIView *)original;

@end
