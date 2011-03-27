//
//  ViewTemplatesController.h
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

#import <UIKit/UIKit.h>

@class ViewTemplatesView;


/**
 * This sample illustrates view templating.
 *
 * Using the -applyViewTemplate: method of the UIView+NMTemplating.h UIView
 * category, we can copy all properties and the full subview hierarchy of the
 * view passed into the method as a parameter onto the view on which the method
 * was called. This allows for the creation of template views in a nib and the
 * easy creation of many views which look identical to the template without
 * additional nib loading.
 *
 * In this example, ViewTemplatesView provides a means to populate the view
 * with items consisting of a title and a text. The look and feel of an item is
 * defined in the ViewTemplatesView nib and is made available via an IBOutlet to
 * ViewTemplatesView. When adding a new item, ViewTemplatesView creates a new
 * UIView instance and applies the template to it. Once the template has been
 * applied, the new instance is configured according to the values for the new
 * item.
 */
@interface ViewTemplatesController : UIViewController {

	ViewTemplatesView *itemView;
	
}

@property (nonatomic, retain) IBOutlet ViewTemplatesView *itemView;

- (IBAction)addItem;

@end
