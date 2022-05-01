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
    
    weak var delegate: TCStoryImageIntractionDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        intialSrtup()
    }

    func intialSrtup() {
        promotionKnowMoreButton.layer.borderWidth = 1.0
        promotionKnowMoreButton.layer.borderColor = viewModel.buttonBorderColor
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
    
    @objc func imagViewTapped() {
        delegate?.imageTapped(imagedata: viewModel.getStoryDisplayImage)
    }
}
