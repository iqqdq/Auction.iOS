//
//  ItemWithButtonCell.swift
//  Auction
//
//  Created by Q on 18/10/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import UIKit

protocol CellButtonDelegate {
    func openItemPageViewController()
    func cellStarButton(_ sender: UIButton)
}

class ItemWithButtonCell: UITableViewCell {
    
    var delegate: CellButtonDelegate!

    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet var starButton: UIButton!
    @IBOutlet var title: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var bets: UILabel!
    @IBOutlet var itemImage: UIImageView!
    @IBOutlet var itemImageHeight: NSLayoutConstraint!
    @IBOutlet var itemImageWidth: NSLayoutConstraint!
    @IBOutlet var buttonWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.insideView.layer.cornerRadius = 10.0
        self.insideView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.insideView.layer.shadowColor = Colours.shadowColor
        self.insideView.layer.shadowOpacity = 1.0
        self.insideView.layer.shadowRadius = 3.0
        
        self.starButton.setImage(UIImage.init(named: "ic_selected_star"), for: .selected)
        
        switch UIScreen.main.nativeBounds.height {
        case 1136: // iPhones_5_5s_5c_SE
            itemImageHeight.constant = 90.0
            buttonWidth.constant = 120.0
        case 1334: //.iPhones_6_6s_7_8
            buttonWidth.constant = 140.0
        case 1792:  //.iPhone_XR
            buttonWidth.constant = 140.0
        case 1920, 2208: //.iPhones_6Plus_6sPlus_7Plus_8Plus
            buttonWidth.constant = 160.0
        case 2436:  //.iPhones_X_XS
            buttonWidth.constant = 140.0
        case 2688://.iPhone_XSMax
            buttonWidth.constant = 160.0
        default:
            break
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func itemPageButtonAction(_ sender: UIButton) {
        self.delegate?.openItemPageViewController()
    }
    
    @IBAction func starButtonAction(_ sender: UIButton) {
        self.delegate?.cellStarButton(sender)
    }
}
