//
//  LayoutSupportController.h
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

#import <UIKit/UIKit.h>

@class NMView;


/**
 * This sample illustrates using different layouts based for an NMView instance.
 *
 * Sometimes, views need to be layouted differently when significantly changing
 * the view's aspect ratio: it may have two completely different layouts of the
 * same controls depending on whether it is displayed in portrait or landscape
 * mode.
 *
 * NMView supports creating multiple layouts of the same view in the nib file
 * and will record the layouts during nib loading. Once loading is complete, the
 * view can manually be requested to investigate whether a more suitable
 * layout is available. If the automaticLayoutChangeEnabled property is set to
 * YES, the view will automatically adapt the layout in -layoutSubviews.
 *
 * The sample provides an NMView with three different layouts and a button which
 * cycles through the different layouts. The background color of the view is
 * changed only to better visualize which layout is currently in effect.
 */
@interface LayoutSupportController : UIViewController {

	NMView *v;
	
}

@property (nonatomic, retain) IBOutlet NMView *v;

- (IBAction)switchLayout;

@end
