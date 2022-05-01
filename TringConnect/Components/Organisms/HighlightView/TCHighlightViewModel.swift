//
//  TCHighlightViewModel.swift
//  TringConnect
//
//  Created by Ponkumar's Mac on 30/04/22.
//

import UIKit

class TCHighlightViewModel {
    
    private var highlightItem: TCHighlightItem?

    var noOfHighlightItems: Int {
        guard let list = highlightItem?.highlightList else { return 0 }
        return list.count + 1
    }
    
    var getSizeFotHighlightItem: CGSize {
        CGSize(width: 60.0, height: 75.0)
    }
    
    func setHighlightItem(_ homeItem: TCHomeItem?) {
        guard let item = homeItem as? TCHighlightItem else {
            return
        }

        self.highlightItem = item
    }
    
    func getHighlightItem() -> TCHighlightItem? {
        self.highlightItem
    }
    
    func getHighlight(at index: Int) -> TCHighlight? {
        guard let hightightList = highlightItem?.highlightList,
              index != 0,
              index <= hightightList.count else { return nil }
        return hightightList[index - 1]
    }


}
