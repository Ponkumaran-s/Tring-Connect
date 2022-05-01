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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension TCCourseCollectionViewCell {
    
    func configureCell(with item: TCCourse) {
        courseImageView.image = UIImage(named: item.courseDP ?? "")
        courseTitle.text = item.courseDescription
    }

}
