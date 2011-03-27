//
//  LoadFromCodeView.m
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

#import "LoadFromCodeView.h"


@implementation LoadFromCodeView


- (void)createView {
	// This is the only method we need to override in case we want to create our
	// view's layout in code. We don't have to know that -initWithCoder: or
	// -initWithFrame: can be used to instantiate the class.
	
	// The layout below creates a left- and a right-aligned label with
	// appropriate auto-resizing properties.
	
	CGRect frm = CGRectInset(self.bounds, 5, 5);
	
	// create a left-aligned label
	frm.size = CGSizeMake(frm.size.width/2, frm.size.height);
	UILabel *lblLeft = [[[UILabel alloc] initWithFrame:frm] autorelease];
	lblLeft.backgroundColor = [UIColor clearColor];
	lblLeft.text = @"I'm a left-aligned label.";
	lblLeft.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
	[self addSubview:lblLeft];
	
	// create a right-aligned label
	frm.origin = CGPointMake(frm.origin.x+frm.size.width, frm.origin.y);
	UILabel *lblRight = [[[UILabel alloc] initWithFrame:frm] autorelease];
	lblRight.backgroundColor = [UIColor clearColor];
	lblRight.text = @"... and I'm right-aligned.";
	lblRight.textAlignment = UITextAlignmentRight;
	lblRight.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
	[self addSubview:lblRight];
}

@end
