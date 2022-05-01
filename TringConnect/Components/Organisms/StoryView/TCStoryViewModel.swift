//
//  TCStoryViewModel.swift
//  TringConnect
//
//  Created by Ponkumar's Mac on 01/05/22.
//

import UIKit

class TCStoryViewModel {
    
    private var storyItem: TCStoryItem?
    
    let buttonBorderColor: CGColor = UIColor(named: "AppColor")?.cgColor ?? UIColor.green.cgColor
    var getStoryDisplayImage: String {
        storyItem?.storyAttachments?.storyImages?[0] ?? ""
    }
    
    var getTimestamp: String {
        storyItem?.timestamp ?? ""
    }
    
    var getStoryImpressions: TCLikesAndComments {
        storyItem?.likesAndComments ?? TCLikesAndComments()
    }
    
    var getPromotionTitle: String {
        storyItem?.storyAttachments?.promotions?.promotionsTitle ?? ""
    }
    
    var getPromotionSubtitle: String {
        storyItem?.storyAttachments?.promotions?.promotionsSubtitle ?? ""
    }
    
    var getPromotionDisplayPicture: String {
        storyItem?.storyAttachments?.promotions?.promotionsDP ?? ""
    }
    
    var getHybridStoryImages: [String] {
        guard let images = storyItem?.storyAttachments?.storyImages else {
            return []
        }

        return images.compactMap{ $0 }
    }
    
    func setStoryItem(_ homeItem: TCHomeItem?) {
        guard let item = homeItem as? TCStoryItem else {
            return
        }

        self.storyItem = item
    }
    
    func getStoryItem() -> TCStoryItem? {
        self.storyItem
    }
}
