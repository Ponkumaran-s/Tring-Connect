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
    
    func calculateLikeCount(_ isLiked: Bool) -> String {
        let likeCount: Int = impressions?.likesCount ?? 0
        
        let currentCount = isLiked ? likeCount + 1 : likeCount 
        
        return String(currentCount)
    }
    
    func getRececntLikedList(_ count: String?) -> String {
        "Liked by \(getRecentlyLikedUser) and \(count ?? "") others"
    }
}
