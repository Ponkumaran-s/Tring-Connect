//
//  TCDefaultStoryTableViewCell.swift
//  TringConnect
//
//  Created by Ponkumar's Mac on 01/05/22.
//

import UIKit

protocol TCHomeTableViewCell: UITableViewCell {
    func configureCell(with item: TCHomeItem)
}

protocol TCStoryTableViewCell: TCHomeTableViewCell {
    
}

class TCDefaultStoryTableViewCell: UITableViewCell, TCStoryTableViewCell {

    private let viewModel = TCStoryViewModel()
    
    @IBOutlet weak var storyHeaderView: TCStoryHeaderView!
    @IBOutlet weak var storyImageView: UIImageView!
    @IBOutlet weak var storyFooterView: TCStoryFooterView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension TCDefaultStoryTableViewCell {
    func configureCell(with item: TCHomeItem) {
        viewModel.setStoryItem(item)
        storyImageView.image = UIImage(named: viewModel.getStoryDisplayImage)
        storyFooterView.configureFooterView(with: viewModel.getTimestamp, and: viewModel.getStoryImpressions)
        storyHeaderView.configureHeaderView(with: item)
    }
}
