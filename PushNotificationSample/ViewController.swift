//
//  ViewController.swift
//  PushNotificationSample
//
//  Created by Togami Yuki on 2018/10/02.
//  Copyright © 2018 Togami Yuki. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // プッシュ通知の許諾に関するダイアログ表示。
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { _, _ in
            print("memo:push permission finishd")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

