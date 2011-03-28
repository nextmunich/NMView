# Introduction

Apple has gone a long way making it easy for iOS developers to create complex UIs, thanks to
Interface Builder. Create a UIViewController, choose to create a nib file along with it and start
editing away using all the pre-built UIView components provided out of the box: UIButton, UILabel,
UIScrollView, UITableView and friends simplify your life. Interface Builds allows you to arrange the
components the way you see fit, change their properties and wire them to IBOutlets and IBActions.

For creating a UIView component yourself, however, there is no standard way of using Interface
Builder to graphically create the layout of your component. You are left to write many lines of code
to arrange existing components into view hierarchies, change their properties only to notice that
what you wrote in code did not lead to the intended layout. This process is tedious and convincing
people to create their own UIView component is difficult since creating them is no fun.

To simplify the process of implementing UIView components, we've created NMView. NMView is a UIView
subclass which defines a standard mechanism of associating a nib file with the view and how its
contents are loaded into the view. Additionally, it provides advanced features like specifying
different view layouts (eg. landscape vs. portrait) in the nib file which can either manually or
automatically be activated based on the aspect ratio of the view.

After we've successfully used NMView in a couple of projects, we're finally releasing its source
under the BSD license!


# How to get started

## What's available

A full Xcode project! Open in Xcode, browse the project's groups, select one of the available
targets and run in iOS Simulator to get a feeling for what NMView can achieve. Then start digging
into the samples to see how things are working. I tried to document the samples in detail and also
added comments to the NMView class itself.

## Integration into your own projects

The project contains NMView and the required classes in the Libraries/NMView folder. Just copy the
whole directory into your own project and start creating NMView subclasses.

## Examples for NMView subclasses

Have a look at the NMView subclasses in the different Samples groups. Each sample showcases a
specific NMView feature and can serve as a reference for your own NMView subclass implementation.


# More Details

Sergei (who has been working extensively with NMView in the last couple of weeks) provides us with
more details about the ideas behind NMView and its usage.

## How to create nib files for NMView subclasses

The basic idea is that an NMView subclass works like a mini-view controller, possibly with its own
nib file and its own logic. For a very easy start, there are only a few basic steps you need to
take:

1. Create an NMView subclass
2. Create an empty nib file (using New File -> iOS: User Interface -> Empty Xib) with the same name
   that your NMView subclass has
3. Add a view to your nib and start building the layout of your view
4. Add a UIView to one of your controllers, changing its type to your specific NMView subclass in
   Interface Builder's Identity Inspector
5. Done! Launch the app and notice that the view shows up in your view controller the way you
   defined it to look in your nib file
   
The sample "Load From NIB" showcases this.

## What's in a layout and how can we use it

Also, an NMView makes it easier to automatically rotate between interface orientations. To implement
this, the nib file should have several *top-level* views of class NMViewLayoutView. (See
AutomaticLayoutChangesView.xib for an example.) Whenever the frame on the NMView object changes, the
view will adjust its layout by finding the new aspect ratio and selecting the most closely matching
layout. Since the alternative layouts are created in the Interface Builder, you don't need to write
very much code by hand.

A notable exception is when some UIImageViews need to use different bitmaps in portrait and
landscape layouts. In that case, the bitmaps need to be assigned explicitly in the overridden method
layoutDidChangeToAspectRatio:.

It is important to keep in mind that only the first view in the nib file is really used in your
application. All alternative layout views are used only to assign frames to subviews of the first
view. If some view needs to have a red background in portrait but green in landscape, this needs to
be coded in layoutDidChangeToAspectRatio: by hand. The code in the present version of NMview will
ignore the background color set in the nib file for alternative views. Any other properties of the
alternative views are also ignored.

## How to decide whether the automatic layout change should be enabled or disabled

It is important to know that the NMView object does not get orientation change messages. An NMView
object is not a view controller but is a UIView subclass and will usually be the view of some
UIViewController. On rotation, the controller will resize its view, and NMView will get a frame
change. If the automatic layout change is enabled, the function layoutSubviewsIfNecessary will be
called and will perhaps select another layout. If the automatic layout change is disabled, the
function layoutSubviewsIfNecessary will not be called, and the layout will not be changed
automatically. You can call this function yourself in the controller's
–willAnimateRotationToInterfaceOrientation:duration:.

The reason that we have the possibility to disable the automatic layout change is the following:
When some of the subviews are animated (e.g. an animated button) such that the transform is changed
on a subview (e.g. scale or rotation is changed), it turns out that layoutSubviews is called on the
superview at each animation. When the automatic layout change is enabled, this leads to the
breakdown of the animation since NMView will set the frame the subview to the initial position while
that subview is being animated. For this reason, the automatic layout change must be disabled if any
direct subviews of NMView are being scaled or rotated through a Core Animation.

## How and when to use view templates

If you come across the need to dynamically display content in your view that has the same layout
across all the different instances of your data, you might want to have a look at view templates.

In the UIView+NMTemplating.h / .m category, the -applyViewTemplate: method allows you to apply all
the properties and subviews of the view that is passed in as the parameter to the receiver of the
method call. When the call finishes, the receiver looks exactly the way specified in your view
template. You can now go ahead and configure the new view with the data and add it to your view.

As an alternative, you can always just create the template view as a regular UIView / NMView
subclass and create new instances of that class whenever you need to display new data. The advantage
of using view templates over custom NMView subclasses is loading time: whenever you create a new
NMView instance, the nib file is loaded from disk into memory. With a view template, you can specify
the template in the NMView's nib file, assign it via an IBOutlet to your NMView subclass and work
from that in-memory template. Creating a new instance of the template is a mere call to
`[[[UIView alloc] initWithFrame:frame] applyViewTemplate:theTemplate]`.
