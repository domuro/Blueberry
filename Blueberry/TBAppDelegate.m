//
//  TBAppDelegate.m
//  Blueberry
//
//  Created by Derek Omuro on 5/14/14.
//  Copyright (c) 2014 TeamBlueberry. All rights reserved.
//

#import "TBAppDelegate.h"
#import "TBNavigationController.h"
#import "TBEncounterManager.h"
#import "TBUserInformationCache.h"
#import "TBPriority.h"

@implementation TBAppDelegate
#define kFilteringFactor    0.03
#define knockThreshold      2.0

#define Derek 1
#define Edward 2
#define Karan 3
#define Tai 4
#define Adrien 5

TBNavigationController *nav;
bool knockFlag = 0;
bool bluetoothFlag = 0;
int myUserID = Derek;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    self.window.backgroundColor = [UIColor whiteColor];
    nav = [[TBNavigationController alloc] init];

    TBUserInformationCache *userCache = [TBUserInformationCache sharedManager];
    TBPerson *person;
    for (int i = 1; i < 25; i++){
        if(i == myUserID){
            //dont add to table
            person = [userCache.cache objectForKey:[NSNumber numberWithInt:myUserID]];
            if(person == nil){
                person = [[TBPerson alloc] init];
                [person importFrom:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"person-%d", 25] ofType:@"plist"]];
            }
            [userCache.cache setObject:person forKey:[NSNumber numberWithInt:myUserID]];
        }
        else{
            person = [userCache.cache objectForKey:[NSNumber numberWithInt:i]];
            if(person == nil){
                person = [[TBPerson alloc] init];
                [person importFrom:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"person-%d", i] ofType:@"plist"]];
            }
            [userCache.cache setObject:person forKey:[NSNumber numberWithInt:i]];
        }
    }
    
    TBEncounterManager *encounterManager = [TBEncounterManager sharedManager];
    for (int i = 1; i < 25; i++){
        [encounterManager.interactions setObject:[[TBPriority alloc] init] forKey:[NSNumber numberWithInt:i]];
    }
    
    [self refreshTestData];
    
    self.myProfile = [[TBPerson alloc] init];
    [self.myProfile importFrom:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"person-%d", myUserID] ofType:@"plist"]];
    
    //Beacon
    [[INBeaconService singleton] addDelegate:self];
    [[INBeaconService singleton] setIdentifier:@"CB284D88-5317-4FB4-9621-C5A3A49E6159"];
    [[INBeaconService singleton] setLocalName:[NSString stringWithFormat:@"%d", myUserID]];

    //Motion
    self.motionManager = [[CMMotionManager alloc] init];
    [self listenForKnock];
    
    [self.window setRootViewController:nav];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - INBeaconServiceDelegate
- (void)service:(INBeaconService *)service foundDevices:(NSDictionary *)devices
{
    for (NSString *deviceName in devices) {
        TBEncounterManager *manager = [TBEncounterManager sharedManager];
        NSNumber *key = [NSNumber numberWithInt:[deviceName intValue]];
        TBPriority *p = [manager.interactions objectForKey:key];
        if(p == nil)
            p = [[TBPriority alloc] init];
        
        //Todo care about distance?
        [p ping];
        if(knockFlag){
            p.priority += 1000;
        }
        [manager.interactions setObject:p forKey:key];
        knockFlag = 0;
    }
    
    //reload encounter table via nav
    [nav updateDataSource];
}

- (INDetectorRange)convertRSSItoINProximity:(NSInteger)proximity
{
    if (proximity < -70)
        return INDetectorRangeFar;
    if (proximity < -55)
        return INDetectorRangeNear;
    if (proximity < 0)
        return INDetectorRangeImmediate;
    
    return INDetectorRangeUnknown;
}

- (void)listenForKnock
{
    [self.motionManager
     startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc] init]
     withHandler:^(CMAccelerometerData *data, NSError *error)
     {
         float accelZ;
         accelZ = data.acceleration.z - ((data.acceleration.z * kFilteringFactor) + (accelZ * (1.0 - kFilteringFactor)));
         if(accelZ > knockThreshold || accelZ < -knockThreshold){
             if([[INBeaconService singleton] isBroadcasting]){
                 knockFlag = 1;
             }
             else{
                 knockFlag = 0;
             }
         }
     }
     ];
}

- (void)refreshTestData
{
    //panic button
    //Todo pull this server and store in memory? TESTING
    TBEncounterManager *encounterManager = [TBEncounterManager sharedManager];
    TBUserInformationCache *userCache = [TBUserInformationCache sharedManager];
    TBPriority *priority;
    
    [nav.encounterDataSource removeAllObjects];
    [nav.toFollowDataSource removeAllObjects];
    [nav.contactDataSource removeAllObjects];
    
    for(int i = 10; i < 19; i++){
        [nav.contactDataSource addObject:[userCache.cache objectForKey:[NSNumber numberWithInt:i]]];
    }
    [nav.contactDataSource addObject:[userCache.cache objectForKey:[NSNumber numberWithInt:Tai]]];
    

    // priority from 5 to 14 inclusive
    for(int i = 19; i < 25; i++){
        priority = [encounterManager.interactions objectForKey:[NSNumber numberWithInt:i]];
        priority.priority = i-10;
    }
    
    for(int i = 6; i < 10; i++){
        priority = [encounterManager.interactions objectForKey:[NSNumber numberWithInt:i]];
        priority.priority = i-1;
    }
    
    priority = [encounterManager.interactions objectForKey:[NSNumber numberWithInt:Derek]];
    priority.priority = 5;
    priority = [encounterManager.interactions objectForKey:[NSNumber numberWithInt:Adrien]];
    priority.priority = 5;
    priority = [encounterManager.interactions objectForKey:[NSNumber numberWithInt:Edward]];
    priority.priority = -200;
    
    [nav setEventName:@"Butterworth"];
    if(myUserID == Karan){
        [nav setEventName:@""];
    }
    [nav updateName];
    [nav panicUpdate];
}

@end
