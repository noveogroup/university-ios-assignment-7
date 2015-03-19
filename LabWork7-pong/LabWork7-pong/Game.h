//
//  Game.h
//  LabWork7-pong
//
//  Created by Александр on 19.03.15.
//  Copyright (c) 2015 Alexandr Ovchinnikov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>



@interface Game : NSObject

@property (nonatomic) NSValue *ballLayout;
@property (nonatomic) NSValue *topPlatformLayout;
@property (nonatomic) NSValue *bottomPlatformLayout;
@property (nonatomic) CGSize gameAreaSize;



@end
