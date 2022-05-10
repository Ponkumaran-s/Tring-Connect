//
//  TCHighlightCollectionViewCell.swift
//  TringConnect
//
//  Created by Ponkumar's Mac on 30/04/22.
//

import UIKit

class TCHighlightCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var highlightImageView: UIImageView!
    @IBOutlet weak var onlineView: UIView!
    @IBOutlet weak var onlineOuterView: UIView!
    @IBOutlet weak var highlightNameTag: UILabel!
    
    private let viewModel = TCHighlightViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        onlineView.layer.cornerRadius =  onlineView.frame.width / 2
        onlineOuterView.layer.cornerRadius =  onlineOuterView.frame.width / 2
    }

}

extension TCHighlightCollectionViewCell {
    
    func configureCell(at index: Int, with item: TCHighlight = TCHighlight()) {
        if index == 0 {
            highlightImageView.image = UIImage(named: TCConstants.addHighlightButton)
            highlightNameTag.isHidden = true
            onlineView.isHidden = true
            onlineOuterView.isHidden = true
        } else {
            highlightImageView.image = UIImage(named: item.userDP ?? "")
            highlightNameTag.text = item.username
        }
    }
}
