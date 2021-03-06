//
//  MenuView.h
//  SpriteKitMenu
//
//  Created by Erick Bennett on 3/2/15.
//  Copyright (c) 2015 Erick Bennett. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@protocol TopMenuDelegate <NSObject>

-(void) didSelectPlantType:(NSInteger)plantType;

@end

@interface TopMenuView : SKView
@property (nonatomic) BOOL showing;
@property (nonatomic, retain) id <TopMenuDelegate> delegate;
@property NSInteger lettuce_seeds;
@property NSInteger tomato_seeds;

@property UIButton *button1;
@property UIButton *button2;

-(void) showMenu;
-(void) hideMenu;

@end
