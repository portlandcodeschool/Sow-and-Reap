//
//  GameScene.m
//  Sow and Reap
//
//  Created by Timothy Winters on 3/2/15.
//  Copyright (c) 2015 Timothy Winters. All rights reserved.
//

#import "GameScene.h"
@implementation GameScene
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]){
        
        SKLabelNode *menu = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        menu.text = @"Show Menu";
        menu.name = @"menuLabel";
        menu.fontSize = 28;
        menu.position = CGPointMake(self.frame.size.width - menu.frame.size.width/2 - 10,self.frame.size.height - 40);
        
        [self addChild:menu];
        
        NSLog(@"Size: %@", NSStringFromCGSize(size));
        isWatering = false;
        isPlanting = false;
        isHarvesting = false;
        _Money = 0;
        self.plants = [NSMutableArray array];
        self.Income = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
        self.Income.text = [NSString stringWithFormat:@"Current income is %i", _Money];
        self.Income.fontSize = 15;
        self.Income.position = CGPointMake(200, 175);
        self.Water =[SKLabelNode labelNodeWithFontNamed:@"Arial"];
        self.Water.text = @"Water";
        self.Water.fontSize = 15;
        self.Water.name = @"WaterNode";
        self.Water.position = CGPointMake(200, 250);
        
        self.Plant_Seeds = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        self.Plant_Seeds.text =@"Plant Seeds";
        self.Plant_Seeds.fontSize = 15;
        self.Plant_Seeds.name = @"SeedsNode";
        self.Plant_Seeds.position = CGPointMake(200, 225);
        
        self.Harvest = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
        self.Harvest.text =@"Harvest Plants";
        self.Harvest.fontSize = 15;
        self.Harvest.name =@"HarvestNode";
        self.Harvest.position =CGPointMake(200, 200);
        
        self.backgroundColor = [SKColor colorWithRed:0.27 green:0.24 blue:0.13 alpha:1.0];
        self.plant = [Tomato new];
        self.plant.position = CGPointMake(400, self.plant.size.height/2);
        self.plant1 = [Lettuce new];
        self.plant1.position = CGPointMake(300, self.plant1.size.height/2);
        [self addChild:self.plant1];
        [self addChild:self.plant];
        [self addChild:self.Water];
        [self addChild:self.Plant_Seeds];
        [self addChild:self.Harvest];
        [self addChild:self.Income];
        
        
    }
    return self;
}

-(void)didSwipe {
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKNode *touchedNode = [self nodeAtPoint:location];
        //NSLog(@"%@", touchedNode);
        if ([touchedNode.name isEqualToString:@"menuLabel"]) {
            if (topMenuView) {
                [topMenuView hideMenu];
            }
            
            if (!sideMenuView) {
                sideMenuView = [[SideMenuView alloc] init];
                sideMenuView.delegate = self;
                [self.view addSubview:sideMenuView];
                [sideMenuView showMenu];
                
            } else {
                [sideMenuView hideMenu];
                sideMenuView = nil;
            }
            
        } else {
            
            if ([touchedNode.name isEqualToString:@"Lettuce"]) {
                NSLog(@"Lettuce plant touched");
                if(isWatering) {
                    Lettuce  *lettuce = (Lettuce *)touchedNode;
                    [lettuce AddWater];
                    isWatering = FALSE;
                }
                if (isHarvesting) {
                    Lettuce *lettuce = (Lettuce *)touchedNode;
                    [lettuce Harvest_Plant];
                    isHarvesting = FALSE;
                    
                }
                
                if (isPlanting) {
                    Lettuce *lettuce = (Lettuce *)touchedNode;
                    [lettuce Plant_Seeds];
                    isPlanting = FALSE;
                }
            }  else if ([touchedNode.name isEqualToString:@"Tomato"]) {
                NSLog(@"Tomato plant touched");
                if(isWatering) {
                    Tomato *tomato = (Tomato *)touchedNode;
                    [tomato AddWater];
                    isWatering = FALSE;
                }
                if (isHarvesting) {
                    Tomato *tomato =(Tomato *)touchedNode;
                    [tomato Harvest_Plant];
                    tomato.removeFromParent;
                    _Money +=20;
                    isHarvesting = FALSE;
                }
                if (isPlanting) {
                    Tomato *tomato = (Tomato *)touchedNode;
                    [tomato Plant_Seeds];
                    isPlanting = FALSE;
                }
            } else if ([touchedNode.name isEqualToString:@"HarvestNode"]) {
                isHarvesting = TRUE;
                NSLog(@"Harvest Node Touched");
            } else if ([touchedNode.name isEqualToString:@"SeedsNode"]) {
                isPlanting = TRUE;
                NSLog(@"Seeds Node Touched");
            } else if ([touchedNode.name isEqualToString:@"WaterNode"]) {
                isWatering = TRUE;
                NSLog(@"Water Node Touched");
                
            }
            
        }
        self.Income.text = [NSString stringWithFormat:@"Current income is %i", _Money];
    }
    
}

#pragma -mark
#pragma SideMenu delegate
-(void)didSelectGameMode:(NSInteger)mode {
    self.mode = mode;
    
    [sideMenuView hideMenu];
    
    if (self.mode == 0){
        if (!topMenuView) {
            topMenuView = [[TopMenuView alloc] init];
            topMenuView.delegate = self;
            [self.view addSubview:topMenuView];
            [topMenuView showMenu];
            
        } else {
            [topMenuView hideMenu];
            topMenuView = nil;
        }
    }
    NSLog(@"selected mode  %li", (long)mode);
    
}

#pragma -mark
#pragma TopMenu delegate
-(void)didSelectPlantType:(NSInteger)plantType {
    //Do something depsending on what type of plant was selected
    NSLog(@"selected plant type %li", (long)plantType);
    [topMenuView hideMenu];
    topMenuView = nil;
}
@end