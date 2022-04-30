//
//  TCHighlightTableViewCell.swift
//  TringConnect
//
//  Created by Ponkumar's Mac on 30/04/22.
//

import UIKit

class TCHighlightTableViewCell: UITableViewCell {

    @IBOutlet var highlightcollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        intialSrtup()
    }
    
    private func intialSrtup() {
        highlightcollectionView.dataSource = self
        highlightcollectionView.delegate = self
    }

}

extension TCHighlightTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
    
    
}
