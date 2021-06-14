//
//  main.m
//  JobsComment
//
//  Created by Jobs on 2020/11/15.
//

#import <UIKit/UIKit.h>
#import "JobsCommentAppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([JobsCommentAppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
