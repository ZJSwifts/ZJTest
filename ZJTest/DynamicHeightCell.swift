//
//  DynamicHeightCell.swift
//  ZJTest
//
//  Created by 庄记 on 2017/3/1.
//  Copyright © 2017年 庄记. All rights reserved.
//

import UIKit

class DynamicHeightCell: UITableViewCell {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func config(_ str: String) {
        self.label1.text = str
        self.label2.text = str
    }
}
