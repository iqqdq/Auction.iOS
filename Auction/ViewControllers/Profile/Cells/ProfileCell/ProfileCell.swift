//
//  ProfileCell.swift
//  Auction
//
//  Created by Q on 25/10/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var insideView: UIView!
    @IBOutlet var imageBackgroundView: UIView!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var addressTextField: UITextField!
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        self.insideView.layer.cornerRadius = 10.0
        self.insideView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.insideView.layer.shadowColor = Colours.shadowColor
        self.insideView.layer.shadowOpacity = 1.0
        self.insideView.layer.shadowRadius = 10.0
        
        //set shadow to avatar image
        self.imageBackgroundView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        self.imageBackgroundView.layer.shadowColor = Colours.shadowColor
        self.imageBackgroundView.layer.shadowOpacity = 1.0
        self.imageBackgroundView.layer.shadowRadius = 10.0
        
        phoneTextField.becomeFirstResponder()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
