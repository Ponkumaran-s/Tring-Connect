//
//  TCTCStoryFooterView.swift
//  TringConnect
//
//  Created by Ponkumar's Mac on 30/04/22.
//

import UIKit

class TCStoryFooterView: UIView {
    
    private let nibName = "TCStoryFooterView"
    
    private let viewModel = TCStoryFooterViewModel()
    
    @IBOutlet weak var likeListLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var commentUploadButton: UIButton!
    @IBOutlet weak var commentTextField: UITextField!
    
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

extension TCStoryFooterView {

    func configureFooterView(with timestamp: String, and impressions: TCLikesAndComments) {
        viewModel.setImpresssionItem(impressions)
        timeStampLabel.text = timestamp
        likeCountLabel.text = viewModel.getLikesCount
        commentCountLabel.text = viewModel.getCommentsCount
        likeListLabel.text = viewModel.getRececntLikedList
    }

}