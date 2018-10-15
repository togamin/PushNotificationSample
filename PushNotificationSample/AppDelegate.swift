//
//  AppDelegate.swift
//  PushNotificationSample
//
//  Created by Togami Yuki on 2018/10/02.
//  Copyright © 2018 Togami Yuki. All rights reserved.
//

//一つ問題点がある。１回目の動作で、FCMを取得する前に、usedefaultが動作してるため、addした時にエラー。2回目動作させたらうまくいく。FCMを取得してから、ユーザーデフォルトを動作させる必要がある。


import UIKit
import Firebase
import FirebaseAuth
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,MessagingDelegate,UNUserNotificationCenterDelegate {

    var window: UIWindow?
    var uid:String!


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        
        
        // リモート通知 (iOS10に対応)ユーザーにリモート通知を許可するかどうかの確認。
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

//        // アプリ起動時にFCMのトークンを取得し、ユーザーデフォルトに保存。
//        let token = Messaging.messaging().fcmToken
//        UserDefaults.standard.set(token, forKey: "FCM_TOKEN")//トークンに何も入っていない状態で動作してる可能性。
//        print("memo:FCM token \(token ?? "")")

        

        return true
    }
    
    //匿名ログインとユーザーIDの取得
    func signInAno(){
        //匿名ログイン
        Auth.auth().signInAnonymously { (user, error) in
            if let error = error {
                print("memo:匿名ログイン失敗",error)
                return
            }
            if let user = user{
                print("memo:ログイン成功")
                self.uid = user.user.uid
                UserDefaults.standard.set(self.uid, forKey: "UserID")
                print("memo:uid",self.uid)
            }
        }
    }
    
    
    //プッシュ通知を受け取った時に動作する。
    func userNotificationCenter(_ center: UNUserNotificationCenter,willPresent notification: UNNotification,withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("memo:プッシュ通知を受け取りました。")
        print("memo:メッセージの内容",notification.request.content.body)
        
        //「メッセージ文」に記入した文字とともにアラートを表示。
        completionHandler([.alert])
        
    }
    
    //FCMトークン変更時にそれを取得し、ユーザーデフォルトに登録。
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        UserDefaults.standard.set(fcmToken, forKey: "FCM_TOKEN")
        print("memo:Firebase registration token: \(fcmToken)")
    }
    
    //リモート通知を許可した直後に動作する。
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        guard let fcmToken = Messaging.messaging().fcmToken else {
            return
        }
        print("memo:didRegisterForRemoteNotification動作")
        UserDefaults.standard.set(fcmToken, forKey: "FCM_TOKEN")
        print("memo:FCM token \(fcmToken ?? "")")
        signInAno()
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

