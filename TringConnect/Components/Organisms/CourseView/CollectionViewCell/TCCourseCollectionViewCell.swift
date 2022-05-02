//
//  TCCourseCollectionViewCell.swift
//  TringConnect
//
//  Created by Ponkumar's Mac on 30/04/22.
//

import UIKit

class TCCourseCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var courseImageView: UIImageView!
    @IBOutlet weak var courseTitle: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var favouriteButton: UIButton!
    
    var isLikeEnabled = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func likeButtonTapped(sender: AnyObject) {
        
        isLikeEnabled.toggle()
        
        if isLikeEnabled {
            favouriteButton.setImage(UIImage(named: "favouriteSelected"), for: .normal)
        } else {
            favouriteButton.setImage(UIImage(named: "favouriteUnselected"), for: .normal)
        }
    }
    
    
}

extension TCCourseCollectionViewCell {
    
    func configureCell(with item: TCCourse) {
        resetCell()
        courseImageView.image = UIImage(named: item.courseDP ?? "")
        courseTitle.text = item.courseDescription
    }

    private func resetCell() {
        isLikeEnabled = false
        favouriteButton.setImage(UIImage(named: "favouriteUnselected"), for: .normal)
    }

}
