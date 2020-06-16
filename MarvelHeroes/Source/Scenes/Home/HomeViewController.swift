//
//  HomeViewController.swift
//  MarvelHeroes
//
//  Created Arturo Carretero Calvo on 15/06/2020.
//  Copyright © 2020 Arturo Carretero Calvo. All rights reserved.
//

import UIKit

/// View implementation for scene.
class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: HomePresenter?
    var characters: [Character] = []
    
    fileprivate let heightCell = CGFloat(75.0)
    fileprivate let rowForPagination = Int(10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidUpdate(status: .didLoad)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter?.viewDidUpdate(status: .didAppear)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.presenter?.viewDidUpdate(status: .didDisappear)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.viewDidUpdate(status: .willAppear)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.presenter?.viewDidUpdate(status: .willDisappear)
    }
}

// MARK: View interface implementation methods.
extension HomeViewController: HomeView {
    
    /// Setup the UI view.
    func setupUI() {
        if let navController = self.navigationController {
            AppStyler.styleNavigationBar(navigationController: navController)
        }
        self.centeredNavBarImage()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
    }
    
    /// Localized UI.
    func localizeView() {
    }
    
    /// Load characters in table view
    /// - Parameter characters: character collection
    func show(characters: [Character]) {
        self.characters = characters
        self.tableView.reloadData()
    }
    
    /// Add new object to table view
    /// - Parameter characters: character collection
    func addNewCharacters(characters: [Character]) {
        self.characters.append(contentsOf: characters)
        self.tableView.reloadData()
    }
    
    /// Show empty characters message
    func empty() {
        #warning("EMPTY CHARACTERS OR ERROR. SHOW CELL.")
    }
}

// MARK: Extension for UITableView.
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.heightCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CharacterViewCell = CharacterViewCell.createCell(tableView: tableView)
        cell.configViews(character: self.characters[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.presenter?.select(character: self.characters[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (self.characters.count - self.rowForPagination) {
            self.presenter?.getMoreCharactersWithPagination()
        }
    }
}

// MARK: Extension for private methods.
private extension HomeViewController {
    
    func centeredNavBarImage() {
        let navcontroller = navigationController!
        let image = UIImage(named: "Marvel-comics-logo")
        let imageView = UIImageView(image:image)
        let bannerWidth = navcontroller.navigationItem.accessibilityFrame.size.width
        let bannerHeight = navcontroller.navigationBar.frame.size.height
        guard let imag = image else { return }
        let bannerX = bannerWidth / 2 - imag.size.width / 2
        let bannerY = bannerHeight / 2 - imag.size.height / 2
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
}
