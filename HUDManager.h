//
//  HUDManager.h
//  MetroSige
//
//  Created by Leonel Valentini on 17/5/16.
//  Copyright © 2016 LDV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface HUDManager : NSObject

+ (instancetype)sharedInstance;
- (void) addHUD;
- (void) progressHUD:(float)progress;
- (void) removeHUD;
- (void) textHUD:(NSString*)text;
- (void) textHUDHiddeNow:(NSString*)text newHUD:(BOOL)new;
- (void) errorHUD:(int)code;

@end
