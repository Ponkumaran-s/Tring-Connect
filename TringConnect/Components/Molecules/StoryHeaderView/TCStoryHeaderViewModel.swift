//
//  TCStoryHeaderViewModel.swift
//  TringConnect
//
//  Created by Ponkumar's Mac on 01/05/22.
//

import Foundation

class TCStoryHeaderViewModel {
    
    private var storyItem: TCStoryItem?
    
    var getUserProfileImage: String {
        storyItem?.userDP ?? ""
    }
    
    var getUserProfileName: String {
        storyItem?.username ?? ""
    }
    
    var getUserDesignation: String {
        storyItem?.userDesignation ?? ""
    }
    
    var getUserHashTags: String {
        storyItem?.hashTags ?? ""
    }
    
    var getUserStory: String {
        storyItem?.storySummary ?? ""
    }
    
    func setHeaderItem(_ homeItem: TCHomeItem?) {
        guard let item = homeItem as? TCStoryItem else {
            return
        }

        self.storyItem = item
    }
    
    func getHeaderItem() -> TCStoryItem? {
        self.storyItem
    }
    

}
