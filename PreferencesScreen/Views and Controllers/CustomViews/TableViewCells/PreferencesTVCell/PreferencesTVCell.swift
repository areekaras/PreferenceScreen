//
//  PreferencesTVCell.swift
//  PreferencesScreen
//
//  Created by Shibili Areekara on 24/05/21.
//

import UIKit

class PreferencesTVCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var isSelectedContainerView: UIView!
    @IBOutlet weak var isSelectedIV: UIImageView!
    @IBOutlet weak var isSelectedView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var liveNotifPref:LiveNotifPref? {
        didSet {
            self.updateView()
            self.updateName()
        }
    }
    
    var isSelectedCell: Bool = false {
        didSet {
            self.updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        updateView()
    }

    func updateView() {
        self.containerView.backgroundColor = isSelectedCell ? UIColor(red: 237/255, green: 248/255, blue: 240/255, alpha: 1) : UIColor(red: 251/255, green: 241/255, blue: 245/255, alpha: 1)
        self.containerView.layer.borderColor = isSelectedCell ? UIColor(red: 191/255, green: 228/255, blue: 197/255, alpha: 1).cgColor : UIColor(red: 237/255, green: 197/255, blue: 213/255, alpha: 1).cgColor
        self.isSelectedContainerView.backgroundColor = isSelectedCell ? UIColor(red: 99/255, green: 187/255, blue: 107/255, alpha: 1) : UIColor(red: 221/255, green: 100/255, blue: 117/255, alpha: 1)
        self.isSelectedIV.isHidden = isSelectedCell ? false : true
        self.containerView.layer.borderWidth = 1
        self.containerView.layer.cornerRadius = 10
        self.isSelectedContainerView.layer.cornerRadius = 15
        self.isSelectedView.layer.cornerRadius = 12.5
        self.clipsToBounds = true
    }
    
    func updateName() {
        self.nameLabel.text = liveNotifPref?.NotificationType ?? ""
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
