//
//  UISearchController.swift
//  ZJTest
//
//  Created by 庄记 on 2017/2/21.
//  Copyright © 2017年 庄记. All rights reserved.
//

import UIKit

class SearchController : UIViewController {
    /*
        UISearchController iOS 8.0以后出现的 之前是UISearchBar + UISearchDisplayController
        导航栏隐藏后高度少20
     */
    var searchController : UISearchController?
    var tableView : UITableView?
    lazy var searchList : [String]? = {
        return [String]()
    }()
    lazy var data = {
        return ["国服第一臭豆腐 No.1 Stinky Tofu CN.",
                 "瓦洛兰 Valoran",
                  "德玛西亚 Demacia",
                   "诺克萨斯 Noxus",
                    "艾欧尼亚 Ionia",
                     "皮尔特沃夫 Piltover",
                      "弗雷尔卓德 Freijord",
                       "班德尔城 Bandle City",
                        "战争学院 The Institute of War",
                         "祖安 Zaun",
                          "卡拉曼达 Kalamanda",
                           "蓝焰岛 Blue Flame Island",
                            "哀嚎沼泽 Howling Marsh",
                             "艾卡西亚 Icathia",
                              "铁脊山脉 Ironspike Mountains",
                               "库莽古丛林 Kumungu",
                                "洛克法 Lokfar",
                                 "摩根小道 Morgon Pass",
                                  "塔尔贡山脉 Mountain Targon",
                                   "瘟疫丛林 Plague Jungles",
                                    "盘蛇河 Serpentine River",
                                     "恕瑞玛沙漠 Shurima Desert",
                                      "厄尔提斯坦 Urtistan",
                                       "巫毒之地 Voodoo Lands",
                                        "水晶之痕 Crystal Scar",
                                         "咆哮深渊 Howling Abyss",
                                          "熔岩洞窟 Magma Chambers",
                                           "试炼之地 Proving Grounds",
                                            "召唤师峡谷 Summoner's Rift",
                                             "扭曲丛林 Twisted Treeline"]
    }()
    override func viewDidLoad() {
        initMysearchBarController()
    }
    
    func initMysearchBarController() {
        self.definesPresentationContext = true
        self.title = "LOL列表"
        self.tableView = UITableView(frame: CGRect(x: 0 , y: 0 , width: screenWidth , height: screenHeight), style: .plain)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.separatorStyle = .none
        self.tableView?.backgroundColor = UIColor.rgbColor(242, green: 242, blue: 242)
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController?.delegate = self
        self.searchController?.searchResultsUpdater = self
        self.searchController?.searchBar.barTintColor = UIColor.rgbColor(242, green: 242, blue: 242)
        self.searchController?.dimsBackgroundDuringPresentation = false
        self.searchController?.hidesNavigationBarDuringPresentation = true
        self.searchController?.searchBar.frame = CGRect(x: (self.searchController?.searchBar.frame.origin.x)!, y: 20, width: screenWidth, height: 44.0)
        self.tableView?.tableHeaderView = self.searchController?.searchBar
        self.view.addSubview(self.tableView!)
    }
}

extension SearchController: UITableViewDelegate {
}

extension SearchController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.searchController?.isActive)! ? (self.searchList?.count)! : self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "cellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        cell?.textLabel?.text = (self.searchController?.isActive)! ? self.searchList?[indexPath.row] : self.data[indexPath.row]
        return cell!
    }
}

extension SearchController: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
        self.navigationController?.navigationBar.isTranslucent = true
        print("will")
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        print("did")
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        self.navigationController?.navigationBar.isTranslucent = false
        print("willDis")
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        print("didDis")
    }
    
    func presentSearchController(_ searchController: UISearchController) {
        print("present")
    }
}

extension SearchController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.edgesForExtendedLayout = .all
        self.searchController?.searchBar.showsCancelButton = true
        let btn = self.searchController?.searchBar.value(forKey: "cancelButton") as? UIButton
        if (btn != nil) {
            btn?.setTitle("取消", for: .normal)
        }
        let searchString = self.searchController?.searchBar.text
//        let preicate = NSPredicate(format: "SELF CONTAINS[c] "+searchString!, argumentArray: nil)
        if self.searchList != nil {
            self.searchList?.removeAll()
        }
        //过滤数据
        self.searchList = self.data.filter({ a -> Bool in
            return a.contains(searchString!)
        })
        self.tableView?.reloadData()
    }
}
