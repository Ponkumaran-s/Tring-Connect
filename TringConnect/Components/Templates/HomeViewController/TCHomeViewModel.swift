//
//  TCHomeViewModel.swift
//  TringConnect
//
//  Created by Ponkumar's Mac on 30/04/22.
//

import Foundation

class TCHomeViewModel {
    
    private var homeItems: [TCHomeItem]?
    
    
    func getHomeItems(_ url: String?, _ completion: ((Bool, Error?) -> Void)? = nil) {
        guard let homeUrl = url else {
            completion?(false, nil)
            return
        }

        TCNetworkService.getData(homeUrl, TCContextItem.self) { [weak self] (result) in
            guard let weakSelf = self else { return }
            
            switch result {
            case .success(let contextData):
                weakSelf.homeItems = contextData.homeData
                completion?(true, nil)
            case .failure(let error):
                completion?(false, error)
            }
        }
    }
}
