//
//  ConfirmCodeViewController.swift
//  Auction
//
//  Created by Q on 24/11/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import UIKit
import PinCodeTextField
import FullMaterialLoader

class ConfirmCodeViewController: UIViewController, ConfirmCodeViewProtocol, CustomKeyboardButtonDelegate, UITextFieldDelegate, PinCodeTextFieldDelegate {
    
    @IBOutlet var confirmTextField: PinCodeTextField!
    
    var presenter: ConfirmCodePresenterProtocol?
    var customKeyboard = CustomKeyboard()
    let codeDict: [String: Any] = [:]
    var posX: CGFloat = 0.0
    var result = String()
    var newString = String()
    var i = 0
    var understrokeView = UIView()
    var defaults = UserDefaults()
    var indicator = MaterialLoadingIndicator()
    var indicatorBackgroundView = UIView()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        confirmTextField.becomeFirstResponder()
        
        customKeyboard.showKeyboard()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaults = UserDefaults.standard
        
        confirmTextField.delegate = self
        confirmTextField.inputView = UIView()

        self.createCustomKeyboard()
        
        self.createIndicator()
    }

    func userIdReceived(userID: [String: Any]) {
        let accountDict: [String: Any] = ["username" : self.defaults.object(forKey: "email") as Any,
                                                    "password" : self.defaults.object(forKey: "password") as Any]
        
        self.presenter?.interactor?.getToken(accountDictionary: accountDict)
    }
    
    func showRegisterError() {
        indicator.stopAnimating()
        indicator.removeFromSuperview()
        indicatorBackgroundView.removeFromSuperview()
        self.view.isUserInteractionEnabled = true
        
        let alertViewController = UIAlertController.init(title: "Invalid code", message: "Please try again", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertViewController.addAction(action)
        self.present(alertViewController, animated: true, completion: nil)
        
        confirmTextField.text = ""
        confirmTextField.becomeFirstResponder()
        customKeyboard.showKeyboard()
        
        i = 0
        newString = ""
    }
    
    func hasLoggedIn(tokenDict: [String: Any]) {
        indicator.stopAnimating()
        indicator.removeFromSuperview()
        indicatorBackgroundView.removeFromSuperview()
        self.view.isUserInteractionEnabled = true
        
        for (key, value) in tokenDict {
            if (key == "token") {
                self.defaults.set(value, forKey: "token")
            }
        }
        
        if ((defaults.object(forKey: "token")) != nil) {
            self.dismiss(animated: true)
        } else {
            showRegisterError()
        }
    }
    
    // MARK: Custom keyboard delegate
    func numericButtonPressed(sender: String) {
        while i < 4 {
            let index = newString.index((newString.startIndex), offsetBy: i)
            let end = newString.index(newString.startIndex, offsetBy: i);
            result = newString.replacingCharacters(in: index..<end, with: sender)
            newString.append(result.last!)
            confirmTextField.text = newString
            i = i + 1
            break
        }
    }
    
    func doneButtonPressed() {
        self.view.addSubview(indicatorBackgroundView)
        self.view.addSubview(indicator)
        indicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        
        confirmTextField.resignFirstResponder()
        customKeyboard.hideKeyboard()
        
        let tokenString = confirmTextField.text
        
        guard let tokenCode = tokenString, !tokenCode.isEmpty else {
            return
        }
        
        let dict: [String: Any] = ["country_code" : defaults.object(forKey: "code") as Any,
                                             "phone_number" : defaults.object(forKey: "phone") as Any,
                                             "username" : defaults.object(forKey: "email") as Any,
                                             "password" : defaults.object(forKey: "password") as Any,
                                             "confirm_password" : defaults.object(forKey: "confirm") as Any,
                                             "token_code" : tokenCode]
        print(dict)
        self.presenter?.interactor?.validateAccount(userDictionary: dict)
    }
    
    func removeButtonPressed() {
        while i > 0 {
            newString.removeLast()
            confirmTextField.text = newString
            i = i - 1
            break
        }
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
    

    //MARK: UITextField delegate
    private func textField(_ textField: PinCodeTextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let length = (textField.text?.count)! - range.length + string.count
        if length > 0 {
            print(length)
        } else {
            print(length)
        }
        return true
        
        
        
//        if (textField.text?.count == 4) {
//            confirmTextField.resignFirstResponder()
//            customKeyboard.hideKeyboard()
//
//            let tokenString = confirmTextField.text
//
//            guard let tokenCode = tokenString, !tokenCode.isEmpty else {
//                return true
//            }
//
//            let dict: [String: Any] = ["country_code" : defaults.object(forKey: "code") as Any,
//                                                "phone_number" : defaults.object(forKey: "phone") as Any,
//                                                "username" : defaults.object(forKey: "email") as Any,
//                                                "password" : defaults.object(forKey: "password") as Any,
//                                                "confirm_password" : defaults.object(forKey: "confirm") as Any,
//                                                "token_code" : tokenCode]
//            print(dict)
//            self.presenter?.interactor?.validateAccount(userDictionary: dict)
//        }
//        return true
    }
    
    func textFieldDidBeginEditing(_ textField: PinCodeTextField) {
    
    }
    
    func textFieldValueChanged(_ textField: PinCodeTextField) {
        if (textField.text?.count == 4) {
            let value = textField.text ?? ""
            print("value changed: \(value)")
        }
    }
    
    func textFieldShouldEndEditing(_ textField: PinCodeTextField) -> Bool {
        if (textField.text?.count == 4) {
            print("value changed")
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: PinCodeTextField) -> Bool {
        print("value changed")
        return true
    }
}
