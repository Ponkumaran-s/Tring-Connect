//
//  TCCourseTableViewCell.swift
//  TringConnect
//
//  Created by Ponkumar's Mac on 30/04/22.
//

import UIKit

class TCCourseTableViewCell: UITableViewCell, TCHomeTableViewCell {

    @IBOutlet var courseCollectionView: UICollectionView!
    @IBOutlet weak var cellHeader: UILabel!
    @IBOutlet weak var optionButton: UIButton!
    @IBOutlet weak var storyFooterView: TCStoryFooterView!
    
    private let viewModel = TCCourseViewModel()
    
    var isOptionButtonEnabled = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        intialSrtup()
    }
    
    private func intialSrtup() {
        courseCollectionView.dataSource = self
        courseCollectionView.delegate = self
        registerCollectionViewCells()
    }

    private func registerCollectionViewCells() {
        let nib = UINib(nibName: "TCCourseCollectionViewCell", bundle: nil)
        courseCollectionView.register(nib, forCellWithReuseIdentifier: "TCCourseCollectionViewCell")
    }
    
    @IBAction func optionButtonTapped(sender: AnyObject) {
        
        isOptionButtonEnabled.toggle()
        
        if isOptionButtonEnabled {
            optionButton.setImage(UIImage(named: "VerticleDotsSelected"), for: .normal)
        } else {
            optionButton.setImage(UIImage(named: "VerticleDotsUnselected"), for: .normal)
        }
    }
}

extension TCCourseTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.noOfCourseItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TCCourseCollectionViewCell", for: indexPath) as? TCCourseCollectionViewCell,
              let course = viewModel.getCourse(at: indexPath.row) else { return  UICollectionViewCell() }
        cell.configureCell(with: course)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        viewModel.getSizeFotCourseItem
    }
}

extension TCCourseTableViewCell {
    func configureCell(with item: TCHomeItem) {
        viewModel.setCourseItem(item)
        courseCollectionView.reloadData()
        storyFooterView.configureFooterView(with: viewModel.getTimestamp, and: viewModel.getCourseImpressions)
    }
}
