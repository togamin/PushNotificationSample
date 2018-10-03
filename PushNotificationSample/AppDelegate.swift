//
//  AppDelegate.swift
//  PushNotificationSample
//
//  Created by Togami Yuki on 2018/10/02.
//  Copyright © 2018 Togami Yuki. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMessaging
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,MessagingDelegate,UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        
        
        // リモート通知 (iOS10に対応)
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        
        // UNUserNotificationCenterDelegateの設定
        UNUserNotificationCenter.current().delegate = self
        // FCMのMessagingDelegateの設定
        Messaging.messaging().delegate = self
        
        // リモートプッシュの設定
        application.registerForRemoteNotifications()
        // Firebase初期設定
        FirebaseApp.configure()
        
        // アプリ起動時にFCMのトークンを取得し、表示する
        let token = Messaging.messaging().fcmToken
        print("memo:FCM token: \(token ?? "")")
        

        return true
    }
    
    //プッシュ通知を受け取った時に動作する。
    func userNotificationCenter(_ center: UNUserNotificationCenter,willPresent notification: UNNotification,withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("memo:プッシュ通知を受け取りました。")
        print("memo:メッセージの内容",notification.request.content.body)
        
        //「メッセージ文」に記入した文字とともにアラートを表示。
        completionHandler([.alert])
        
    }
    
    //トークンが更新されるたびに通知を受け取る?(まだ理解していない)
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print("memo:Firebase registration token: \(fcmToken)")
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

