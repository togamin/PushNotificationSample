//
//  ViewController.swift
//  PushNotificationSample
//
//  Created by Togami Yuki on 2018/10/02.
//  Copyright © 2018 Togami Yuki. All rights reserved.
//

import UIKit
import UserNotifications
import FirebaseFirestore

class ViewController: UIViewController {
    
    var defaultStore : Firestore!
    var uid:String!
    var FCM_TOKEN: String!
    @IBOutlet weak var memoTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // プッシュ通知の許諾に関するダイアログ表示。
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { _, _ in
            print("memo:push permission finishd")
            
        }
        
        
        
        
        //ログイン成功後に「uid」に「FCM_TOKEN」をFirebaseに保存する。
        uid = UserDefaults.standard.object(forKey: "UserID") as! String
        FCM_TOKEN = UserDefaults.standard.object(forKey: "FCM_TOKEN") as! String
        
        defaultStore = Firestore.firestore()
        defaultStore.collection("User").document("\(uid!)").setData([
            "FCM_TOKEN": FCM_TOKEN!,
            "memo":"とがみんブログ"
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    
    
    @IBAction func addData(_ sender: UIButton) {
        defaultStore.collection("User").document("\(uid!)").setData([
            "FCM_TOKEN": FCM_TOKEN!,
            "memo":memoTextField.text!
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

