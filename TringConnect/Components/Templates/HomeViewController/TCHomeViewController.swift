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
    
    let refreshControl = UIRefreshControl()
    var customNotificationButton: CustomBarButton!
    var customSearchButton: UIBarButtonItem!
    var customHambergerButton: UIBarButtonItem!
    var data: TCContextItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        intialSetup()
        getHomeData()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserver()
    }

    private func intialSetup() {
        homepageTableView.delegate = self
        homepageTableView.dataSource = self
        self.tabBarController?.tabBar.isTranslucent = false

        registerTableViewCells()
        addLogoToNavigationBar()
        addNavigationBaritems()
        addRefreshControl()
        addTapGestureForKeyboardDismiss()

    }
    
    private func getHomeData() {
        viewModel.getHomeItems(TCAppConfigurationManager.shared.homeUrl) { [weak self] isSuccess, error in
            guard let weakSelf = self else { return }
            if isSuccess {
                weakSelf.homepageTableView.reloadData()
            }
        }
    }
    
    private func addRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        homepageTableView.addSubview(refreshControl)
    }
    
    private func addTapGestureForKeyboardDismiss() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
    
    func addLogoToNavigationBar() {
        let logo = UIImage(named: "AppLogo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
    }
    
    func addNavigationBaritems() {
        
        let notificationImage = UIImage(named: TCConstants.notificationButton)?.withRenderingMode(.alwaysOriginal)
        let searchImage = UIImage(named: TCConstants.searchButton)?.withRenderingMode(.alwaysOriginal)
        let hamburgerImage = UIImage(named: TCConstants.hamburgerButton)?.withRenderingMode(.alwaysOriginal)
        
        let notificationButton = createCustopmButton(with: notificationImage, and: #selector(notificationButtonTapped))
        let searchButton = createCustopmButton(with: searchImage, and: #selector(searchButtonTapped))
        let hamburgerButton = createCustopmButton(with: hamburgerImage, and: #selector(hamburgerButtonTapped))

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
        
        return viewModel.getTableViewCell(for: homeItem, tableView, indexPath, self)
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
    
    @objc func refresh() {
        getHomeData()
        refreshControl.endRefreshing()
    }
    
    @objc func notificationButtonTapped() {
        customNotificationButton.hasUnread = !customNotificationButton.hasUnread
    }
    
    @objc func searchButtonTapped() {
        let screenType = "Search screen"
        presentPlacholderViewController(screenType)
    }
    
    @objc func hamburgerButtonTapped() {
        let screenType = "Hamburger menu screen"
        presentPlacholderViewController(screenType)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue, self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= (keyboardSize.size.height - self.view.safeAreaInsets.top)
        }
    }

    @objc func keyboardWillHide() {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func presentPlacholderViewController(_ title: String){
        let showItemStoryboard = UIStoryboard(name: TCPlaceholderViewController.controllerID, bundle: nil)
        let viewController = showItemStoryboard.instantiateViewController(withIdentifier: TCPlaceholderViewController.controllerID) as! TCPlaceholderViewController
        viewController.centerText = title
        self.present(viewController, animated: true, completion: nil)
    }
}

extension TCHomeViewController: TCStoryImageIntractionDelegate {
    func imageTapped(imagedata: String) {
        let showItemStoryboard = UIStoryboard(name: TCImageDetailViewController.controllerID, bundle: nil)
        let viewController = showItemStoryboard.instantiateViewController(withIdentifier: TCImageDetailViewController.controllerID) as! TCImageDetailViewController
        viewController.imagedata = imagedata
        self.present(viewController, animated: true, completion: nil)
    }
    
}
