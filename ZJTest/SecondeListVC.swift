//
//  SecondeListVC.swift
//  ZJTest
//
//  Created by 庄记 on 2017/8/31.
//  Copyright © 2017年 庄记. All rights reserved.
//

import UIKit

class SecondeListVC: UITableViewController {
    
    lazy var data = {
        return ["1","2","3","4","5","6"]
    }()
    var index:Int? = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.data.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.index == section ? self.data.count : 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44;
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 40))
        view.tag = section;
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        label.text = data[section]
        view.addSubview(label)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tap(gesture:))))
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var  cell = tableView.dequeueReusableCell(withIdentifier: "cellId")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
        }
        cell?.textLabel?.text = self.data[indexPath.row]
        return cell!
    }
    
    func tap(gesture: UIGestureRecognizer) {
        if gesture.view?.tag == index {
            self.index = -1
        } else {
            self.index = gesture.view?.tag
        }
        self.tableView.reloadData()
    }
}
