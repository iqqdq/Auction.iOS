//
//  ItemCell.swift
//  Auction
//
//  Created by Q on 21/10/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import UIKit
import ImageSlideshow
import CountdownLabel

class ItemCell: UITableViewCell {

    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var slideShowView: ImageSlideshow!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var timerLabel: CountdownLabel!
    @IBOutlet weak var timerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initLayers()
    }
    
    func initLayers() {
        //Set Shadows
        self.insideView.layer.cornerRadius = 10.0
        self.insideView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.insideView.layer.shadowColor = Colours.shadowColor
        self.insideView.layer.shadowOpacity = 1.0
        self.insideView.layer.shadowRadius = 3.0
        
        self.timerView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.timerView.layer.shadowColor = Colours.shadowColor
        self.timerView.layer.shadowOpacity = 1.0
        self.timerView.layer.shadowRadius = 3.0
        
        //init SlideShow
        let pageIndicator = UIPageControl()
        pageIndicator.currentPageIndicatorTintColor = Colours.currentPageIndicatorColor
        pageIndicator.pageIndicatorTintColor = Colours.pageIndicatorColor
        slideShowView.pageIndicator = pageIndicator
        slideShowView.pageIndicatorPosition = PageIndicatorPosition(horizontal: .center, vertical: .bottom)
        slideShowView.activityIndicator = DefaultActivityIndicator()
        slideShowView.slideshowInterval = 4.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
