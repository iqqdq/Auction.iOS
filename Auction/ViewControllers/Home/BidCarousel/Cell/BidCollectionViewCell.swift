//
//  BidCollectionViewCell.swift
//  Auction
//
//  Created by Q on 11/01/2019.
//  Copyright © 2019 Oxbee. All rights reserved.
//

import UIKit

class BidCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var insideView: UIView!
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var bidsCount: UILabel!
    @IBOutlet var retailLabel: UILabel!
    @IBOutlet var bottomView: UIView!
    @IBOutlet var botView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        backgroundImage.layer.masksToBounds = true
        backgroundImage.layer.cornerRadius = 10.0
    }

}
