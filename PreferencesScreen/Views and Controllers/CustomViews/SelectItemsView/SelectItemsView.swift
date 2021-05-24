//
//  SelectItemsView.swift
//  PreferencesScreen
//
//  Created by Shibili Areekara on 23/05/21.
//

import UIKit

class SelectItemsView: UIView, UISearchBarDelegate {
    
    @IBOutlet var container: UIView!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var selectField: UIView!
    @IBOutlet weak var selectFieldLabel: UILabel!
    @IBOutlet weak var selectSerchField: UISearchBar!
    @IBOutlet weak var selectFieldArrowIcon: UIImageView!
    
    var showDropDown: ((Bool)->())?
    
    var searched: ((String)->())?

    var isShownDropDown = false {
        didSet {
            self.selectFieldArrowIcon.image = UIImage(named: isShownDropDown ?  "chevronUp" : "chevronDown")
            self.selectFieldLabel.isHidden = isShownDropDown
            self.selectSerchField.isHidden = !isShownDropDown
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    private func commonInit() {
        self.setXib()
        self.setSelectFieldBorder()
    }
    
    private func setXib() {
        Bundle.main.loadNibNamed(ViewNames.SelectItemsView, owner: self, options: nil)
        addSubview(container)
        container.frame = self.bounds
        container.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        selectSerchField.delegate = self
    }
    
    private func setSelectFieldBorder() {
        self.selectField.layer.cornerRadius = 6
        self.selectField.layer.borderColor = UIColor.lightGray.cgColor
        self.selectField.layer.borderWidth = 1
        self.clipsToBounds = true
    }

    @IBAction func arrowButtonClicked(_ sender: UIButton) {
        isShownDropDown = !isShownDropDown
        self.showDropDown?(isShownDropDown)
    }
        
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searched?(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
}
