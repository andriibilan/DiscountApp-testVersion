//
//  TableViewCell.swift
//  DiscountApp
//
//  Created by andriibilan on 10/30/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {


    @IBOutlet weak var imagePrototype: UIImageView!
    @IBOutlet weak var name: UILabel?
    @IBOutlet weak var cardDescription: UILabel?
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//      setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
