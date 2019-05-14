//
//  ProfileViewController.swift
//  Auction
//
//  Created by Q on 18/10/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, ProfileViewProtocol, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topTableViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var customTitle: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet var editButtonTopSpace: NSLayoutConstraint!
    @IBOutlet var largeTitlePosY: NSLayoutConstraint!
    
    var presenter: ProfilePresenterProtocol?
    
    var profileCell = ProfileCell()
    var emptyCell = EmptyCell()
    var profileDict = [String: Any]()
    var cell = ProfileCell()
    var profileModel = ProfileResponse(dictionary: [:])
    var editButtonPathValue: CGFloat = 56.0
    var collectionView: UICollectionView!
    let collectionHeaderView = UIView()
    var collectionViewImageArray = [String]()
    var collectionViewTitleArray = [String]()
    //FAKE
    var firstClick = Bool()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //init tableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "ProfileCell", bundle: nil), forCellReuseIdentifier: "ProfileCell")
        self.tableView.register(UINib(nibName: "EmptyCell", bundle: nil), forCellReuseIdentifier: "EmptyCell")
        
        //init collectionView
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing = 0.0
        
        collectionView = UICollectionView(frame: CGRect(x: 16.0, y: 21.0, width: UIScreen.main.bounds.width - 30.0, height: 647.0), collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceHorizontal = false
        collectionView.isScrollEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        
        collectionView.register(UINib.init(nibName: "ProfileCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProfileCollectionViewCell")
        
        //Adding shadow to collectionView
        collectionView.layer.cornerRadius = 10.0
        collectionView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        collectionView.layer.shadowColor = Colours.shadowColor
        collectionView.layer.shadowOpacity = 1.0
        collectionView.layer.shadowRadius = 10.0
        collectionView.layer.masksToBounds = false
        
        self.editButton.tag = 1
        
        self.setupViews()
        
        collectionViewImageArray = ["ic_profile_auctions",
                                    "ic_profile_buy_bids",
                                    "ic_profile_badges",
                                    "ic_profile_notifications",
                                    "ic_profile_unpaid_wins",
                                    "ic_profile_buyitnow_offers",
                                    "ic_profile_my_orders",
                                    "ic_profile_bidding_history",
                                    "ic_profile_help"]
        
        collectionViewTitleArray = ["Auctions", "Buy Bids", "Badges", "Notifications", "Unpaid Wins", "Buy it now Offers", "My Orders", "Bidding History", "Help"]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        switch UIScreen.main.nativeBounds.height {
        case 1136:  //.iPhones_5_5s_5c_SE
            editButtonTopSpace.constant = 74.0
            largeTitlePosY.constant = 62.0
            editButtonPathValue = 54.0
            self.customTitle.font =  UIFont(name: "Exo2.0-Medium", size: 42.0)
        case 1334:  //.iPhones_6_6s_7_8
            editButtonTopSpace.constant = 74.0
            largeTitlePosY.constant = 62.0
            editButtonPathValue = 54.0
        case 1920, 2208:  //.iPhones_6Plus_6sPlus_7Plus_8Plus
            editButtonTopSpace.constant = 104.0
            largeTitlePosY.constant = 94.0
            editButtonPathValue = 64.0
        default:
            editButtonTopSpace.constant = 104.0
            largeTitlePosY.constant = 94.0
            editButtonPathValue = 64.0
        }
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.presenter?.interactor?.getProfile()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, animations: {
                self.topTableViewConstraint.constant = 0
                self.view.layoutSubviews()
            })
        
            UIView.animate(withDuration: 0.8, animations: {
                self.customTitle.alpha = 1.0
                self.editButton.alpha = 1.0
                self.tableView.alpha = 1.0
            })
        }
    }
    
    func setupViews() {
        let navigationBarHeight: CGFloat = UIScreen.main.bounds.height/2.47037037
        let backgroundImage = UIImageView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: navigationBarHeight))
        backgroundImage.image = UIImage.init(named: "ic_background_profile")
        view.addSubview(backgroundImage)
        view.bringSubviewToFront(self.customTitle)
        view.bringSubviewToFront(self.editButton)
        self.tableView.layer.zPosition = 1000
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.8, animations: {
                self.topTableViewConstraint.constant = 1000.0
                self.view.layoutSubviews()
            })
            
            UIView.animate(withDuration: 0.8, animations: {
                self.tableView.alpha = 0.0
                self.customTitle.alpha = 0.0
                self.editButton.alpha = 0.0
            })
        }
    }
    
    // MARK: API Calls

    func setProfile(profileDictionary: [String: Any]) {
        profileModel = ProfileResponse.init(dictionary: profileDictionary)
        
        self.editButton.setTitle("Edit", for: .normal)
        self.editButton.tag = 1
        self.tableView.reloadData()
    }
    
    @IBAction func editButtonAction(_ sender: Any) {
        self.cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! ProfileCell
        
        if (cell.nameTextField.text != "") {
            UserDefaults.standard.set(cell.nameTextField.text, forKey: "ProfileName")
        }
        
        if (self.editButton.tag == 2) {
            guard let nicknameString = cell.nicknameTextField.text else {
                return
            }
            
            guard let emailString = cell.addressTextField.text else {
                return
            }
            
            guard let phoneString = cell.phoneTextField.text else {
                return
            }
            
            let profileDict: [String: Any] = ["nickname" : nicknameString,
                                          "phone_number" : phoneString,
                                               "address" : emailString]
            
            self.presenter?.interactor?.setProfile(profileDictionary: profileDict)
            
        } else {
            cell.nameTextField.delegate = self
            cell.nameTextField.becomeFirstResponder()
            self.editButton.setTitle("Save", for: .normal)
            self.editButton.tag = 2
            self.tableView.reloadData()
        }
    }
    
    // MARK: UITableView DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 300.0
        case 2:
            return 90.0
        default:
            return 129.0
        }
    }
    
    // MARK: TableView Delegate & DataSource
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 1:
            collectionHeaderView.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 647.0)
            collectionHeaderView.backgroundColor = UIColor.clear
            collectionHeaderView.isUserInteractionEnabled = true
            collectionHeaderView.addSubview(collectionView)
            return collectionHeaderView
        default:
            let headerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 52.0))
            headerView.backgroundColor = UIColor.clear
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            if (UIScreen.main.nativeBounds.height == 1136) {
                return 124.0
            } else {
                return 160.0
            }
        } else if (section == 1) {
            return 647.0
        }
        
        return 21.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        profileCell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as! ProfileCell
        profileCell.selectionStyle = .none
        
        profileCell.nameTextField.delegate = self
        profileCell.nicknameTextField.delegate = self
        profileCell.addressTextField.delegate = self
        profileCell.phoneTextField.delegate = self
        
        profileCell.nameTextField.attributedPlaceholder = NSAttributedString(string: "Name",
                                                                             attributes: [NSAttributedString.Key.foregroundColor:
                                                                                Colours.profilePlaceholderColor])
        
        if (UserDefaults.standard.object(forKey: "ProfileName") as? String != "") {
            profileCell.nameTextField.text = UserDefaults.standard.object(forKey: "ProfileName") as? String
        }
        
        if (profileModel.nickname != "") {
            profileCell.nicknameTextField.text = profileModel.nickname
            profileCell.nicknameTextField.textColor = Colours.profilePlaceholderColor
        } else {
            profileCell.nicknameTextField.attributedPlaceholder = NSAttributedString(string: "nickname",
                                                                                     attributes: [NSAttributedString.Key.foregroundColor: Colours.profilePlaceholderColor])
        }
        
        if (profileModel.address != "") {
            profileCell.addressTextField.text = profileModel.address
            profileCell.addressTextField.textColor = Colours.profilePlaceholderColor
        } else {
            profileCell.addressTextField.attributedPlaceholder = NSAttributedString(string: "address",
                                                                                  attributes: [NSAttributedString.Key.foregroundColor: Colours.profilePlaceholderColor])
        }
        
        if (profileModel.phone_number != "") {
            profileCell.phoneTextField.text = profileModel.phone_number
            profileCell.phoneTextField.textColor = Colours.profilePlaceholderColor
        } else {
            profileCell.phoneTextField.attributedPlaceholder = NSAttributedString(string: "phone",
                                                                                  attributes: [NSAttributedString.Key.foregroundColor: Colours.profilePlaceholderColor])
        }
        
        if (self.editButton.tag == 2) {
            profileCell.isUserInteractionEnabled = true
            profileCell.nameTextField.isUserInteractionEnabled = true
            profileCell.nicknameTextField.isUserInteractionEnabled = true
            profileCell.addressTextField.isUserInteractionEnabled = true
            profileCell.phoneTextField.isUserInteractionEnabled = true
            
            cell.viewWithTag(1)?.isHidden = false
            cell.viewWithTag(2)?.isHidden = false
            cell.viewWithTag(3)?.isHidden = false
            cell.viewWithTag(4)?.isHidden = false
            cell.nameTextField.becomeFirstResponder()
            
        } else {
            profileCell.nameTextField.isUserInteractionEnabled = false
            profileCell.nicknameTextField.isUserInteractionEnabled = false
            profileCell.addressTextField.isUserInteractionEnabled = false
            profileCell.phoneTextField.isUserInteractionEnabled = false
            
            cell.viewWithTag(1)?.isHidden = true
            cell.viewWithTag(2)?.isHidden = true
            cell.viewWithTag(3)?.isHidden = true
            cell.viewWithTag(4)?.isHidden = true
        }
        
        emptyCell = tableView.dequeueReusableCell(withIdentifier: "EmptyCell") as! EmptyCell
        emptyCell.selectionStyle = .none
        
        switch indexPath.section {
        case 0:
            return profileCell
        default:
            return emptyCell
        }
    }
    
    // MARK: UITextField Delegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.animateTextField(textField: textField, up: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.animateTextField(textField: textField, up: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! ProfileCell
        if (textField == cell.nameTextField) {
            cell.nicknameTextField.becomeFirstResponder()
        } else if (textField == cell.nicknameTextField) {
            cell.addressTextField.becomeFirstResponder()
        } else if (textField == cell.addressTextField) {
            cell.phoneTextField.becomeFirstResponder()
        } else if (textField == cell.phoneTextField) {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! ProfileCell
        
        guard let text = textField.text else { return true }
        let count = text.count + string.count - range.length
        
        switch textField {
        case cell.nicknameTextField:
            return count <= 10
        case cell.phoneTextField:
            return count <= 15
        case cell.addressTextField:
            return count <= 20
        default:
            return true
        }
    }
    
    // MARK: CollectionView Delegate & DataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 72.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let profileCollectionViewCell: ProfileCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath as IndexPath) as! ProfileCollectionViewCell
        
        for index in indexPath {
            if (index == 0) {
                profileCollectionViewCell.valueLabel.text = "ENG"
            } else if (index == 1) {
                profileCollectionViewCell.valueLabel.text = "USD"
            } else if (index == 8) {
                profileCollectionViewCell.separatorView.isHidden = true
            } else if (index > 1) {
                profileCollectionViewCell.valueLabel.text = ""
            }
            
            profileCollectionViewCell.imageView.image = UIImage.init(named: collectionViewImageArray[index])
            profileCollectionViewCell.titleLabel.text = collectionViewTitleArray[index]
        }
        
        return profileCollectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    //Keyboard appereance
    func animateTextField(textField: UITextField, up: Bool) {
        let movementDistance   = -112.0 // tweak as needed
        let movementDuration = 0.5 // tweak as needed
        
        let movement = (up ? movementDistance : -movementDistance)
        
        UIView.animate(withDuration: movementDuration, delay: 0.0, options: [.curveEaseInOut], animations: {
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: CGFloat(movement))
            if (movement < 0) {
                self.editButtonTopSpace.constant = self.editButtonTopSpace.constant + self.editButtonPathValue
                self.customTitle.alpha = 0.0
            } else {
                self.editButtonTopSpace.constant = self.editButtonTopSpace.constant - self.editButtonPathValue
                self.customTitle.alpha = 1.0
            }
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        self.view.endEditing(true)
        
        // FAKE
        if (!firstClick) {
            firstClick = true
            let unpaidWinsViewController = UnpaidWinsRouter.createModule()
            self.navigationController?.pushViewController(unpaidWinsViewController, animated: true)
        } else {
            firstClick = false
            let biddingHistoryViewController = BiddingHistoryRouter.createModule()
            self.navigationController?.pushViewController(biddingHistoryViewController, animated: true)
        }
    }
}
