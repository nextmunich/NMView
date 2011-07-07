//
//  NMGridLayoutManager.h
//  NMView
//
//  Created by Benjamin Broll on 29.06.11.
//  Copyright 2011 NEXT Munich. The App Agency. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NMViewLayoutManager.h"

typedef enum {
	NMGridLayoutDirectionLeftToRightTopToBottom,
	NMGridLayoutDirectionTopToBottomLeftToRight
} NMGridLayoutDirection;

typedef enum {
	NMGridLayoutExtensionNone,
	NMGridLayoutExtensionNextFullPage,
	NMGridLayoutExtensionLastItem
} NMGridLayoutExtension;

typedef enum {
	NMGridLayoutExtensionDirectionRight,
	NMGridLayoutExtensionDirectionDown
} NMGridLayoutExtensionDirection;


@interface NMGridLayoutManager : NMViewLayoutManager {

	// Layouting Parameters
	NMGridLayoutDirection direction;
	NMGridLayoutExtension extension;
	NMGridLayoutExtensionDirection extensionDirection;
	
}

@property (nonatomic, assign) NMGridLayoutDirection direction;
@property (nonatomic, assign) NMGridLayoutExtension extension;
@property (nonatomic, assign) NMGridLayoutExtensionDirection extensionDirection;


@end
