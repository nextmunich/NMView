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