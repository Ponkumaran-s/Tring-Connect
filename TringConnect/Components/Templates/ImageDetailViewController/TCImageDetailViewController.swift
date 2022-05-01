//
//  TCTCImageDetailViewController.swift
//  TringConnect
//
//  Created by Ponkumar's Mac on 02/05/22.
//

import UIKit

class TCImageDetailViewController: UIViewController {
    
    static let controllerID = "TCImageDetailViewController"
    
    @IBOutlet weak var imageDetailView: UIImageView!
    
    var imagedata = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageDetailView.image = UIImage(named: imagedata)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissScreen))
        self.view.addGestureRecognizer(tap)
        self.view.isUserInteractionEnabled = true
    }
}

extension TCImageDetailViewController {
    
    @objc func dismissScreen() {
        self.dismiss(animated: true, completion: nil)
    }
}
