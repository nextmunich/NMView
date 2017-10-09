# iOS 11 Bug

This library causes a problem with UIActivityViewController on iOS 11. When trying to share a PDF
document with UIActivityViewController on iPad on iOS 11, the share sheet is not displayed.

The issue is caused by the UIImage+NMNSCoding category used by the library.

# Deprecation Warning

This library has not been maintained for quite a long time so I suppose nobody is using it anymore.
However, since we have recently discovered an subtle issue on iOS 11 which is caused by this library,
I wanted to officially highlight that the project should no longer be used.