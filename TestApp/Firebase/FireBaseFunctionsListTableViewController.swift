//
//  FireBaseFunctionsListTableViewController.swift
//  TestApp
//
//  Created by kaigi on 2016/07/14.
//  Copyright © 2016年 kaigi. All rights reserved.
//

import UIKit

class FireBaseFunctionsListTableViewController: UITableViewController {

    private let functionsList: [String]
    private var colorAlpha: Float = 0

    override init(style: UITableViewStyle) {
        functionsList = ["UserAuthentication", "Chat"]
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Functions"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return functionsList.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        colorAlpha += 1.0/Float(functionsList.count)
        cell.backgroundColor = UIColor(colorLiteralRed: 1.00, green: 0, blue: 0, alpha: colorAlpha)
        cell.textLabel?.text = functionsList[indexPath.row]
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            navigationController?.pushViewController(ChatViewController(), animated: true)
        default: break
        }
    }
}
