//
//  UIView+NMTemplating.m
//  NMView
//
//  Created by Benjamin Broll on 17.02.11.
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

#import "UIView+NMTemplating.h"


@implementation UIView (NMTemplating)


- (void)applyViewProperties:(UIView *)view {
	// Visual Appearance
	self.backgroundColor = view.backgroundColor;
	self.hidden = view.hidden;
	self.alpha = view.alpha;
	self.opaque = view.opaque;
	self.clipsToBounds = view.clipsToBounds;
	self.clearsContextBeforeDrawing = view.clearsContextBeforeDrawing;
	
	// Event-Related
	self.userInteractionEnabled = view.userInteractionEnabled;
	self.multipleTouchEnabled = view.multipleTouchEnabled;
	self.exclusiveTouch = view.exclusiveTouch;
	
	// Resizing Behaviour
	self.autoresizingMask = view.autoresizingMask;
	self.autoresizesSubviews = view.autoresizesSubviews;
	self.contentMode = view.contentMode;
	self.contentStretch = view.contentStretch;
	
	// Drawing / Updating
    if ([self respondsToSelector:@selector(contentScaleFactor)]) {
        self.contentScaleFactor = view.contentScaleFactor;
    }
	
	// Identifying
	self.tag = view.tag;
	
	// Bounds
	self.bounds = view.bounds;
}


- (UIView *)copyView {
	if ([self respondsToSelector:@selector(encodeWithCoder:)]) {
		NSMutableData *data = [[NSMutableData alloc] init];
		
		NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
		[archiver encodeObject:self forKey:@"view"];
		[archiver finishEncoding];
		[archiver release];
		
		NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
		UIView *copy = [unarchiver decodeObjectForKey:@"view"];
		[unarchiver finishDecoding];
		[unarchiver release];
		
		[data release];
		
		return copy;
	} else {
		return nil;
	}
}


- (void)applyViewTemplate:(UIView *)view {
	// Apply Properties
	[self applyViewProperties:view];
	 
	// Re-Create subview structure
	for (UIView *subview in view.subviews) {
		UIView *copy = [subview copyView];
		[self addSubview:copy];
	}
}

- (void)applyViewTemplateByCopyingHierarchy:(UIView *)view {
	// Apply Properties
	[self applyViewProperties:view];
	
	// Detach / Attach subviews
	for (UIView *subview in view.subviews) {
		[subview retain];
		[subview removeFromSuperview];
		
		[self addSubview:subview];
		
		[subview release];
	}	
}

@end
