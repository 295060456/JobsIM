//
//  main.m
//  JobsIM
//
//  Created by Jobs on 2020/11/10.
//

#import <UIKit/UIKit.h>
#import "JobsIMAppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([JobsIMAppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
