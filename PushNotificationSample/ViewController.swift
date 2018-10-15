//
//  ViewController.swift
//  PushNotificationSample
//
//  Created by Togami Yuki on 2018/10/02.
//  Copyright © 2018 Togami Yuki. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class ViewController: UIViewController {
    
    var uid:String!
    var FCM_TOKEN: String!
    var defaultStore : Firestore!
    
    @IBOutlet weak var memoTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        defaultStore = Firestore.firestore()
        
        print("memo:viewDidLoad")
        
    }
    
    
    
    @IBAction func addData(_ sender: UIButton) {
        uid = UserDefaults.standard.object(forKey: "UserID") as! String
        FCM_TOKEN = UserDefaults.standard.object(forKey: "FCM_TOKEN") as! String
        defaultStore.collection("User").document(uid).setData([
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

