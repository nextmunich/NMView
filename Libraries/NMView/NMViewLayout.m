//
//  NMViewLayout.m
//  NMView
//
//  Created by Benjamin Broll on 18.02.11.
//  Copyright 2011 NEXT Munich GmbH. The App Agency. All rights reserved.
//

/*
 * The BSD License
 * http://www.opensource.org/licenses/bsd-license.php
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * - Redistributions of source code must retain the above copyright notice, this
 *   list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright notice,
 *   this list of conditions and the following disclaimer in the documentation
 *   and/or other materials provided with the distribution.
 * - Neither the name of NEXT Munich GmbH nor the names of its contributors may
 *   be used to endorse or promote products derived from this software without
 *   specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

#import "NMViewLayout.h"

#import "NMViewLayoutOmitSubviewsView.h"
#import "NMViewLayoutView.h"


#pragma mark -
#pragma mark NMViewLayoutConfiguration Implementation

@interface NMViewLayoutConfiguration : NSObject {
	CGRect frame;
	CGFloat alpha;
	UIViewAutoresizing autoresizingMask;
}

@property (nonatomic, assign) CGRect frame;
@property (nonatomic, assign) CGFloat alpha;
@property (nonatomic, assign) UIViewAutoresizing autoresizingMask;

+ (NMViewLayoutConfiguration *)configurationWithFrame:(CGRect)f
												alpha:(CGFloat)a
									 autoresizingMask:(UIViewAutoresizing)mask;

@end

@implementation NMViewLayoutConfiguration

@synthesize frame, alpha, autoresizingMask;

+ (NMViewLayoutConfiguration *)configurationWithFrame:(CGRect)f
												alpha:(CGFloat)a
									 autoresizingMask:(UIViewAutoresizing)mask {
	NMViewLayoutConfiguration *config = [[[NMViewLayoutConfiguration alloc] init] autorelease];
	config.frame = f;
	config.alpha = a;
	config.autoresizingMask = mask;
	return config;
}

@end


#pragma mark -
#pragma mark NMViewLayout Implementation

@implementation NMViewLayout

@synthesize alternativeBaseFrame;

- (CGFloat)aspectRatio {
	return alternativeBaseFrame.size.width/alternativeBaseFrame.size.height;
}


- (void)addConfiguration:(id)config forView:(UIView *)view {
	NSNumber *num = [NSNumber numberWithUnsignedInteger:(NSUInteger)view];
	[configuration setObject:config forKey:num];
}

- (id)configurationForView:(UIView *)view {
	return [configuration objectForKey:[NSNumber numberWithUnsignedInteger:(NSUInteger)view]];
}


- (BOOL)shouldUseSubviewsForView:(UIView *)view {
	NSString *classname = NSStringFromClass([view class]);
	
	return (view.tag != NMViewLayoutOmitSubviewsTag
			&& ![view isKindOfClass:[NMViewLayoutOmitSubviewsView class]]
			&& (view == baseView
				|| [classname isEqualToString:NSStringFromClass([NMViewLayoutView class])]
				|| [classname isEqualToString:@"UIView"]
				|| [classname isEqualToString:@"UIScrollView"]));
}


- (void)applyToView:(UIView *)view {
	if (view != baseView) {
		NMViewLayoutConfiguration *config = [self configurationForView:view];
		view.frame = config.frame;
		//view.alpha = config.alpha;
		//view.autoresizingMask = config.autoresizingMask;
	}
	
	if ([self shouldUseSubviewsForView:view]) {
		for (NSInteger i = 0; i < [view.subviews count]; i++) {
			[self applyToView:[view.subviews objectAtIndex:i]];
		}
	}
}


- (void)addLayoutForView:(UIView *)original
		 alternativeView:(UIView *)alternative {
	
	NMViewLayoutConfiguration *config = [NMViewLayoutConfiguration configurationWithFrame:alternative.frame
																					alpha:alternative.alpha
																		 autoresizingMask:alternative.autoresizingMask];
	
	[self addConfiguration:config forView:original];
	
	if ([self shouldUseSubviewsForView:alternative]) {
		for (NSInteger i = 0; i < [original.subviews count]; i++) {
			UIView *subview = [original.subviews objectAtIndex:i];
			
			if (i < [alternative.subviews count]) {
				UIView *alternativeSubview = [alternative.subviews objectAtIndex:i];
				
				[self addLayoutForView:subview alternativeView:alternativeSubview];
			}
		}
	}
}


+ (NMViewLayout *)layoutForView:(UIView *)original
			withAlternativeView:(UIView *)alternative {
	
	NMViewLayout *layout = [[[NMViewLayout alloc] init] autorelease];
	layout->alternativeBaseFrame = alternative.frame;
	layout->baseView = original;
	
	[layout addLayoutForView:original alternativeView:alternative];
	
	return layout;
}

- (id)init {
	if ((self = [super init])) {
		configuration = [[NSMutableDictionary alloc] init];
	}
	
	return self;
}

- (void)dealloc {
	[configuration release];
	
	[super dealloc];
}

@end
