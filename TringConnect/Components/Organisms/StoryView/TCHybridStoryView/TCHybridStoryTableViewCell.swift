//
//  TCHybridStoryTableViewCell.swift
//  TringConnect
//
//  Created by Ponkumar's Mac on 01/05/22.
//

import UIKit

class TCHybridStoryTableViewCell: UITableViewCell, TCStoryTableViewCell  {
    
    private let viewModel = TCStoryViewModel()
    
    @IBOutlet weak var storyHeaderView: TCStoryHeaderView!
    @IBOutlet weak var storyFirstImageView: UIImageView!
    @IBOutlet weak var storySecondImageView: UIImageView!
    @IBOutlet weak var storyThirdImageView: UIImageView!
    @IBOutlet weak var storyFourthImageView: UIImageView!
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

extension TCHybridStoryTableViewCell {
    func configureCell(with item: TCHomeItem) {
        viewModel.setStoryItem(item)
        storyFirstImageView.image = UIImage(named: viewModel.getHybridStoryImages[0])
        storySecondImageView.image = UIImage(named: viewModel.getHybridStoryImages[1])
        storyThirdImageView.image = UIImage(named: viewModel.getHybridStoryImages[2])
        storyFourthImageView.image = UIImage(named: viewModel.getHybridStoryImages[3])
        storyFooterView.configureFooterView(with: viewModel.getTimestamp, and: viewModel.getStoryImpressions)
        storyHeaderView.configureHeaderView(with: item)
    }
}
