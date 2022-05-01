//
//  TCPlaceholderViewController.swift
//  TringConnect
//
//  Created by Ponkumar's Mac on 01/05/22.
//

import UIKit

class TCPlaceholderViewController: UIViewController {
    
    static let controllerID = "TCPlaceholderViewController"

    @IBOutlet weak var centerTextField: UILabel!
    
    var centerText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerTextField.text = centerText
        // Do any additional setup after loading the view.
    }

}
