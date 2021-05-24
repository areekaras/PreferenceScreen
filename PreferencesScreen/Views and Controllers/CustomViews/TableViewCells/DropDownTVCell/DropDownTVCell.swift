//
//  DropDownTVCell.swift
//  PreferencesScreen
//
//  Created by Shibili Areekara on 24/05/21.
//

import UIKit

struct DropDownTVCellDataModel {
    var id: String?
    var name: String?
}

class DropDownTVCell: UITableViewCell {
    
    @IBOutlet weak var radioButtonIV: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var country:Country? {
        didSet {
            self.updateDataModel(country: country)
        }
    }
    
    var team:Team? {
        didSet {
            self.updateDataModel(team: team)
        }
    }
    
    var dataModel: DropDownTVCellDataModel? {
        didSet {
            self.updateView()
        }
    }
    
    var isSelectedCell: Bool = true {
        didSet {
            if isSelectedCell {
                let green = UIColor.init(displayP3Red: 100/255.0, green: 185/255.0, blue: 105/255.0, alpha: 1.0)
                self.nameLabel.textColor = green
                self.radioButtonIV.image = UIImage(named: "checkbox")
                self.radioButtonIV.imageColor = green
            } else {
                self.nameLabel.textColor = UIColor.black
                self.radioButtonIV.image = UIImage(named: "square-outline")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.nameLabel.text = ""
    }
    
    func updateDataModel(country:Country? = nil, team:Team? = nil) {
        if let country = country {
            dataModel = DropDownTVCellDataModel(id: country.CountryID, name: country.CountryName)
        } else if let team = team {
            dataModel = DropDownTVCellDataModel(id: team.TeamGUID, name: team.TeamName)
        }
    }

    func updateView() {
        self.nameLabel.text = dataModel?.name ?? ""
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension UIImageView {
    var imageColor: UIColor? {
        set (newValue) {
            guard let image = image else { return }
            if newValue != nil {
                self.image = image.withRenderingMode(.alwaysTemplate)
                tintColor = newValue
            } else {
                self.image = image.withRenderingMode(.alwaysOriginal)
                tintColor = UIColor.clear
            }
        }
        get { return tintColor }
    }
}
