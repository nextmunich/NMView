//
//  NMView.h
//  NMView
//
//  Created by Benjamin Broll on 17.02.11.
//  Copyright 2011 NEXT Munich GmbH. The App Agency. All rights reserved.
//

#define NMVIEW_VERSION @"1.1.1"


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

@class NMViewLayoutManager;


/**
 * The NMView class allows the creation of custom UIView subclasses using nib
 * files to specify the layout of the view.
 *
 * Typically, when creating UIView subclasses, the view's appearance and its
 * subview hierarchy have to be assembled in code. This can become tedious and
 * is prone to error. With NMView, you design your view's layout using IB, save
 * the layout in a nib file and load the view with its layout during its
 * initialization.
 *
 * ## View layouts using nib files
 *
 * NMView provides a default implementation of the -loadViewWithNibName:bundle:
 * method which is used to load the view's layout from a nib file. The
 * implementation relies on a special structure of the nib file which is
 * described in detail in the documentation of -loadViewWithNibName:bundle:.
 *
 * For initialization of your view in code, you can either use the regular
 * -initWithFrame: method or the -initWithNibName:bundle: method. If the view is
 * initialized as part of a nib loading process (eg. when the view is added as
 * a subview to a UIViewController's view hierarchy in the view controller's nib
 * file), the -initWithCoder: method is used to initialize the view.
 *
 * Each of the initialization methods try to load the view's layout from a nib
 * file using -loadViewWithNibName:bundle:. The -initWithFrame: and
 * -initWithCoder: methods try to load the nib by passing nil for the nib name
 * and nil for the bundle, the -initWithNibName:bundle: method passes its
 * argument values to -loadViewWithNibName:bundle:. Passing nil / nil will try
 * to load a nib with the class name's name from the main bundle.
 *
 * If NMView cannot load the view from a nib (either because there is no
 * matching nib file or because the nib's structure does not fit the loading
 * process), it will call the -createView method as a last resort for creating
 * the view's layout programmatically. Therefore, even when creating your view's
 * layout in code, subclassing from NMView can make sense since -createView is
 * called regardless of the initializer used to create the instance.
 *
 * After the view has been loaded (either from a nib or using -createView), the
 * -viewDidLoad method is called. You can override the method in your custom
 * NMView subclass to perform some post-processing work that cannot be performed
 * in Interface Builder.
 *
 * One obvious thing to point out: since NMView (and its subclasses) directly
 * inherits from UIView, its view is loaded during initialization for the whole
 * lifetime of the instance. This is in contrast to a
 * UIViewController where the controller can exist without the associated view
 * (ie. -initWithNibName:bundle: on UIViewController does *not* load the view).
 * Therefore, for NMView, -viewDidLoad is always called exactly once during the
 * lifetime of an NMView instance whereas a UIViewController's -viewDidLoad
 * might be called multiple times.
 *
 * ## Alternative layouts
 *
 * On top of loading the view's layout from a nib file, NMView also supports
 * alternative layouts that can be activated based on the current bounds of the
 * view. This allows, for example, for the creation of different layouts of the
 * same NMView subclass for portrait and landscape orientations that cannot be
 * implemented using regular view autoresizing.
 *
 * Layouts can either be activated manually using the -changeLayoutIfNecessary
 * method or can be changed automatically by setting the
 * automaticLayoutChangeEnabled property to YES. In that case, each call to
 * -layoutSubviews automatically calls -changeLayoutIfNecessary.
 *
 * Once a layout has been applied, the -layoutDidChange method is
 * called to allow the NMView subclass to perform some post-processing on the
 * new layout. In this method you can, for example, apply modifications to your
 * layout that you cannot define in IB (like change the transform of one of the
 * subviews).
 *
 * For NMView to be able to load alternative layouts, the layouts have to be
 * specified in the same nib that the view is loaded from. Next to the regular
 * view layout, the nib will have to include another top-level view of the exact
 * same hierarchy for each alternative layout. Using Interface Builder, the
 * subviews in the alternative layout can now be re-arranged (as long as their
 * hierarchy is kept in the same shape as the regular layout). Once done, the
 * top-level view's type of each alternative layout has to be changed to
 * NMViewLayoutView so that NMView can detect which of the views should be used
 * for alternative layouts and which views might serve a different purpose (like
 * being injected into IBOutlets of your view).
 */
@interface NMView : UIView {

@private
	
	NMViewLayoutManager *layoutManager;
	BOOL automaticLayoutChangeEnabled;
	
}


#pragma mark View Loading

