//
//  CustomModalView.swift
//  Auction
//
//  Created by Q on 23/10/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import UIKit

class CustomModalView: UIView {
    
    let coefWidth: CGFloat = 1.09
    let coefHeight: CGFloat = 1.43
    
    let imgCoefWidth: CGFloat = 1.08
    let imgCoefHeight: CGFloat = 2.19
    
    let animateImgCoefWidth: CGFloat = 2.6
    let animateImgCoefHeight: CGFloat = 1.3
    
    var backgroundView = UIView()
    var modalView = UIView()
    var backgroundImage = UIImageView()
    var backgroudnDynamicImage = UIImageView()
    var animateImage = UIImageView()
    
    var button = UIButton()
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initLayers()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)

        initLayers()
    }
    
    func initLayers() {
        //Background view
        let width: CGFloat = UIScreen.main.bounds.width/coefWidth
        let height: CGFloat = UIScreen.main.bounds.height/coefHeight
        
        let xPos: CGFloat = UIScreen.main.bounds.width/2 - width/2
        let yPos: CGFloat = UIScreen.main.bounds.height*2
        
        backgroundView = UIView.init(frame: UIScreen.main.bounds)
        backgroundView.backgroundColor = Colours.modalBehindViewColor
        
        //Modal view
        modalView = .init(frame:CGRect(x: xPos, y: yPos, width: width, height: height))
        modalView.backgroundColor = .white
        modalView.layer.cornerRadius = 10.0
        
        
        //Background image
        let imageWidth: CGFloat = modalView.frame.width/imgCoefWidth
        let imageHeight: CGFloat = modalView.frame.height/imgCoefHeight
        
        let imagePosX: CGFloat = modalView.frame.size.width/2 - imageWidth/2
        let imagePosY: CGFloat = -modalView.frame.size.height/2.5 + imageHeight
        
        backgroundImage = UIImageView.init(frame: CGRect(x: imagePosX, y: imagePosY, width: imageWidth, height: imageHeight))
        backgroundImage.contentMode = .scaleAspectFit
        backgroundImage.image = UIImage.init(named: "modal_bg_oval")
        
        modalView.addSubview(backgroundImage)
        
        //Dynamic Image
        backgroudnDynamicImage = .init(frame: backgroundImage.frame)
        backgroudnDynamicImage.contentMode = .scaleAspectFit
        backgroudnDynamicImage.image = UIImage.init(named: "modal_stars")
        backgroudnDynamicImage.alpha = 0.0
        
        modalView.addSubview(backgroudnDynamicImage)
        
        
        let animateImageWidth = imageWidth/2.3
        let animateImageHeight = imageHeight
        
        animateImage = .init(frame: CGRect(x: modalView.frame.size.width/2 - animateImageWidth/2,
                                           y: -20,
                                           width: animateImageWidth,
                                           height: animateImageHeight))
        animateImage.contentMode = .scaleAspectFit
        animateImage.image = UIImage.init(named: "modal_won_man")
        
        modalView.addSubview(animateImage)
        
        
        //Adding Label
        let labelWidth: CGFloat = modalView.frame.width - 20.0
        let labelHeight: CGFloat = 140.0
        
        let label = UILabel.init(frame:CGRect(x: modalView.frame.width/2 - labelWidth/2,
                                              y: modalView.frame.height/2,
                                          width: labelWidth,
                                         height: labelHeight))
        label.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 1)
        label.font = UIFont(name: "Exo2.0-Medium", size: 24)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center

        let attributedString = NSMutableAttributedString(string:"")
        
        let firstLine = "Congratulations!\n"
        let firstLineAttribute = [ NSAttributedString.Key.font: UIFont(name: label.font.fontName, size: 24.0)!]
        let secondLine = "You have won an action.\n"
        let secondLineAttribute = [NSAttributedString.Key.font : UIFont(name: label.font.fontName, size: 18)!]
        let thirdLine = "You can see your items \nat the profile"
        let thirdLineAttribute = [NSAttributedString.Key.font : UIFont(name: "Exo2.0-Regular", size: 15)!]

        let newAttributedFirstLine: NSAttributedString = NSAttributedString(string: firstLine, attributes: firstLineAttribute)
        let newAttributedSecondLine: NSAttributedString = NSAttributedString(string: secondLine, attributes: secondLineAttribute)
        let newAttributedThirdLine: NSAttributedString = NSAttributedString(string: thirdLine, attributes: thirdLineAttribute)

        attributedString.append(newAttributedFirstLine)
        attributedString.append(newAttributedSecondLine)
        attributedString.append(newAttributedThirdLine)
        
        label.attributedText = attributedString
        
        modalView.addSubview(label)

        
        //OK Button
        let buttonMargin = modalView.frame.width/9.0
        let buttonWidth = modalView.frame.width - buttonMargin
        let buttonHeight = buttonWidth/6.5
        
        let buttonPosX = modalView.frame.width/2 - buttonWidth/2
        let buttonPosY = modalView.frame.height - (buttonHeight + buttonHeight/2)
        
        button = .init(frame: CGRect(x: buttonPosX, y: buttonPosY, width: buttonWidth, height: buttonHeight))
        button.backgroundColor = Colours.mainBlueColor
        button.layer.cornerRadius = buttonHeight/2
        button.setTitle("OK!", for: .normal)
        button.titleLabel?.font = UIFont(name: "Exo2.0-Medium", size: 20.0)
        
        modalView.addSubview(button)
        
        backgroundView.addSubview(modalView)
        
        addSubview(backgroundView)

        showModalView()
    }
    
    func showModalView() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseInOut], animations: {
                        self.modalView.center = CGPoint(x: UIScreen.main.bounds.width/2,
                                                        y: UIScreen.main.bounds.height/2)
        }, completion: { finished in
                        self.secondAnimation()
        })
    }
    

    func secondAnimation() {
        UIView.animate(withDuration: 1.0, animations: {
            self.backgroudnDynamicImage.alpha = 1.0
            self.animateImage.center = CGPoint(x: self.modalView.frame.size.width/2,
                                               y: self.animateImage.center.y + self.animateImage.frame.height/10)
        })
    }

}
