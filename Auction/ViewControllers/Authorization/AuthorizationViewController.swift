//
//  AuthorizationViewController.swift
//  Auction
//
//  Created by Q on 29/10/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import UIKit
import FullMaterialLoader

class AuthorizationViewController: UIViewController, AuthorizationViewProtocol, AnimateButtonDelegate, UITextFieldDelegate {
    
    @IBOutlet var backgroundImageWidth: NSLayoutConstraint!
    @IBOutlet var backgroundImageHeight: NSLayoutConstraint!
    @IBOutlet var contentView: UIView!
    @IBOutlet var emailView: UIView!
    @IBOutlet var passwordView: UIView!
    @IBOutlet var eyeImage: UIImageView!
    @IBOutlet var eyeAppleImage: UIImageView!
    @IBOutlet var signInButton: UIButton!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginErrorLabel: UILabel!
    @IBOutlet var viewCenterPos: NSLayoutConstraint!
    
    var presenter: AuthorizationPresenterProtocol?
    
    var animationView = AuthAnimationView()
    var placeholderTextColor = Colours.placeholderTextColor
    var indicator = MaterialLoadingIndicator()
    var indicatorBackgroundView = UIView()
    var isPasswordTextShown = false

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        backgroundImageWidth.constant = UIScreen.main.bounds.width/1.3
        backgroundImageHeight.constant = UIScreen.main.bounds.height/1.275
        
        switch UIScreen.main.nativeBounds.height {
        case 1136:  //.iPhones_5_5s_5c_SE
            viewCenterPos.constant = -135.0
        default:
            viewCenterPos.constant = -146.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.addAnimationView()
        
        self.createIndicator()
        
        self.setLayerParams(view: emailView)
        self.setLayerParams(view: passwordView)
    }
    
    func hasLoggedIn(token: [String: Any]) {
        indicator.stopAnimating()
        indicator.removeFromSuperview()
        indicatorBackgroundView.removeFromSuperview()
        self.view.isUserInteractionEnabled = true
        
        for (key, value) in token {
            if (key == "token") {
                UserDefaults.standard.set(value, forKey: "token")
            }
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "TokenRecieved"), object: nil)
        
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    func showAuthError() {
        indicator.stopAnimating()
        indicator.removeFromSuperview()
        indicatorBackgroundView.removeFromSuperview()
        self.view.isUserInteractionEnabled = true
        self.view.endEditing(true)
        
        UIView.animate(withDuration: 1.0, animations: {
            self.loginErrorLabel.alpha = 1.0
        })
    }
    
    // MARK: Button Actions
    
    @IBAction func signInButtonAction(_ sender: Any) {
        if ((emailTextField.text?.isEmpty)!) {
            emailTextField.attributedPlaceholder = NSAttributedString(string: "Your e-mail adress",
                                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            return
        }

        if ((passwordTextField.text?.isEmpty)!) {
            passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            return
        }

        self.view.endEditing(true)

        self.view.addSubview(indicatorBackgroundView)
        self.view.addSubview(indicator)
        indicator.startAnimating()
        self.view.isUserInteractionEnabled = false

        guard let emailParameter = emailTextField.text else {
            return
        }

        guard let passwordParameter = passwordTextField.text else {
            return
        }

        let accountDict: [String: Any] = ["username" : emailParameter,
                                          "password" : passwordParameter]

        self.presenter?.interactor?.getToken(accountDictionary: accountDict)
    }
    
    @IBAction func signUpButtonAction(_ sender: Any) {
        let registrationViewController = RegistrationRouter.createModule()
        self.navigationController?.pushViewController(registrationViewController, animated: true)
    }
    
    @IBAction func eyeImageAction(_ sender: Any) {
        if (isPasswordTextShown == false) {
            passwordTextField.isSecureTextEntry = false
            isPasswordTextShown = true
            self.eyeAppleImage.alpha = 1.0
            
        } else {
            passwordTextField.isSecureTextEntry = true
            isPasswordTextShown = false
            self.eyeAppleImage.alpha = 0.0
        }
    }
    
    @IBAction func endEditingGesture(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    func addAnimationView() {
        animationView = AuthAnimationView(frame: UIScreen.main.bounds)
        animationView.delegate = self
        self.view.addSubview(animationView)
    }
    
    func animateAction() {
        //Hide AuthAnimationView button
        animationView.isUserInteractionEnabled = false
        animationView.animateButton.removeFromSuperview()
        
        //Show contentView after AuthAnimationView will disappear
        UIView.animate(withDuration: 0.7, animations: {
            self.contentView.alpha = 1.0
        })
        
        //Password textfield eye appearance
        UIView.animate(withDuration: 0.5, delay: 1.5, options: [.curveEaseInOut], animations: {
            self.eyeAppleImage.alpha = 1.0
            self.eyeAppleImage.center = self.eyeImage.center
        }, completion: nil)
    }
    
    //MARK: TextField delegate
    private func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.animateTextField(textField: textField, up: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.animateTextField(textField: textField, up: false)
    }
    
    func setLayerParams(view: UIView) {
        view.layer.cornerRadius = view.frame.height/2
        view.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        view.layer.shadowColor = Colours.shadowColor
        view.layer.shadowOpacity = 1.0
        view.layer.shadowRadius = 20.0
        
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Your email address",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: placeholderTextColor])
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: placeholderTextColor])
    }
    
    func createIndicator() {
        let viewSide: CGFloat = UIScreen.main.bounds.width/4
        let center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
        indicatorBackgroundView = .init(frame: CGRect(x: 0.0, y: 0.0, width: viewSide, height: viewSide))
        indicatorBackgroundView.center = center
        indicatorBackgroundView.backgroundColor = Colours.mainBlueColor
        indicatorBackgroundView.layer.opacity = 0.8
        indicatorBackgroundView.layer.cornerRadius = 10.0
        
        let indicatorSide: CGFloat = viewSide - viewSide/4
        indicator = MaterialLoadingIndicator(frame: CGRect(x: 0.0, y: 0.0, width: indicatorSide, height: indicatorSide))
        indicator.indicatorColor = [UIColor.white.cgColor]
        indicator.center = center
    }
    
    func animateTextField(textField: UITextField, up: Bool) {
        let movementDistance   = -156.0 // tweak as needed
        let movementDuration = 0.5 // tweak as needed
    
        let movement = (up ? movementDistance : -movementDistance)
    
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: CGFloat(movement))

        UIView.commitAnimations()
    }
}
