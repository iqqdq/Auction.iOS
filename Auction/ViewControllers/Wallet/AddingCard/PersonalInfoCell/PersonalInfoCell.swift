//
//  PersonalInfoCell.swift
//  Auction
//
//  Created by Q on 27/10/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import UIKit

class PersonalInfoCell: UITableViewCell {

    @IBOutlet var insideView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.insideView.layer.cornerRadius = 5.0
        self.insideView.layer.borderWidth = 1.0
        self.insideView.layer.borderColor = UIColor.clear.cgColor
        self.insideView.layer.masksToBounds = true
        
        self.insideView.layer.shadowColor = Colours.collectionCellShadowColor
        self.insideView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.insideView.layer.shadowRadius = 10.0
        self.insideView.layer.shadowOpacity = 1.0
        self.insideView.layer.masksToBounds = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
