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
                self.nameLabel.textColor = UIColor.green
                self.radioButtonIV.image = UIImage(named: "radioOn")
            } else {
                self.nameLabel.textColor = UIColor.black
                self.radioButtonIV.image = UIImage(named: "radioOff")
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
