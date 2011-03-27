//
//  AutomaticLayoutChangesController.h
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

#import <UIKit/UIKit.h>


/**
 * This sample illustrates automatic layout changes of an NMView whenever the
 * view's -layoutSubviews method is called.
 *
 * Automatic layout changes can be activated by setting the
 * automaticLayoutChangesEnabled property of your NMView to YES. In case you set
 * the property in -viewDidLoad of your NMView subclass, the initialization of
 * the NMView will already automatically apply the most suitable layout for the
 * bounds of the view set during initialization.
 *
 * Pro Tip:
 *
 * It also showcases that you can force NMView to stop applying a layout at any
 * depth in the alternative layout. If at any point in your layout a view of
 * type NMViewLayoutOmitSubviewsView is encountered, NMView will not change the
 * position / size of its subviews but will continue with its next sibling.
 * This allows automatic layouting using the autoresizing to be performed on
 * parts of a layout. As an example, see how the UIActivityIndicator does not
 * change position according to the alternative layout's position for the
 * UIActivityIndicator but rather according to the indicator's autoresizing
 * properties.
 */
@interface AutomaticLayoutChangesController : UIViewController {

}

@end
