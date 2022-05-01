//
//  TCHomeViewController.swift
//  TringConnect
//
//  Created by Ponkumar's Mac on 30/04/22.
//

import UIKit

class TCHomeViewController: UIViewController {

    @IBOutlet weak var homepageTableView: UITableView!

    private let viewModel = TCHomeViewModel()
    
    var customNotificationButton: CustomBarButton!
    var customSearchButton: UIBarButtonItem!
    var customHambergerButton: UIBarButtonItem!
    var data: TCContextItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        intialSetup()
        
        viewModel.getHomeItems(TCConstants.homeUrl) { [weak self] isSuccess, error in
            if isSuccess {
                self?.homepageTableView.reloadData()
            }
        }
        
    }

    private func intialSetup() {
        homepageTableView.delegate = self
        homepageTableView.dataSource = self
        registerTableViewCells()
        addNavigationBaritems()
    }
    
    func registerTableViewCells() {
        viewModel.getHomeItemCellNibs().forEach { (nib) in
            guard !nib.isEmpty else {
                return
            }
            let cellNib = UINib(nibName: nib, bundle: nil)
            homepageTableView.register(cellNib, forCellReuseIdentifier: nib)
        }
    }
    
    func addNavigationBaritems() {
        
        let notificationImage = UIImage(named: TCConstants.notificationButton)?.withRenderingMode(.alwaysOriginal)
        let searchImage = UIImage(named: TCConstants.searchButton)?.withRenderingMode(.alwaysOriginal)
        let hamburgerImage = UIImage(named: TCConstants.hamburgerButton)?.withRenderingMode(.alwaysOriginal)
        
        let notificationButton = createCustopmButton(with: notificationImage, and: #selector(notificationButtonTapped(sender:)))
        let searchButton = createCustopmButton(with: searchImage, and: #selector(searchButtonTapped(sender:)))
        let hamburgerButton = createCustopmButton(with: hamburgerImage, and: #selector(hamburgerButtonTapped(sender:)))

        // Bar button
        customSearchButton = UIBarButtonItem(customView: searchButton)
        customHambergerButton = UIBarButtonItem(customView: hamburgerButton)
        customNotificationButton = CustomBarButton(customView: notificationButton)
        
        navigationItem.rightBarButtonItems = [customSearchButton, customNotificationButton]
        navigationItem.leftBarButtonItem = customHambergerButton
    }
    
}

extension TCHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.getTableViewCellHeight()
    }
}

extension TCHomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.noOfHomeItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let homeItem = viewModel.getHomeItem(indexPath.row) else {
                return UITableViewCell()
            }
        
        return viewModel.getTableViewCell(for: homeItem, tableView, indexPath)
    }
}

extension TCHomeViewController {
    
    private func createCustopmButton(with image: UIImage?, and selector: Selector) -> UIButton {
        let buttonFrame = CGRect(x: 0, y: 0, width: 24, height: 24)
        let button = UIButton(frame: buttonFrame)
        button.setBackgroundImage(image, for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }
    
    @objc func notificationButtonTapped(sender: AnyObject)
    {
        customNotificationButton.hasUnread = !customNotificationButton.hasUnread
    }
    
    @objc func searchButtonTapped(sender: AnyObject){
        let screenType = "Search screen"
        presentPlacholderViewController(screenType)
    }
    
    @objc func hamburgerButtonTapped(sender: AnyObject){
        let screenType = "Hamburger menu screen"
        presentPlacholderViewController(screenType)
    }
    
    private func presentPlacholderViewController(_ title: String){
        let showItemStoryboard = UIStoryboard(name: TCPlaceholderViewController.controllerID, bundle: nil)
        let viewController = showItemStoryboard.instantiateViewController(withIdentifier: TCPlaceholderViewController.controllerID) as! TCPlaceholderViewController
        viewController.centerText = title
        self.present(viewController, animated: true, completion: nil)
    }
}
