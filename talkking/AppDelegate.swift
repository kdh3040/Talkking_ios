//
//  AppDelegate.swift
//  talkking
//
//  Created by 도호소프트 on 2018. 4. 23..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import UIKit
import SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
                // 임시
        
        
      
      //  let uuid = NSUUID().uuidString
       let uuid = CFUUIDCreateString(nil, CFUUIDCreate(nil))
     //  FireBaseFunc.Instance.LoadMyIndex(uuid: String(uuid!))
        
       // var tempuuid = "2A81CBB50-66CB-40BD-AA4D-C5DD14C22EE7"
       // tempuuid = "2259441abd2bad79"
        
        CommonUIFunc.ShowLoading()
        
        FireBaseFunc.Instance.LoadUserIndex(uuid: "a8970cb9531bdd5c" as! String)
 
 
        //NSString *UUID = [nameofclass]
        // 내 데이터 생성
      //  DataMgr.Instance.MyData = MyUserData(userIndex: 1)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

