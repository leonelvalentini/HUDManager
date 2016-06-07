//
//  HUDManager.m
//  MetroSige
//
//  Created by Leonel Valentini on 17/5/16.
//  Copyright © 2016 LDV. All rights reserved.
//

#import "HUDManager.h"

@implementation HUDManager

static HUDManager *sharedInstance = nil;

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[HUDManager alloc] init];
    });
    return sharedInstance;
}

- (void) addHUD{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].windows[0] animated:YES];
    hud.label.text = NSLocalizedString(@"Cargando...", @"Cargando...");
    hud.minSize = CGSizeMake(150.f, 100.f);
}

- (void) progressHUD:(float)progress{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD HUDForView:[UIApplication sharedApplication].windows[0]];
        hud.mode = MBProgressHUDModeDeterminate;
        hud.progress = progress;
    });
}

- (void) removeHUD{
    // Update the UI on the main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD HUDForView:[UIApplication sharedApplication].windows[0]];
        UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        hud.customView = imageView;
        hud.mode = MBProgressHUDModeCustomView;
        hud.label.text = NSLocalizedString(@"Completado", @"Completado");
        [hud hideAnimated:YES afterDelay:1.f];
    });
}

- (void) textHUD:(NSString*)text {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].windows[0] animated:YES];
    
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    
    [hud hideAnimated:YES afterDelay:2.f];
}

- (void) textHUDHiddeNow:(NSString*)text newHUD:(BOOL)new{
    
    MBProgressHUD *hud;
    
    if (new) {
        hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].windows[0] animated:YES];
        [hud hideAnimated:YES afterDelay:2.f];
    }else{
        hud = [MBProgressHUD HUDForView:[UIApplication sharedApplication].windows[0]];
    }
    
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
}

- (void) errorHUD:(int)code {
    
    // Update the UI on the main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD HUDForView:[UIApplication sharedApplication].windows[0]];
        hud.mode = MBProgressHUDModeText;
        
        switch (code) {
            case 200:
                hud.label.text = @"";
                break;
            case 201:
                hud.label.text = @"La operación ha sido realizada";
                break;
            case 204:
                hud.label.text = @"Error de contenido (204)";
                break;
            case 401:
                hud.label.text = @"Error: No autorizado (401)";
                break;
            case 404:
                hud.label.text = @"Contenido inexistente";
                break;
            case 500:
                hud.label.text = @"Error de Servidor (500)";
                break;
            default:
                hud.label.text = @"Error desconocido";
                break;
        }
        
        [hud hideAnimated:YES afterDelay:3.0f];
    });
}

@end
