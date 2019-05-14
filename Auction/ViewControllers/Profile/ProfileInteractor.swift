//
//  ProfileInteractor.swift
//  Auction
//
//  Created by Q on 18/10/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import Foundation

class ProfileInteractor: ProfileInteractorInputProtocol {

    weak var presenter: ProfileInteractorOutputProtocol?

    func getProfile() {
        let webService = AuctionWebService.init()
        webService.GETQuery(endpoint: URLs.user_profile, success: { (response) in
            
            if let responseDict = response as? [String : Any] {
                self.presenter?.receiveProfile(profileDictionary: responseDict)
                print(responseDict)
            }
        })
        { (error) in
            print(error ?? "error")
        }
    }
    
    func setProfile(profileDictionary: [String: Any]) {
        let webService = AuctionWebService.init()
        webService.PUTProfileQuery(endpoint: URLs.user_profile, params: profileDictionary as [String : Any], success: { (response) in
            
            if let responseDict = response as? [String : Any] {
                print(responseDict)
                self.presenter?.receiveProfile(profileDictionary: responseDict)
            }
        })
        { (error) in
            print(error ?? "error")
        }
    }
}
