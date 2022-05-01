//
//  TCPromotionStoryTableViewCell.swift
//  TringConnect
//
//  Created by Ponkumar's Mac on 01/05/22.
//

import UIKit

class TCPromotionStoryTableViewCell: UITableViewCell, TCStoryTableViewCell  {

    private let viewModel = TCStoryViewModel()
    
    @IBOutlet weak var promotionKnowMoreButton: UIButton!
    @IBOutlet weak var storyHeaderView: TCStoryHeaderView!
    @IBOutlet weak var promotionImageView: UIImageView!
    @IBOutlet weak var promotionTitleLabel: UILabel!
    @IBOutlet weak var promotionSubtitleLabel: UILabel!
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

extension TCPromotionStoryTableViewCell {
    func configureCell(with item: TCHomeItem) {
        viewModel.setStoryItem(item)
        promotionImageView.image = UIImage(named: viewModel.getPromotionDisplayPicture)
        promotionTitleLabel.text = viewModel.getPromotionTitle
        promotionSubtitleLabel.text = viewModel.getPromotionSubtitle
        storyFooterView.configureFooterView(with: viewModel.getTimestamp, and: viewModel.getStoryImpressions)
        storyHeaderView.configureHeaderView(with: item)
    }
}
