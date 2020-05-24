import UIKit
/*
class SimplePickerView : UIPickerView {
   
    class SimplePickerViewModel : NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        
        var titles: [String]
        var selectionHandler: ((_ pickerView: UIPickerView, _ row: Int, _ title: String) -> ())?
        
        init(titles: [String], selectionHandler: ((_ pickerView: UIPickerView, _ row: Int, _ title: String) -> ())? = nil) {
            self.titles = titles
            self.selectionHandler = selectionHandler
        }

        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return titles.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return titles[row]
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            selectionHandler?(pickerView, row, titles[row])
        }
    }

    let model: SimplePickerViewModel
    
    init(titles: [String], dropdownField: UITextField, selectionHandler: ((_ pickerView: UIPickerView, _ row: Int, _ title: String) -> ())? = nil) {
        self.model = SimplePickerViewModel(titles: titles, selectionHandler: selectionHandler)
        print("titles: \(titles)")
        super.init(frame: CGRect.zero)
        
        self.delegate = model
        self.dataSource = model
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.model = SimplePickerViewModel(titles: [], selectionHandler: nil)
        super.init(coder: aDecoder)
    }
}*/

class MyPickerView : UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var pickerData : [String]!
    var pickerTextField : UITextField!
    var selectionHandler: ((_ selectedText: String) -> ())?
    
    init(pickerData: [String], dropdownField: UITextField) {
        super.init(frame: CGRect.zero)
        
        self.pickerData = pickerData
        self.pickerTextField = dropdownField
        
        self.delegate = self
        self.dataSource = self
        
        DispatchQueue.main.async {
            if pickerData.count > 0 {
                self.pickerTextField.text = self.pickerData[0]
                self.pickerTextField.isEnabled = true
            } else {
                self.pickerTextField.text = nil
                self.pickerTextField.isEnabled = false
            }
        }
        
        if self.pickerTextField.text != nil  && self.selectionHandler != nil {
            selectionHandler!(self.pickerTextField.text!)
        }
    }

    convenience init(pickerData: [String], dropdownField: UITextField, selectionHandler: ((_ selectedText: String) -> ())? = nil) {
        self.init(pickerData: pickerData, dropdownField: dropdownField)
        self.selectionHandler = selectionHandler
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Sets number of columns in picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Sets the number of rows in the picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // This function sets the text of the picker view to the content of the "salutations" array
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return pickerData[row]
    }
    
    // When user selects an option, this function will set the text of the text field to reflect
    // the selected option.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField.text = pickerData[row]
        
        if self.pickerTextField.text != nil && self.selectionHandler != nil {
            selectionHandler!(self.pickerTextField.text!)
        }
    }
}

extension UITextField {
    
    func loadDropdownData(data: [String]) {
        self.inputView = MyPickerView(pickerData: data, dropdownField: self)
    }
    
    func loadDropdownData(data: [String], selectionHandler: @escaping (_ title: String) -> ()) {
        self.inputView = MyPickerView(pickerData: data, dropdownField: self, selectionHandler: selectionHandler)
    }
}
