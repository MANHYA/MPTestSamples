//
//  ViewModel.swift
//  MPMVVMTableView
//
//  Created by Manish on 3/5/20.
//  Copyright © 2020 MANHYA. All rights reserved.
//

import UIKit

protocol ViewModelDelegate: class {
    func reloadTable()
}

class ViewModel: NSObject {
    var inputFieldArray = [InputItemModel]()
    weak var delegate: ViewModelDelegate?
    
    public init(_ delegate: ViewModelDelegate? = nil) {
        super.init()
        self.delegate = delegate
    }

    public var itemsCount: Int {
        return inputFieldArray.count
    }
    
    public func item(at index: Int) -> InputItemModel? {
        return inputFieldArray[index]
    }
    
    public func add(item: InputItemModel) {
        inputFieldArray.append(item)
    }
    
    public func delete(at index: Int) {
        inputFieldArray.remove(at: index)
    }
    
    public func edit(item: InputItemModel, at index: Int) {
        inputFieldArray[index] = item
    }
    
    public func getInputItems() {
        inputFieldArray.removeAll()
        inputFieldArray.append(InputItemModel(placeholder: "Plain Text", inputType: .textInput, id: .none))
        inputFieldArray.append(InputItemModel(placeholder: "Date Picker", inputType: .datePicker, id: .date))
        inputFieldArray.append(InputItemModel(placeholder: "Amount Picker", inputType: .amountPicker, id: .amount))
    }
    
    public func didClickAmountPicker(id: InputFieldId) {
        delegate?.reloadTable()
    }
    
    public func didClickDatePicker(id: InputFieldId) {
        delegate?.reloadTable()
    }
    
    public func getCell(with model: InputItemModel, cell: TableViewCell, delegate: UITextFieldDelegate) -> TableViewCell{
        switch model.inputType {
        case .amountPicker:
            cell.config(with: model, controlDelegate: delegate, dataModel: ({self.didClickAmountPicker(id: .amount)}, "amount Value") as Any)
        case .datePicker:
            cell.config(with: model, controlDelegate: delegate, dataModel: ({self.didClickDatePicker(id: .date)}, "date Value") as Any)
        case .textInput:
            cell.config(with: model, controlDelegate: delegate, dataModel: ("date Value") as Any)
        case .none:
            break
        }
        return cell
    }
}
