//
//  ItemCollectionViewCell.swift
//  Auction
//
//  Created by Q on 18/10/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import UIKit

protocol CollectionCellButtonDelegate {
    func collectionViewCellStarButton(_ sender: UIButton)
}

class ItemCollectionViewCell: UICollectionViewCell {

    var delegate: CollectionCellButtonDelegate!

    @IBOutlet weak var insideView: UIView!
    @IBOutlet var itemImage: UIImageView!
    @IBOutlet var itemTitle: UILabel!
    @IBOutlet var starButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        self.itemTitle.adjustsFontSizeToFitWidth = true
        
        self.insideView.layer.cornerRadius = 5.0
        self.insideView.layer.borderWidth = 1.0
        self.insideView.layer.borderColor = UIColor.clear.cgColor

        self.insideView.layer.shadowColor = Colours.collectionCellShadowColor
        self.insideView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.insideView.layer.shadowRadius = 3.0
        self.insideView.layer.shadowOpacity = 1.0
        self.insideView.layer.masksToBounds = false
        
        self.starButton.setImage(UIImage.init(named: "ic_selected_star"), for: .selected)
        
        self.layoutIfNeeded()
    }
    
    @IBAction func starButtonAction(_ sender: UIButton) {
        self.delegate?.collectionViewCellStarButton(sender)
    }
}
