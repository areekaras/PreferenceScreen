//
//  SelectItemsView.swift
//  PreferencesScreen
//
//  Created by Shibili Areekara on 23/05/21.
//

import UIKit

class SelectItemsView: UIView {
    
    @IBOutlet var container: UIView!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var selectField: UIView!
    @IBOutlet weak var selectFieldLabel: UILabel!
    @IBOutlet weak var selectFieldArrowIcon: UIImageView!
    
    var showDropDown: ((Bool)->())?
    
    var isShownDropDown = false
    
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
    }
    
    private func setSelectFieldBorder() {
        self.selectField.layer.cornerRadius = 6
        self.selectField.layer.borderColor = UIColor.lightGray.cgColor
        self.selectField.layer.borderWidth = 1

        self.clipsToBounds = true
    }

    @IBAction func arrowButtonClicked(_ sender: UIButton) {
        isShownDropDown = !isShownDropDown
        self.selectFieldArrowIcon.image = UIImage(named: isShownDropDown ?  "chevronUp" : "chevronDown")
        self.showDropDown?(isShownDropDown)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
}
