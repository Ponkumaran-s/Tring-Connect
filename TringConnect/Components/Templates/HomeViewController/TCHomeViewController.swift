//
//  TCHomeViewController.swift
//  TringConnect
//
//  Created by Ponkumar's Mac on 30/04/22.
//

import UIKit

class TCHomeViewController: UIViewController {

    @IBOutlet weak var homepageTableView: UITableView!
    
    var data: TCContextItem?
    
    private let viewModel = TCHomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        intialSetup()
        
        viewModel.getHomeItems("https://b1cdc5c8-4df1-4b59-a583-81ba59ac4dc0.mock.pstmn.io/v1/home") { [weak self] isSuccess, error in
            if isSuccess {
                self?.homepageTableView.reloadData()
            }
        }
        
    }

    private func intialSetup() {
        homepageTableView.delegate = self
        homepageTableView.dataSource = self
    }
}

extension TCHomeViewController: UITableViewDelegate {
    
}

extension TCHomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
