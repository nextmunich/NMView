//
//  ViewTemplatesView.m
//  NMView
//
//  Created by Benjamin Broll on 24.03.11.
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
 *
 * Neither the name of NEXT Munich GmbH nor the names of its contributors may be
 * used to endorse or promote products derived from this software without
 * specific prior written permission.
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

#import "ViewTemplatesView.h"

#import "UIView+NMTemplating.h"


@implementation ViewTemplatesView

#pragma mark Properties

- (void)setItemTemplate:(UIView *)template {
	if (itemTemplate != template) {
		[itemTemplate release];
		itemTemplate = [template retain];
	}
}

- (UIView *)itemTemplate {
	return itemTemplate;
}


#pragma mark Item Management

- (void)addItemWithTitle:(NSString *)title text:(NSString *)text {
	// Create a new item based on the template view
	CGRect itemFrame = CGRectMake(currentX, 20, itemTemplate.bounds.size.width, itemTemplate.bounds.size.height);
	UIView *item = [[[UIView alloc] initWithFrame:itemFrame] autorelease];
	currentX += 20+itemFrame.size.width;
	
	// This is where the magic happens: the call copies all properties of the
	// template view and its subview hierarchy into "item". Since we copy (ie.
	// we create an entirely new hierarchy, separate from the template itself),
	// the template can be reused from call to call and does not have to be
	// re-loaded from a nib.
	[item applyViewTemplate:itemTemplate];
	
	// Customize the item according to the given properties
	UILabel *lbl = (UILabel *)[item viewWithTag:3001];
	lbl.text = title;
	UITextView *txt = (UITextView *)[item viewWithTag:3002];
	txt.text = text;
	
	[self addSubview:item];
}


#pragma mark View Lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
	currentX = 20;
}

@end
