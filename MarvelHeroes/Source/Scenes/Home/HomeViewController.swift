//
//  HomeViewController.swift
//  MarvelHeroes
//
//  Created Arturo Carretero Calvo on 15/06/2020.
//  Copyright © 2020 Arturo Carretero Calvo. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

/// View implementation for scene.
class HomeViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var notResultsLabel: UILabel!

  var presenter: HomePresenter?
  var characters: [Character] = []
  var isSearchBarEmpty: Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  var searchControl: Bool = false

  let searchController = UISearchController(searchResultsController: nil)

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
    self.notResultsLabel.isHidden = true
    self.notResultsLabel.text = NSLocalizedString("home.not.results.title.label", comment: String())
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.tableFooterView = UIView()
    self.searchController.searchBar.delegate = self
    self.searchController.searchResultsUpdater = self
    self.searchController.obscuresBackgroundDuringPresentation = false
    self.searchController.searchBar.placeholder = NSLocalizedString("home.search.title.label", comment: String())
    self.searchController.searchBar.tintColor = AppStyler.defaultRedAppColor()
    self.navigationItem.searchController = searchController
    self.definesPresentationContext = true
  }

  /// Localized UI.
  func localizeView() {
  }

  /// Load characters in table view
  /// - Parameter characters: character collection
  func show(characters: [Character]) {
    self.searchControl = false
    self.characters = characters
    self.tableView.reloadData()
  }

  func showCharactersFromSearch(characters: [Character]) {
    if !characters.isEmpty {
      self.tableView.isHidden = false
      self.notResultsLabel.isHidden = true
      self.characters.removeAll()
      self.characters = characters
      self.tableView.reloadData()
    } else {
      self.tableView.isHidden = true
      self.notResultsLabel.isHidden = false
    }
  }

  /// Add new object to table view
  /// - Parameter characters: character collection
  func addNewCharacters(characters: [Character]) {
    self.characters.append(contentsOf: characters)
    self.tableView.reloadData()
  }

  /// Show empty characters message
  func empty() {
    self.tableView.isHidden = true
    self.notResultsLabel.isHidden = false
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
    let character = self.characters[indexPath.row]
    guard let name = character.name else { return UITableViewCell() }
    cell.nameLabel.text = name
    guard let urlImage = character.thumbnail?.url,
          let url = URL(string: urlImage) else {
      cell.wrongRequestImage()
      return UITableViewCell()
    }
    cell.thumbnailImageView.af.setImage(withURL: url)
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.tableView.deselectRow(at: indexPath, animated: true)
    self.presenter?.select(character: self.characters[indexPath.row])
  }

  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.row == (self.characters.count - self.rowForPagination) && !self.searchControl {
      self.presenter?.getMoreCharactersWithPagination()
    }
  }
}

// MARK: Extension for UISearchController methods.

extension HomeViewController: UISearchResultsUpdating, UISearchBarDelegate {

  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    self.presenter?.reloadOriginalData()
  }

  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    guard let text = searchBar.text else { return }
    self.filterContentForSearchText(text)
  }
}

// MARK: Extension for private methods.

private extension HomeViewController {

  func filterContentForSearchText(_ searchText: String) {
    printDebug("Search: \(searchText)")
    if searchText.count > 3 {
      self.searchControl = true
      self.presenter?.searchCustom(string: searchText)
    }
  }

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
