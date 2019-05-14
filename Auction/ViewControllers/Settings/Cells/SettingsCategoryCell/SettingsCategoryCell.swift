//
//  SettingsCategoryCell.swift
//  Auction
//
//  Created by Q on 24/10/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import UIKit

class SettingsCategoryCell: UITableViewCell {

    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var languageButton: UIButton!
    @IBOutlet weak var currencyButton: UIButton!
    @IBOutlet var notificationSwitch: UISwitch!
    @IBOutlet var logoutButton: UIButton!
    @IBOutlet var languageLabel: UILabel!
    @IBOutlet var currencyLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.insideView.layer.cornerRadius = 10.0
        self.insideView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.insideView.layer.shadowColor = Colours.shadowColor
        self.insideView.layer.shadowOpacity = 1.0
        self.insideView.layer.shadowRadius = 3.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
