//
//  TCHighlightTableViewCell.swift
//  TringConnect
//
//  Created by Ponkumar's Mac on 30/04/22.
//

import UIKit

class TCHighlightTableViewCell: UITableViewCell, TCHomeTableViewCell {

    @IBOutlet var highlightCollectionView: UICollectionView!
    
    private let viewModel = TCHighlightViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        intialSrtup()
    }
    
    private func intialSrtup() {
        highlightCollectionView.dataSource = self
        highlightCollectionView.delegate = self
        registerCollectionViewCells()
    }

    private func registerCollectionViewCells() {
        let nib = UINib(nibName: "TCHighlightCollectionViewCell", bundle: nil)
        highlightCollectionView.register(nib, forCellWithReuseIdentifier: "TCHighlightCollectionViewCell")
    }
}

extension TCHighlightTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.noOfHighlightItems 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TCHighlightCollectionViewCell", for: indexPath) as? TCHighlightCollectionViewCell else {
            return UICollectionViewCell()
        }
        if indexPath.row == 0 {
            cell.configureCell(at: indexPath.row)
        } else {
            if let highlight = viewModel.getHighlight(at: indexPath.row){
                cell.configureCell(at: indexPath.row, with: highlight)
            }
        }
        
        return cell 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        viewModel.getSizeFotHighlightItem
    }
    
}

extension TCHighlightTableViewCell {
    func configureCell(with item: TCHomeItem) {
        viewModel.setHighlightItem(item)
    }
}
