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
    
    weak var delegate: TCStoryImageIntractionDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addGestureForImageView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func addGestureForImageView() {
        let firstImageTapGesture = UITapGestureRecognizer(target: self, action: #selector(imagViewTapped(sender:)))
        storyFirstImageView.tag = 0
        storyFirstImageView.addGestureRecognizer(firstImageTapGesture)
        storyFirstImageView.isUserInteractionEnabled = true
        
        let secondImageTapGesture = UITapGestureRecognizer(target: self, action: #selector(imagViewTapped(sender:)))
        storySecondImageView.tag = 1
        storySecondImageView.addGestureRecognizer(secondImageTapGesture)
        storySecondImageView.isUserInteractionEnabled = true
    
        let thirdImageTapGesture = UITapGestureRecognizer(target: self, action: #selector(imagViewTapped(sender:)))
        storyThirdImageView.tag = 2
        storyThirdImageView.addGestureRecognizer(thirdImageTapGesture)
        storyThirdImageView.isUserInteractionEnabled = true
        
        let fourthImageTapGesture = UITapGestureRecognizer(target: self, action: #selector(imagViewTapped(sender:)))
        storyFourthImageView.tag = 3
        storyFourthImageView.addGestureRecognizer(fourthImageTapGesture)
        storyFourthImageView.isUserInteractionEnabled = true
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
    
    @objc func imagViewTapped(sender: AnyObject) {
        guard let index = sender.view?.tag else { return }
        delegate?.imageTapped(imagedata: viewModel.getHybridStoryImages[index])
    }
    

}
