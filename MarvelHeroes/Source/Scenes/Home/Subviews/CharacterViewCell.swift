//
//  CharacterViewCell.swift
//  MarvelHeroes
//
//  Created by Arturo Carretero Calvo on 16/06/2020.
//  Copyright © 2020 Arturo Carretero Calvo. All rights reserved.
//

import UIKit

class CharacterViewCell: UITableViewCell {
    
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
        if cell == nil {
            tableView.register(UINib(nibName: "CharacterViewCell", bundle: nil),
                               forCellReuseIdentifier: cellIdentifier)
            cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
                as? CharacterViewCell
        }
        return cell
    }
    
    func configViews(character: Character) {
        guard let name = character.name else { return }
        self.nameLabel.text = name
    }
}
