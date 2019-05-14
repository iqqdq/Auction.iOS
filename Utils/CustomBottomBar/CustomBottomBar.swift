//
//  CustomBottomBar.swift
//  Auction
//
//  Created by Q on 19/10/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import UIKit
import CountdownLabel

class CustomBottomBar: UIView {
    
    var overlayView = UIView()
    var middleButton = UIButton()
    var timerLabel = UILabel()
    var circleLayer = CAShapeLayer()
    var barHeight: CGFloat = 64.0
    var buttonInset: CGFloat = 0.0

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)

        //Adding shadow to bar
        self.layer.shadowColor = Colours.customBottomBarColor
        self.layer.shadowOpacity = 0.9
        self.layer.shadowRadius = 8.0
        self.layer.shadowOffset = CGSize(width: 0, height: -2)
        
        self.createOverlay(frame: frame, xOffset: frame.midX,  yOffset: 0.0, radius: frame.size.height/2)
        
        self.createMiddleButton()
    }
    
    public convenience init(image: UIImage, title: String) {
        self.init(frame: .zero)
    }
    
    func createOverlay(frame: CGRect,
                       xOffset: CGFloat,
                       yOffset: CGFloat,
                       radius: CGFloat) {
        //Adding barView
        overlayView.frame = frame
        overlayView.backgroundColor = UIColor.white.withAlphaComponent(1.0)
        
        //Adding CornerRadius
        overlayView.layer.cornerRadius = 20.0
        
        let path = CGMutablePath()
        path.addArc(center: CGPoint(x: xOffset, y: yOffset),
                    radius: radius,
                startAngle: 0.0,
                  endAngle: 2.0 * .pi,
                 clockwise: false)
        path.addRect(CGRect(origin: .zero, size: overlayView.frame.size))
        
        let maskLayer = CAShapeLayer()
        maskLayer.backgroundColor = UIColor.white.cgColor
        maskLayer.path = path
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        
        overlayView.layer.mask = maskLayer
        overlayView.clipsToBounds = true
        overlayView.isUserInteractionEnabled = false
        overlayView.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height*2)
        
        self.addSubview(overlayView)
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseInOut], animations: {
            self.overlayView.center = CGPoint(x: UIScreen.main.bounds.width/2,
                                              y: UIScreen.main.bounds.height - self.overlayView.frame.height/2)
        }, completion: nil)
    }
    
    func createMiddleButton() {
        
        if (UIScreen.main.nativeBounds.height > 1500.0) {
            barHeight = 84.0
        }
        
        buttonInset = barHeight/6
        let buttonSize = barHeight - buttonInset
        
        let buttonPosX = UIScreen.main.bounds.width/2 - buttonSize/2
        let buttonPosY = UIScreen.main.bounds.height - barHeight 
        let xPoint = UIScreen.main.bounds.size.width/2
        
        //Create middle button
        middleButton = UIButton(frame: CGRect(x: buttonPosX,
                                              y: UIScreen.main.bounds.height*2,
                                          width: buttonSize,
                                         height: buttonSize))
        
        middleButton.layer.cornerRadius = buttonSize/2
        middleButton.backgroundColor = .white
        middleButton.setImage(UIImage(named: "ic_dollar_blue"), for: .normal)
        middleButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFill
        
        self.addSubview(middleButton)
        
        UIView.animate(withDuration: 1.5, delay: 0.0, options: [.curveEaseInOut], animations: {
            self.middleButton.center = CGPoint(x: xPoint, y: buttonPosY)
        }, completion: nil)
    }
    
    func setMiddleButtonBlue() {
        timerLabel.isHidden = true
        middleButton.backgroundColor = Colours.mainBlueColor
        middleButton.setImage(UIImage(named: "ic_dollar_white"), for: .normal)
    }
    
    func setMiddleButtonOkBlue() {
        timerLabel.isHidden = true
        middleButton.backgroundColor = Colours.mainBlueColor
        middleButton.setImage(UIImage(named: "ic_ok"), for: .normal)
    }
    
    func setCircleLayer() {
        let radius = (middleButton.frame.size.height + buttonInset)/2
        circleLayer.strokeColor = Colours.mainBlueColor.cgColor
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineWidth = radius
        self.layer.addSublayer(circleLayer)
        
        let center = middleButton.center
        let startAngle: CGFloat = -0.25 * 2 * .pi
        let endAngle: CGFloat = startAngle + 2 * .pi
        circleLayer.path = UIBezierPath(arcCenter: center, radius: radius / 2, startAngle: startAngle, endAngle: endAngle, clockwise: true).cgPath
        circleLayer.strokeEnd = 0
        circleLayer.strokeEnd = 1
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 1
        animation.toValue = 0
        animation.duration = 30
        circleLayer.add(animation, forKey: nil)
        
        //Adding Time Label
        middleButton.backgroundColor = .white
        middleButton.setImage(nil, for: .normal)
        
        middleButton.addSubview(timerLabel)
        
        self.bringSubviewToFront(middleButton)
        self.bringSubviewToFront(timerLabel)
    }
}

