//
//  RegistrationViewController.swift
//  Auction
//
//  Created by Q on 24/11/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import UIKit
import FullMaterialLoader

class RegistrationViewController: UIViewController, RegistrationViewProtocol, CustomKeyboardButtonDelegate, UITextFieldDelegate {
    
    
    @IBOutlet var backgroundImageWidth: NSLayoutConstraint!
    @IBOutlet var backgroundImageHeight: NSLayoutConstraint!
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmTextField: UITextField!
    
    @IBOutlet var phoneView: UIView!
    @IBOutlet var emailView: UIView!
    @IBOutlet var passwordView: UIView!
    @IBOutlet var confirmView: UIView!
    @IBOutlet var positionConstraint: NSLayoutConstraint!
    
    var presenter: RegistrationPresenterProtocol?

    var defaults = UserDefaults()
    var customKeyboard = CustomKeyboard()
    var result = String()
    var newString: String = "+"
    var indicator = MaterialLoadingIndicator()
    var indicatorBackgroundView = UIView()

    override var prefersStatusBarHidden: Bool {
        return true
    }
        
    override func viewWillAppear(_ animated: Bool) {
        if ((defaults.object(forKey: "token")) != nil) {
            self.navigationController?.popToRootViewController(animated: false)
        }
        
        backgroundImageWidth.constant = UIScreen.main.bounds.width/1.3
        backgroundImageHeight.constant = UIScreen.main.bounds.height/1.275
        
        switch UIScreen.main.nativeBounds.height {
        case 1136:  //.iPhones_5_5s_5c_SE
            positionConstraint.constant = -242.0
        default:
            positionConstraint.constant = -120.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaults = UserDefaults.standard
        
        self.createCustomKeyboard()
        
        phoneTextField.inputView = UIView()
        
        self.setLayerParams(view: phoneView)
        self.setLayerParams(view: emailView)
        self.setLayerParams(view: passwordView)
        self.setLayerParams(view: confirmView)
        
        self.createIndicator()
    }
    
    func messageReceived(message: [String: Any]) {
        let status: Bool = (message["status"] != nil)
        if (status == true) {
            let confirmCodeViewController = ConfirmCodeRouter.createModule()
            self.present(confirmCodeViewController, animated: true)
        }
        indicator.stopAnimating()
        indicator.removeFromSuperview()
        indicatorBackgroundView.removeFromSuperview()
        self.view.isUserInteractionEnabled = true
    }
    
    func showMessageError() {
        indicator.stopAnimating()
        indicator.removeFromSuperview()
        indicatorBackgroundView.removeFromSuperview()
        self.view.isUserInteractionEnabled = true
        
        phoneTextField.text = ""
        phoneTextField.attributedPlaceholder = NSAttributedString(string: "Incorrect phone number format",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        
        if (phoneTextField.text == "") {
            phoneTextField.attributedPlaceholder = NSAttributedString(string: "Required field",
                                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        } else if (emailTextField.text == "") {
            emailTextField.attributedPlaceholder = NSAttributedString(string: "Required field",
                                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        } else if (passwordTextField.text == "") {
            passwordTextField.attributedPlaceholder = NSAttributedString(string: "Required field",
                                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        } else if (confirmTextField.text == "") {
            confirmTextField.attributedPlaceholder = NSAttributedString(string: "Required field",
                                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        } else {
            
            if (phoneTextField.text?.count != 18) {
                phoneTextField.text = ""
                phoneTextField.attributedPlaceholder = NSAttributedString(string: "Incorrect phone number format",
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                return
            }
            
            if ((emailTextField.text?.range(of:"@") == nil) == true || (emailTextField.text?.range(of:".") == nil) == true) {
                emailTextField.text = ""
                emailTextField.attributedPlaceholder = NSAttributedString(string: "Incorrect email address format",
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                return
            }
            
            if (passwordTextField.text != confirmTextField.text || passwordTextField.text == "" || confirmTextField.text == "") {
                confirmTextField.text?.removeAll()
                confirmTextField.attributedPlaceholder = NSAttributedString(string: "Doesn't match",
                                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                return
            }
            
            let textString = self.phoneTextField.text?.replacingOccurrences( of:"[^0-9]", with: "", options: .regularExpression)
            
            let phoneCodeString = (textString?.prefix(1))
            
            let phoneString = textString?.dropFirst()
            
            defaults.set(phoneCodeString, forKey: "code")
            defaults.set(phoneString, forKey: "phone")
            defaults.set(emailTextField.text, forKey: "email")
            defaults.set(passwordTextField.text, forKey: "password")
            defaults.set(confirmTextField.text, forKey: "confirm")
            
            guard let countryCode = phoneCodeString, !countryCode.isEmpty else {
                return
            }
            guard let phoneNumber = phoneString, !phoneNumber.isEmpty else {
                return
            }
            
            let dict: [String: Any] = ["country_code" : countryCode,
                                       "phone_number" : phoneNumber]
            
            self.presenter?.interactor?.registerAccount(phoneDictionary: dict)
            
            self.view.addSubview(indicatorBackgroundView)
            self.view.addSubview(indicator)
            indicator.startAnimating()
            self.view.isUserInteractionEnabled = false
        }
    }
    
    //MARK: TextField delegate
    private func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == phoneTextField) {
            phoneTextField.text = newString
            customKeyboard.showKeyboard()
        } else {
            customKeyboard.hideKeyboard()
            self.animateTextField(textField: textField, up: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField == phoneTextField)
        {
            if (phoneTextField.text == "+") {
                phoneTextField.text = ""
            }
            customKeyboard.hideKeyboard()
        } else {
            self.animateTextField(textField: textField, up: false)
        }
    }
    

    func setLayerParams(view: UIView) {
        view.layer.cornerRadius = view.frame.height/2
        view.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        view.layer.shadowColor = Colours.shadowColor
        view.layer.shadowOpacity = 1.0
        view.layer.shadowRadius = 20.0
        
        phoneTextField.attributedPlaceholder = NSAttributedString(string: "Your phone number",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: Colours.placeholderTextColor])
        
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Your email address",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: Colours.placeholderTextColor])
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: Colours.placeholderTextColor])
        
        confirmTextField.attributedPlaceholder = NSAttributedString(string: "Confirm password",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: Colours.placeholderTextColor])
    }
 
    @IBAction func endEditingGesture(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    // Adding custom numeric keyboard
    func createCustomKeyboard() {
        let height: CGFloat = UIScreen.main.bounds.height/1.96
        
        customKeyboard = CustomKeyboard(frame:CGRect(x: 0.0,
                                                     y: UIScreen.main.bounds.height,
                                                     width: UIScreen.main.bounds.width,
                                                     height: height))
        customKeyboard.backgroundColor = .white
        customKeyboard.delegate = self
        self.view.addSubview(customKeyboard)
    }
    
    // MARK: Custom keyboard delegate
    func numericButtonPressed(sender: String) {
        if ((phoneTextField.text?.count)! == 0) {
            newString = "+"
            phoneTextField.text = newString
        }
        
        if ((phoneTextField.text?.count)! > 0 && (phoneTextField.text?.count)! < 18) {
            newString.append(sender)
            phoneTextField.text = newString
        }
        
        switch newString.count {
        case 2:
            newString.append(" (")
        case 7:
            newString.append(") ")
        case 12:
            newString.append("-")
        case 15:
            newString.append("-")
        default:
            break
        }
        
        phoneTextField.text = newString
    }
    
    func doneButtonPressed() {
        self.view.endEditing(true)
        customKeyboard.hideKeyboard()
    }
    
    func removeButtonPressed() {
        if ((phoneTextField.text?.count)! > 2) {
            newString.removeLast()
            phoneTextField.text = newString
        }
        
        switch phoneTextField.text?.count {
        case 2:
            newString = ""
            phoneTextField.text = newString
        case 3:
            newString = ""
            phoneTextField.text = newString
        case 5:
            newString = String(newString.dropLast(2))
        case 10:
            newString = String(newString.dropLast(2))
        case 14:
            newString.removeLast()
        case 17:
            newString.removeLast()
        default:
            break
        }
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
