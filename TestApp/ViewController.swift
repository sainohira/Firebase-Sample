//
//  ViewController.swift
//  TestApp
//
//  Created by kaigi on 2016/07/12.
//  Copyright © 2016年 kaigi. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    // データベースへの参照
    let rootRef = FIRDatabase.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        let conditionRef = rootRef.child("condition")
        // クラウド上で、ノード condition に変更があった場合のコールバック処理
        conditionRef.observeEventType(.Value) { (snap: FIRDataSnapshot) in
            print("ノードの値が変わりました！: \(snap.value?.description)")
        }
    }

    @IBAction func touchFirebaseButton(sender: AnyObject) {
        let vc = FireBaseFunctionsListTableViewController(style: UITableViewStyle.Plain)
        navigationController?.pushViewController(vc, animated: true)
    }


}

