//
//  ChatViewController.swift
//  TestApp
//
//  Created by kaigi on 2016/07/14.
//  Copyright © 2016年 kaigi. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    private var chatInfos = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!

    var databaseRef:FIRDatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.dataSource = self
        tableView.delegate = self
        messageTextField.delegate = self

        databaseRef = FIRDatabase.database().reference()

        databaseRef.observeEventType(.ChildAdded, withBlock: { snapshot in
            if let name = snapshot.value!.objectForKey("name") as? String,
                message = snapshot.value!.objectForKey("message") as? String {
                let chatInfo = ["user": name, "message": message]
                chatInfo["user"]
                self.chatInfos.arrayByAddingObject(chatInfo)
            }
        })

        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: "keyboardWillBeShown:",
                                                         name: UIKeyboardWillShowNotification,
                                                         object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: "keyboardWillBeHidden:",
                                                         name: UIKeyboardWillHideNotification,
                                                         object: nil)
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        NSNotificationCenter.defaultCenter().removeObserver(self,
                                                            name: UIKeyboardWillShowNotification,
                                                            object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self,
                                                            name: UIKeyboardWillHideNotification,
                                                            object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Num: \(indexPath.row)")
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatInfos.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath)
        let chatInfo = chatInfos[indexPath.row] as! [String : String]
        cell.textLabel!.text = chatInfo["user"]
        return cell
    }

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {


        return true
    }

    @IBAction func sendButtonPush(sender: AnyObject) {

        var userName = ""

        switch segment.selectedSegmentIndex {
        case 0:
            userName = "UserA"
        case 1:
            userName = "UserB"
        default:
            break
        }
        let messageData = ["name": userName, "message": messageTextField.text!]
        databaseRef.childByAutoId().setValue(messageData)

        messageTextField.resignFirstResponder()
        messageTextField.text = ""
    }
}
