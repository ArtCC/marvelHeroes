//
//  DetailViewController.swift
//  MarvelHeroes
//
//  Created Arturo Carretero Calvo on 15/06/2020.
//  Copyright © 2020 Arturo Carretero Calvo. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

/// View implementation for scene.
class DetailViewController: UIViewController {
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var presenter: DetailPresenter?
    
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
extension DetailViewController: DetailView {
    
    /// Setup the UI view.
    func setupUI() {
        self.activityIndicator.startAnimating()
    }
    
    /// Localized UI.
    func localizeView() {
    }
    
    func show(character: Character) {
        guard let name = character.name, let description = character.description else { return }
        self.nameLabel.text = name
        self.descriptionLabel.text = description.isEmpty ? NSLocalizedString("detail.not.description.label", comment: String()) : description
        
        guard let urlImage = character.thumbnail?.url,
            let url = URL(string: urlImage) else {
                self.hiddenActivityIndicator()
                return
        }
        AF.request(url.absoluteString).responseImage { response in
            if case .success(let image) = response.result {
                self.hiddenActivityIndicator()
                self.characterImageView.image = image
            } else {
                self.hiddenActivityIndicator()
            }
        }
    }
}

// MARK: Extension for private methods.
private extension DetailViewController {
    
    func hiddenActivityIndicator() {
        UIView.animate(withDuration: 0.2, animations: {
            self.activityIndicator.alpha = 0.0
        }) { (_) in
            self.activityIndicator.stopAnimating()
        }
    }
}
