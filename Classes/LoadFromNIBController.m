//
//  LoadFromNIBController.m
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

#import "LoadFromNIBController.h"

#import "LoadFromNIBView.h"
#import "NMView.h"


@implementation LoadFromNIBController

#pragma mark Properties

@synthesize view0;


#pragma mark Memory Lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
	// ---
	// view0 has been initialized and loaded when the LoadFromNIBController's
	// view was loaded from the NIB. It's been initialized using -initWithCoder:
	// which in turn uses -loadViewWithNibName:bundle: passing nil / nil.
	// The default loading strategy of -loadViewWithNibName:bundle: tries to
	// load from the default bundle (if nil is passed) and tries to load a nib
	// which has the same name as the NMView subclass. Since the type of view0
	// has been set to LoadFromNIBView in IBs "Identity Inspector" of the view,
	// the LoadFromNIBView nib has been used for loading view0.
	//
	// Important things to note:
	// (1) The properties assigned to the LoadFromNIBView in the nib of
	//     LoadFromNIBController (eg. the green background and the
	//     clip subviews setting) will be overwritten
	//     by the properties in LoadFromNIBView nib. The view's nib will always
	//     take precedence over the nib using the view except for:
	//     - the view's frame (the nib using the view takes precendence)
	//     - the view's tag (the nib using the view takes precendence)
	view0.text = @"----> This is also a very long text that exceeds the view's bounds";
	
	// ---
	// view1 is initialized using -initWithFrame: which in turn uses
	// -loadViewWithNibName:bundle: passing nil / nil to load the layout of the
	// view. Again, the default loading strategy discovers LoadFromNIBView nib
	// and uses that nib for creating the view's layout.
	//
	// Important things to note:
	// (1) The frame passed to -initWithFrame: will be applied after the view's
	//     layout has been loaded from the nib. It takes precendence over the
	//	   frame set in the view's nib.
	// (2) After the view has been loaded, properties like the clip subviews
	//     setting will, of course, take precedence over what was set in the
	//     view's nib.
	CGRect subviewFrame = CGRectMake(20, self.view.bounds.size.height/2-50, 100, 100);
	LoadFromNIBView *view1 = [[[LoadFromNIBView alloc] initWithFrame:subviewFrame] autorelease];
	view1.clipsToBounds = YES;
	[self.view addSubview:view1];
	
	// ---
	// view2 is initialized as a regular NMView object, passing the name of nib
	// to load for creating the view's layout.
	//
	// Important things to note:
	// (1) -initWithNibName:bundle: applies the bounds set in the view's nib.
	//     Thus, this instance of LoadFromNIBView is larger than the two above.
	// (2) We could be using
	//     [[NMView alloc] initWithNibName:@"LoadFromNIBView" bundle:nil] to
	//     initialize a generic NMView object from a nib. In this case it would
	//     fail, however, since the nib tries to access the IBOutlet
	//     activityIndicator which is not available on NMView but only on
	//     LoadFromNIBView. Moreover, when using NMView, we would obviously not
	//     have access to the text property.
	LoadFromNIBView *view2 = [[[LoadFromNIBView alloc] initWithNibName:nil bundle:nil] autorelease];
	view2.frame = CGRectMake(20, self.view.bounds.size.height-view2.bounds.size.height-20,
							 view2.bounds.size.width, view2.bounds.size.height);
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
