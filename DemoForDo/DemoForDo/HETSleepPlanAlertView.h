//
//  HETSleepPlanAlertView.h
//  CSleepDolphin
//
//  Created by 刘宏扬 on 2018/4/2.
//  Copyright © 2018年 HET. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HETSleepPlanAlertView : UIView


+ (void)showPlanAlertWithPlanDays:(NSUInteger)planDays
                         doneDays:(NSUInteger)doneDays
                           scores:(NSUInteger)scores
                  continuePlanAction:(void(^)(void))continuePlanAction;

+ (void)hiddenPlanAlert;

@end
