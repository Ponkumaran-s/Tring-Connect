//
//  TCHomeViewModel.swift
//  TringConnect
//
//  Created by Ponkumar's Mac on 30/04/22.
//

import Foundation
import UIKit

class TCHomeViewModel {
    
    private var homeItems: [TCHomeItem]?
    
    var noOfHomeItems: Int {
        homeItems?.count ?? 0
    }
    
    func getHomeItem(_ index: Int) -> TCHomeItem? {
        guard let items = homeItems, index <= noOfHomeItems else { return nil }
        
        return items[index]
    }
    
    func getHomeItemType(for kind: String) -> TCHomeItemType {
        TCHomeItemType(rawValue: kind) ?? .post
    }
    
    func getHomeItemCellNibs() -> [String] {
        [TCHomeItemType.highlight.getCellIDForHomeItem(),
         TCHomeItemType.course.getCellIDForHomeItem(),
         TCHomeItemType.post.getCellIDForHomeItem(.normal),
         TCHomeItemType.post.getCellIDForHomeItem(.promotion),
         TCHomeItemType.post.getCellIDForHomeItem(.hybrid)]
    }
    
    func getTableViewCell(for homeItem: TCHomeItem,_ tableview: UITableView, _ indexPath: IndexPath, _ parentController: TCHomeViewController) -> UITableViewCell {
        
        guard let kind = homeItem.kind else { return UITableViewCell() }
        
        let homeItemType = getHomeItemType(for: kind)
        print(homeItemType,"##")
        
        switch homeItem {
        case let storyItem as TCStoryItem:
            guard let cell = tableview.dequeueReusableCell(withIdentifier: homeItemType.getCellIDForHomeItem(storyItem.getStoryType), for: indexPath) as? TCStoryTableViewCell else {
                return UITableViewCell()
            }
            cell.delegate = parentController
            cell.configureCell(with: storyItem)
            return cell
            
        case let courseItem as TCCourseItem:
            guard let cell = tableview.dequeueReusableCell(withIdentifier: homeItemType.getCellIDForHomeItem(), for: indexPath) as? TCCourseTableViewCell else {
                return UITableViewCell()
            }
            cell.configureCell(with: courseItem)
            return cell
            
        case let highlightItem as TCHighlightItem:
            guard let cell = tableview.dequeueReusableCell(withIdentifier: homeItemType.getCellIDForHomeItem(), for: indexPath) as? TCHighlightTableViewCell else {
                return UITableViewCell()
            }
            cell.configureCell(with: highlightItem)
            return cell
            
        default:
            return  UITableViewCell()
        }
    }
    
    func getTableViewCellHeight() -> CGFloat {
        UITableView.automaticDimension
    }
    
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
