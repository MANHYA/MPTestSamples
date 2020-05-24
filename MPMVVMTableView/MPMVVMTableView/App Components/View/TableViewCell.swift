//
//  TableViewCell.swift
//  MPMVVMTableView
//
//  Created by Manish on 3/5/20.
//  Copyright © 2020 MANHYA. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func config(with uiModel: InputItemModel, controlDelegate: UITextFieldDelegate, dataModel: Any?) {
        switch uiModel.inputType {
        case .textInput:
            let view = MPTextField()
            view.delegate = controlDelegate
            view.accessibilityIdentifier = uiModel.id.rawValue
            view.placeholder = uiModel.placeHolder
            prepareCellView(view: view)
        case .datePicker:
            let view = MPPickerTextField()
            view.delegate = controlDelegate
            view.accessibilityIdentifier = uiModel.id.rawValue
            view.placeholder = uiModel.placeHolder
            let data = dataModel as? ((() -> Void)?, String?)
            view.didClickPickerField = data?.0
            prepareCellView(view: view)
        case .amountPicker:
            let view = MPPickerTextField()
            view.delegate = controlDelegate
            view.accessibilityIdentifier = uiModel.id.rawValue
            view.placeholder = uiModel.placeHolder
            let data = dataModel as? ((() -> Void)?, String?)
            view.didClickPickerField = data?.0
            prepareCellView(view: view)
        default:break
        }
    }
    
    func prepareCellView(view: UIView, height: CGFloat = 70) {
        self.contentView.subviews.forEach({$0.removeFromSuperview()})
        self.contentView.addSubview(view)
        view.snp.makeConstraints { (maker) in
            maker.left.right.equalToSuperview().inset(20)
            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.height.equalTo(height)
        }
    }
}
