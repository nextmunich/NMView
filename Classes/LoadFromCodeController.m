//
//  LoadFromCodeController.m
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

#import "LoadFromCodeController.h"

#import "LoadFromCodeView.h"


@implementation LoadFromCodeController

#pragma mark Properties

@synthesize view0;


#pragma mark Orientation Management

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return YES;
}


#pragma mark Memory Lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
	// view0 has been loaded using the NIB of the controller. 
	// If a UIView object is instantiated during NIB loading, its
	// -initWithcoder: method is used for initialization.
	view0.backgroundColor = [UIColor redColor];
	
	// view1 is loaded from code and instantiated using the -initWithFrame:
	// method.
	CGRect subviewFrame = CGRectMake(0, 80, self.view.bounds.size.width, 40);
	LoadFromCodeView *view2 = [[[LoadFromCodeView alloc] initWithFrame:subviewFrame] autorelease];
	view2.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	view2.backgroundColor = [UIColor greenColor];
	[self.view addSubview:view2];
}

- (void)viewDidUnload {
	[super viewDidUnload];
	
	self.view0 = nil;
}

- (void)dealloc {
	self.view0 = nil;
	
	[super dealloc];
}

@end
