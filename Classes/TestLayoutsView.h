//
//  TestLayoutsView.h
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

#import <Foundation/Foundation.h>

#import "NMView.h"


/**
 * This view has three different layouts defined in its nib file.
 *
 * For a layout to work correctly, the layout has to contain each of the
 * original layout's views in the exact same order in IB (order and hierarchy /
 * depth are both crucial). Once this setup is in place, you can re-position
 * the views (*not* change their order / depth) as you see fit. As the last
 * step, the type of the top level view which defines a layout needs to be
 * changed (in IB using the "Identity Inspector") to NMViewLayoutView to
 * indicate to NMView that it is indeed defining a layout. As an alternative,
 * you can also set the top level view's tag to a special value (see
 * NMViewLayout for the tag value).
 *
 * Overwrite the -layoutDidChangeToAspectRatio: method to perform some
 * post-processing of the views that cannot automatically happen in IB. As an
 * example, you can change the transform of a subview in
 * -layoutDidChangeToAspectRatio: to rotate it by 90°.
 *
 * Important notes:
 * (1) The basic view properties (like tag, auto-resizing properties and so on)
 *     of the subviews are loaded from the initial layout only. When changing to
 *     a different layout these properties will not change. Only the position
 *     and size of the subviews are adjusted during a layout change.
 */
@interface TestLayoutsView : NMView {

}

@end
