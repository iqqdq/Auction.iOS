//
//  BidCarouselViewController.swift
//  Auction
//
//  Created by Q on 11/01/2019.
//  Copyright © 2019 Oxbee. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout

class BidCarouselViewController: UIViewController, BidCarouselViewProtocol, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var presenter: BidCarouselPresenterProtocol?
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var backButtonTitle: UILabel!
    
    var bidCollectionViewCell = BidCollectionViewCell()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "BidCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BidCollectionViewCell")
        
        let layout = UPCarouselFlowLayout()
        layout.itemSize = CGSize(width: 191.0, height: 238.0)
        layout.scrollDirection = .horizontal
        layout.spacingMode = UPCarouselFlowLayoutSpacingMode.fixed(spacing: 32.0)
        layout.sideItemScale = 0.81
        layout.sideItemAlpha = 1.0
        collectionView.collectionViewLayout = layout
        
        self.setupViews()
    }
    
    func setupViews() {
        let navigationBarHeight: CGFloat = UIScreen.main.bounds.height/2.47037037
        let backgroundImage = UIImageView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: navigationBarHeight))
        backgroundImage.image = UIImage.init(named: "ic_background_bid")
        view.addSubview(backgroundImage)
        
        view.bringSubviewToFront(collectionView)
        view.bringSubviewToFront(titleLabel)
        view.bringSubviewToFront(backButton)
        view.bringSubviewToFront(backButtonTitle)
    }
    
    @IBAction func backButtonGesture(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: CollectionView Delegate & DataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        bidCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BidCollectionViewCell", for: indexPath as IndexPath) as! BidCollectionViewCell
        
        return bidCollectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}
