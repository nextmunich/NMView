//
//  NMView.m
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

#import "NMView.h"

#import "NMViewLayout.h"
#import "NMViewLayoutView.h"
#import "UIView+NMTemplating.h"


@implementation NMView

#pragma mark Properties

@synthesize automaticLayoutChangeEnabled;


#pragma mark Methods to be overridden by subclasses

- (void)loadViewWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle {
	// 0. Initialize
	layouts = [[NSMutableArray alloc] init];
	
	// 1. check for nil values and use default values, if necessary
	if (nibName == nil) nibName = NSStringFromClass([self class]);
	if (bundle == nil) bundle = [NSBundle mainBundle];
	
	// 2. test if nib exists in bundle
	BOOL viewLoadedFromNib = NO;
	NSString *path = [bundle pathForResource:nibName ofType:@"nib"];
	if (path != nil) {
		// 2a. try to load from nib
		NSArray *nibContent = [bundle loadNibNamed:nibName owner:self options:nil];
		if (nibContent != nil) {
			for (NSUInteger i = 0; i < [nibContent count]; i++) {
				NSObject *object = [nibContent objectAtIndex:i];
				
				if ([object isKindOfClass:[UIView class]]) {
					UIView *view = (UIView *)object;
					
					if (!viewLoadedFromNib) {
						// apply nib template to current view
						[self applyViewTemplateByCopyingHierarchy:view];
						[layouts addObject:[NMViewLayout layoutForView:self
												   withAlternativeView:self]];
						
						viewLoadedFromNib = YES;
					} else if (view.tag == NMViewLayoutTag
							   || [view isKindOfClass:[NMViewLayoutView class]]) {
						[layouts addObject:[NMViewLayout layoutForView:self
												   withAlternativeView:view]];
					}
				}
			}
		}
	}
	
	// 3. create view using code if nib loading failed
	if (!viewLoadedFromNib) {
		[self createView];
	}
	
	// 4. let subclasses know that the view did load
	[self viewDidLoad];
}

- (void)createView { }

- (void)viewDidLoad { }


#pragma mark Layout Management

- (void)layoutSubviews {
	if (self.automaticLayoutChangeEnabled) {
		[self changeLayoutIfNecessary];
	}
}

- (void)changeLayoutIfNecessary {
	CGFloat aspectRatio = self.bounds.size.width/self.bounds.size.height;
	CGFloat smallestDifference = 100;
	NMViewLayout *closestLayout = nil;
	
	for (NMViewLayout *layout in layouts) {
		if (ABS(layout.aspectRatio-aspectRatio) < smallestDifference) {
			smallestDifference = ABS(layout.aspectRatio-aspectRatio);
			closestLayout = layout;
		}
	}
	
	
	if (closestLayout != nil) {
		[closestLayout applyToView:self];
		[self layoutDidChangeToAspectRatio:closestLayout.aspectRatio];
	}
}

- (void)layoutDidChangeToAspectRatio:(CGFloat)aspectRatio { }


#pragma mark Init

- (id)init {
	return [self initWithNibName:nil bundle:nil];
}

- (id)initWithNibName:(NSString*)name bundle:(NSBundle*)bundle {
	// use a dummy rect to initialize the UIView object
	if ((self = [super initWithFrame:CGRectMake(0, 0, 100, 100)])) {
		// load the view's layout, maintaining the rect that was set in the nib
		[self loadViewWithNibName:name bundle:bundle];
		
		// re-layout (in case of a view which changes layouts automatically)
		[self layoutSubviews];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		// load the view's layout
        [self loadViewWithNibName:nil bundle:nil];
		
		// overwrite the nib-loaded frame with the given frame parameter
        self.frame = frame;
		
		// re-layout (in case of a view which changes layouts automatically)
		[self layoutSubviews];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ((self = [super initWithCoder:aDecoder])) {
		// store the frame and tag loaded from the nib which is using this view
		CGRect frameBeforeLoad = self.frame;
		NSInteger t = self.tag;
		
		// load the view's layout
		[self loadViewWithNibName:nil bundle:nil];
		
		// overwrite the nib-loaded frame and tag with the frame and tag of the
		// nib using this view
		self.frame = frameBeforeLoad;
		self.tag = t;
		
		// re-layout (in case of a view which changes layouts automatically)
		[self layoutSubviews];
	}
	return self;
}

- (void)dealloc {
	[layouts release];
	
	[super dealloc];
}

@end
