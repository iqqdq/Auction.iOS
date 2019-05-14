//
//  NewAuctionsViewController.swift
//  Auction
//
//  Created by Q on 21/10/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import UIKit
import AlamofireImage

class NewAuctionsViewController: UIViewController, NewAuctionsViewProtocol, UITableViewDelegate, UITableViewDataSource,
                                 CellButtonDelegate, OfferCellButtonDelegate, CollectionCellButtonDelegate, BiggerCellButtonDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: NewAuctionsPresenterProtocol?
    
    let itemPageViewController = ItemPageRouter.createModule()
    var largeTitleCell = LargeTitleCell()
    var itemWithButtonCell = ItemWithButtonCell()
    var biggerItemWithButtonCell = BiggerItemWithButtonCell()
    var offerTableViewCell = OfferTableViewCell()
    var collectionView: UICollectionView!
    var itemCollectionViewCell = ItemCollectionViewCell()
    var lotModel = [LotResponse]()
    var newLotModel = [NewLotResponse]()
    var startedLotModel = StartedLotResponse(dictionary: [:])
    var styleDidChange: Bool = false
    var images = [String]()
    
    override func viewWillLayoutSubviews() {
        self.tableView.tableFooterView = UIView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 52.0))
        
        let dummyViewHeight = CGFloat(52.0)
        self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: dummyViewHeight))
        self.tableView.contentInset = UIEdgeInsets(top: -dummyViewHeight, left: 0, bottom: 0, right: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.presenter?.interactor?.getNewLots()
        self.presenter?.interactor?.getStartedLots()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeViewController = HomeRouter.createModule()
        homeViewController.searchTextFieldDelegate = self
        
        images = ["bid1", "bid2", "bid3", "bid4", "bid5"]
        
        //init tableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "LargeTitleCell", bundle: nil), forCellReuseIdentifier: "LargeTitleCell")
        self.tableView.register(UINib(nibName: "ItemWithButtonCell", bundle: nil), forCellReuseIdentifier: "ItemWithButtonCell")
        self.tableView.register(UINib(nibName: "BiggerItemWithButtonCell", bundle: nil), forCellReuseIdentifier: "BiggerItemWithButtonCell")
        self.tableView.register(UINib(nibName: "OfferTableViewCell", bundle: nil), forCellReuseIdentifier: "OfferTableViewCell")
        
        //init collectionView
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing = 10.0
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
        collectionView = UICollectionView(frame: CGRect(x: 0.0, y: 30.0, width: UIScreen.main.bounds.width, height: 154.0), collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceHorizontal = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UINib.init(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemCollectionViewCell")
        collectionView.backgroundColor = UIColor.white
    }
    
    // MARK: - API Calls
    
    func updateNewLots(newLots: NSArray) {
        for dict in newLots {
            newLotModel.append(NewLotResponse.init(dictionary: dict as! [String : Any]))
        }
        let range = Range(uncheckedBounds: (0, collectionView.numberOfSections))
        let indexSet = IndexSet(integersIn: range)
        collectionView.reloadSections(indexSet)
    }
    
    func updateStartedLots(startedLots: NSArray) {
        for dict in startedLots {
            lotModel.append(LotResponse.init(dictionary: dict as! [String : Any]))
        }
        tableView.reloadSections(IndexSet(integer: 2), with: .bottom)
    }
    
    func startedLotSelected(startedLot: [String : Any]) {
        startedLotModel = StartedLotResponse.init(dictionary: startedLot)
        UserDefaults.standard.set(startedLot, forKey: "startedLot")
        if (UserDefaults.standard.object(forKey: "startedLot") != nil) {
            self.navigationController?.pushViewController(itemPageViewController, animated: true)
        }
    }
    
    func showEmptyLotsError() {
        print("There are no new lots!")
    }
    
    // MARK: CollectionViewCell Delegate
    
    func collectionViewCellStarButton(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
    
    // MARK: offerTableViewCell Delegate
    
    func offerCellButton(_ sender: UIButton) {
        let bidCarouselViewController = BidCarouselRouter.createModule()
        navigationController?.pushViewController(bidCarouselViewController, animated: true)
    }
    
    // MARK: itemWithButtonCell Delegate
    
    func openItemPageViewController() {
        //FAKE
        if(!styleDidChange) {
            styleDidChange = true
        } else {
            styleDidChange = false
        }
        self.tableView.reloadSections(IndexSet(integer: 2), with: .bottom)
        //self.presenter?.interactor?.getStartedLot(lotId: "\(lotModel[itemWithButtonCell.button.tag].id!)/")
    }
    
    func cellStarButton(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
    
    // MARK: BiggerCell Delegate
    
    func openBiggerItemPageViewController() {
        //FAKE
        if(!styleDidChange) {
            styleDidChange = true
        } else {
            styleDidChange = false
        }
        self.tableView.reloadSections(IndexSet(integer: 2), with: .bottom)
        //self.presenter?.interactor?.getStartedLot(lotId: "\(lotModel[itemWithButtonCell.button.tag].id!)/")
    }
    
    func biggerCellStarButton(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
    
    // MARK: SearchTextField Delegate
    
    func beginSearchByText(text: String) {
        print(text)
    }
    
    // MARK: Search and Switch Buttons Delegate
    
//    func switchItemCellStyle(_ sender: UIButton) {
//        self.tableView.reloadSections(IndexSet(integer: 2), with: .bottom)
//    }
    
    // MARK: TableView Delegate & DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return 0
        case 2:
            return images.count//lotModel.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 1:
            return 160.0
        case 2:
            return 152.0
        default:
            return 198.0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 1:
            let headerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 192.0))
            headerView.backgroundColor = UIColor.clear
            let headerTitle = UILabel(frame: CGRect(x: 16.0, y: 6.0, width: 250.0, height: 22.0))
            headerTitle.font = UIFont(name: "Exo2.0-Medium", size: 18.0)
            headerTitle.tintColor = Colours.placeholderTextColor
            headerTitle.text = "The newest"
            headerView.addSubview(headerTitle)
            headerView.addSubview(collectionView)
            return headerView
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1:
            return 192.0
        default:
            return 0.0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        largeTitleCell = tableView.dequeueReusableCell(withIdentifier: "LargeTitleCell") as! LargeTitleCell
        largeTitleCell.selectionStyle = .none
        
        offerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "OfferTableViewCell") as! OfferTableViewCell
        offerTableViewCell.delegate = self
        offerTableViewCell.selectionStyle = .none
        
        itemWithButtonCell = tableView.dequeueReusableCell(withIdentifier: "ItemWithButtonCell") as! ItemWithButtonCell
        itemWithButtonCell.delegate = self
        itemWithButtonCell.selectionStyle = .none
        itemWithButtonCell.button.tag = indexPath.row
        itemWithButtonCell.starButton.tag = indexPath.row
        itemWithButtonCell.itemImage.image = UIImage.init(named: images[indexPath.row])
        
        biggerItemWithButtonCell = tableView.dequeueReusableCell(withIdentifier: "BiggerItemWithButtonCell") as! BiggerItemWithButtonCell
        biggerItemWithButtonCell.delegate = self
        biggerItemWithButtonCell.selectionStyle = .none
        biggerItemWithButtonCell.button.tag = indexPath.row
        biggerItemWithButtonCell.starButton.tag = indexPath.row
        biggerItemWithButtonCell.itemImage.image = UIImage.init(named: images[indexPath.row])
        
        if (lotModel.count > 0) {
            itemWithButtonCell.title.text = lotModel[indexPath.row].lotName
            itemWithButtonCell.price.text = lotModel[indexPath.row].startPrice
            itemWithButtonCell.bets.text = ""
            
            //bigger cell
            biggerItemWithButtonCell.title.text = lotModel[indexPath.row].lotName
            biggerItemWithButtonCell.price.text = lotModel[indexPath.row].startPrice
            biggerItemWithButtonCell.bets.text = ""

            if (lotModel[indexPath.row].mainImage != "/media/default.png") {
                let url = URL(string: URLs.baseUrl +  lotModel[indexPath.row].mainImage!)
                itemWithButtonCell.itemImage.af_setImage(withURL: url!)
                //bigger cell
                biggerItemWithButtonCell.itemImage.af_setImage(withURL: url!)
            } else {
                //FAKE
//                itemWithButtonCell.itemImage.image = UIImage.init()
//                //bigger cell
//                biggerItemWithButtonCell.itemImage.image = UIImage.init()
            }
        }
        
        switch indexPath.section {
        case 0:
            return offerTableViewCell
        default:
            if (styleDidChange) {
                return biggerItemWithButtonCell
            } else {
                return itemWithButtonCell
            }
        }
    }

    // MARK: CollectionView Delegate & DataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count//newLotModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 152.0, height: 154.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemCollectionViewCell: ItemCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath as IndexPath) as! ItemCollectionViewCell
        itemCollectionViewCell.delegate = self
        itemCollectionViewCell.itemImage.image = UIImage.init(named: images[indexPath.row])
        
        if (newLotModel.count > 0) {
            if (newLotModel[indexPath.row].mainImage != "/media/default.png") {
                let url = URL(string: URLs.baseUrl + newLotModel[indexPath.row].mainImage!)
                itemCollectionViewCell.itemImage.af_setImage(withURL: url!)
            }
            
            itemCollectionViewCell.itemTitle.text = newLotModel[indexPath.row].lotName
            
        } else {
            //FAKR
            //itemCollectionViewCell.itemImage.image = UIImage.init()
        }
        
        return itemCollectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension NewAuctionsViewController: SearchTextFieldDelegate {
    func switchItemCellStyle(_ sender: UIButton) {
        
        if sender.tag == 0 {
            self.tableView.reloadSections(IndexSet(integer: 2), with: .bottom)
            sender.tag = 1
        } else {
            let itemPageViewController = ItemPageRouter.createModule()
            navigationController?.pushViewController(itemPageViewController, animated: true)
        }
    }
}
