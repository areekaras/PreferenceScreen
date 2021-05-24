//
//  DropDownTVCell.swift
//  PreferencesScreen
//
//  Created by Shibili Areekara on 24/05/21.
//

import UIKit

class DropDownTVCell: UITableViewCell {
    
    @IBOutlet weak var radioButtonIV: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var country:Country? {
        didSet {
            self.updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.nameLabel.text = ""
    }

    func updateView() {
        self.nameLabel.text = country?.CountryName ?? ""
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
