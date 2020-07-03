//
//  CharacterViewCell.swift
//  MarvelHeroes
//
//  Created by Arturo Carretero Calvo on 16/06/2020.
//  Copyright © 2020 Arturo Carretero Calvo. All rights reserved.
//

import UIKit

class CharacterViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var nameLabel: UILabel!
    
    fileprivate static let cellIdentifier = "CharacterViewCellIdentifier"
    
    // MARK: Life cycle view
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

// MARK: Extension for public functions.
extension CharacterViewCell {
    
    static func createCell(tableView: UITableView) -> CharacterViewCell {
        var cell: CharacterViewCell! = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
            as? CharacterViewCell
        tableView.register(UINib(nibName: "CharacterViewCell", bundle: nil),
                           forCellReuseIdentifier: cellIdentifier)
        cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? CharacterViewCell
        return cell
    }
    
    func hiddenActivityIndicator() {
        UIView.animate(withDuration: 0.2, animations: {
            self.activityIndicator.alpha = 0.0
        }) { (_) in
            self.activityIndicator.stopAnimating()
        }
    }
    
    func wrongRequestImage() {
        self.hiddenActivityIndicator()
        self.thumbnailImageView.image = UIImage(named: "Marvel-comics-logo")
    }
}

// MARK: - Extension private methods.
private extension CharacterViewCell {
}
