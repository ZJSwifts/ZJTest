//
//  MyTableViewController.swift
//  ZJTest
//
//  Created by 庄记 on 2016/12/27.
//  Copyright © 2016年 庄记. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        /*
         静态Cell和动态Cell 同时使用的时候
         */
        //在设置每个Section的时候 必须要满足StoryBoard中的Section中的cell个数大于代码中的设置个数  要不然会出现崩溃
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 8
        }
        return super.tableView(tableView, numberOfRowsInSection: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "myCell"
        if indexPath.section == 1 {
            var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
            if cell == nil {
                cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
            }
            cell?.textLabel?.text = "123"
            return cell!
        }
        return super.tableView(tableView, cellForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 50
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
}
