//
//  DynamicHeightVC.swift
//  ZJTest
//
//  Created by 庄记 on 2017/3/1.
//  Copyright © 2017年 庄记. All rights reserved.
//

import UIKit

class DynamicHeightVC: UITableViewController {
    
    var dataArray: [String] = ["Dynamic Property Height","Dynamic Property Height","Dynamic Property Height","Dynamic Property Height Dynamic Property Height Dynamic Property Height","Dynamic Property Height Dynamic Property Height Dynamic Property Height"]
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib.init(nibName: "DynamicHeightCell", bundle: nil), forCellReuseIdentifier: "cellID")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cellID") as! DynamicHeightCell
        cell.config(self.dataArray[indexPath.row])
        let height = cell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        return height
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "cellID"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! DynamicHeightCell
        
        cell.config(self.dataArray[indexPath.row])
        return cell
    }
    
}
