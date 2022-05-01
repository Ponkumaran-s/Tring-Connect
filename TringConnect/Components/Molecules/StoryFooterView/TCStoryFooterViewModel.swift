//
//  TCStoryFooterViewModel.swift
//  TringConnect
//
//  Created by Ponkumar's Mac on 01/05/22.
//

import Foundation

class TCStoryFooterViewModel {
    
    private var impressions: TCLikesAndComments?
    
    func setImpresssionItem(_ item: TCLikesAndComments?) {
        self.impressions = item
    }
    
    var getLikesCount: String {
        String(impressions?.likesCount ?? 0)
    }
    
    var getCommentsCount: String {
        String(impressions?.likesCount ?? 0)
    }
    
    var getRecentlyLikedUser: String {
        impressions?.recentLikes ?? ""
    }
    
    var getRececntLikedList: String {
        "Liked by \(getRecentlyLikedUser) and \(getLikesCount) others"
    }
}
