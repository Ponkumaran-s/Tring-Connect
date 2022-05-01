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
    var delegate: TCStoryImageIntractionDelegate? { get set }
}

protocol TCStoryImageIntractionDelegate: NSObjectProtocol {
    func imageTapped(imagedata: String)
}

class TCDefaultStoryTableViewCell: UITableViewCell, TCStoryTableViewCell {

    private let viewModel = TCStoryViewModel()
    
    @IBOutlet weak var storyHeaderView: TCStoryHeaderView!
    @IBOutlet weak var storyImageView: UIImageView!
    @IBOutlet weak var storyFooterView: TCStoryFooterView!
    
    weak var delegate: TCStoryImageIntractionDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(imagViewTapped))
        storyImageView.addGestureRecognizer(tap)
        storyImageView.isUserInteractionEnabled = true
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
    
    @objc func imagViewTapped() {
        delegate?.imageTapped(imagedata: viewModel.getStoryDisplayImage)
    }
}