/// ----------------------
/// @name Initialization
/// ----------------------

/**
 * Initializes a new view object by first calling -initWithFrame: of UIView with
 * a default CGRect and subsequently trying to load the view by calling
 * -loadViewWithNibName:bundle: passing nil / nil for the nib name and bundle.
 *
 * If the a nib file was loaded successfully, the view's frame will be set to
 * that loaded from the nib file. If no matching nib was found, the -createView
 * method can reset the default frame to a more suitable value.
 */
- (id)init;

/**
 * Initializes a new view object by first calling -initWithFrame: of UIView and
 * subsequently trying to load the view by calling -loadViewWithNibName:bundle:
 * passing nil / nil for the nib name and bundle.
 *
 * After the view has been loaded from the nib, the view's frame is reset to the
 * parameter passed into the method, overriding the frame that was set in the
 * view's nib.
 *
 * @param frame The frame applied to the view after it has been loaded. The
 *              returned view will always have this frame set.
 */
- (id)initWithFrame:(CGRect)frame;

/**
 * Initializes a new view object from the given nib file.
 *
 * This method calls -loadViewWithNibName:bundle: to perform the actual view
 * loading.
 *
 * @param nibName The name of the nib file from which the view should be loaded.
 *                Can be nil to indicate that the class' name should be used for
 *                the nib name. The name must be passed without extension.
 * @param nibBundle The bundle from which the nib file should be loaded. Can be
 *                  nil to indicate that the main bundle should be used.
 */
- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle;

/// --------------------
/// @name View Loading
/// --------------------

/**
 * Loads the view's properties from the given nib file.
 *
 * If nibBundle is nil, [NSBundle mainBundle] is used for loading the nib.
 * If nibName is nil, we're trying to load a nib with the name of the current
 * class.
 * If the nib was loaded properly, it has to contain at least one object of
 * type UIView. That UIView object's properties are applied to this view to 
 * customize its appearance and view hierarchy. The nib is searched for the
 * UIView "from top to bottom" (ie. the first UIView object contained in the nib
 * is used.
 * If no nib could be found, the -createView method is called as a last resort
 * to construct the view programatically.
 *
 * Override this method to provide your own loading strategy.
 *
 * @warning This method should not be called by users of NMView and is only
 *          meant for subclassing.
 *
 * @param nibName The name of the nib file from which the view should be loaded.
 *                Can be nil to indicate that the class' name should be used for
 *                the nib name. The name must be passed without extension.
 * @param nibBundle The bundle from which the nib file should be loaded. Can be
 *                  nil to indicate that the main bundle should be used.
 */
- (void)loadViewWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle;

/**
 * Programmatically creates the view and its hierarchy.
 *
 * Override this method to create your custom view subclass. The default
 * implementation does nothing.
 *
 * @warning This method should not be called by users of NMView and is only meant
 *          for subclassing.
 */
- (void)createView;

/**
 * Called after the view was loaded either from a nib or using the -createView
 * method.
 *
 * Override this method to perform any view customization when loading did
 * finish. The default implementation does nothing.
 * 
 * @warning This method should not be called by users of NMView and is only meant
 *          for subclassing.
 */
- (void)viewDidLoad;


#pragma mark Layout Management

/// -------------------------
/// @name Layout Management
/// -------------------------

/**
 * Sets the NMViewLayoutManager that is used to change the view's layout in
 * response to a call to -changeLayoutIfNecessary.
 *
 * The layout manager is nil by default. If the view is loaded from a nib which
 * includes alternative layouts, NMExplicitLayoutManager is set as the layout
 * manager and will automatically be configured with the view's alternative
 * layouts.
 */
@property (nonatomic, retain) IBOutlet NMViewLayoutManager *layoutManager;

/**
 * Enables automatic layout changes whenever -layoutSubviews is called. The
 * default value is NO.
 */
@property (nonatomic, assign) BOOL automaticLayoutChangeEnabled;

/**
 * Called to ask the view to update its layout using the NMViewLayoutManager
 * assigned to layoutManager. In case the NMViewLayoutManager indicates that
 * the layout was changed, the -layoutDidChange method will be invoked to
 * allow subclasses to react to the layout change.
 */
- (void)changeLayoutIfNecessary;

/**
 * Called after the layout of a view was changed during a call to
 * -changeLayoutIfNecessary to better match the current aspect ratio.
 *
 * Override this method to dynamically adapt to the layout change.
 *
 * @warning This method should not be called by users of NMView and is only meant
 *          for subclassing.
 */
- (void)layoutDidChange;

@end
