//
//  LayoutSupportController.m
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

#import "LayoutSupportController.h"

#import "NMView.h"


@implementation LayoutSupportController

#pragma mark Properties

@synthesize v;


#pragma mark Button Actions

- (IBAction)switchLayout {
	static int mode = 1;
	
	// Wrap the change of layout using an animation block to animate the layout
	// changes.
	[UIView beginAnimations:@"move" context:nil];
	[UIView setAnimationDuration:0.5];
	
	// We change the bounds of our view depending on the current state.
	if (mode == 0) {
		v.center = CGPointMake(70, 120);
		v.bounds = CGRectMake(0, 0, 100, 200);
		v.backgroundColor = [UIColor yellowColor];
	} else if (mode == 1) {
		v.center = CGPointMake(120, 120);
		v.bounds = CGRectMake(0, 0, 200, 200);
		v.backgroundColor = [UIColor orangeColor];
	} else if (mode == 2) {
		v.center = CGPointMake(120, 70);
		v.bounds = CGRectMake(0, 0, 200, 100);
		v.backgroundColor = [UIColor redColor];
	} else {
		v.center = CGPointMake(220, 220);
		v.bounds = CGRectMake(0, 0, 400, 400);
		v.backgroundColor = [UIColor greenColor];
	}
	
	// Now we request the view to investigate, whether - based on the new
	// bounds - a different layout should be displayed.
	[v changeLayoutIfNecessary];
	
	[UIView commitAnimations];
	
	mode = (mode+1)%4;
}


#pragma mark Memory Lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
	v.backgroundColor = [UIColor yellowColor];
}

- (void)viewDidUnload {
    [super viewDidUnload];
	
	self.v = nil;
}

- (void)dealloc {
	self.v = nil;
	
    [super dealloc];
}

@end
