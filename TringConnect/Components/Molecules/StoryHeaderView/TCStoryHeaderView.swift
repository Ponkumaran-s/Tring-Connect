//
//  TCStoryHeaderView.swift
//  TringConnect
//
//  Created by Ponkumar's Mac on 30/04/22.
//

import UIKit

class TCStoryHeaderView: UIView {
    
    private let nibName = "TCStoryHeaderView"
    
    private let viewModel = TCStoryHeaderViewModel()

    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userProfileName: UILabel!
    @IBOutlet weak var userDesignation: UILabel!
    @IBOutlet weak var userStory: UILabel!
    @IBOutlet weak var userHashTag: UILabel!
    @IBOutlet weak var readMoreButton: UIButton!
    @IBOutlet weak var optionButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit(nibName)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit(nibName)
    }

}

extension TCStoryHeaderView {
    func configureHeaderView(with item: TCHomeItem) {
        viewModel.setHeaderItem(item)
        userProfileImageView.image = UIImage(named: viewModel.getUserProfileImage)
        userProfileName.text = viewModel.getUserProfileName
        userDesignation.text = viewModel.getUserDesignation
        userStory.text = viewModel.getUserStory
        userHashTag.text = viewModel.getUserHashTags
    }


}
