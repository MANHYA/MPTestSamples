//
//  AmountPickerView.swift
//  MPMVVMTableView
//
//  Created by Manish on 5/5/20.
//  Copyright © 2020 MANHYA. All rights reserved.
//

import UIKit
import SnapKit

class AmountPicker: UIView {
    let estimatedRowHeight: CGFloat = 72
    var heightOfCollectioView: CGFloat = 0
    var superViewYoffset: CGFloat = 0
    let isMultiSelectionEnabled = false
    var dataArray: [PickerItemModel] = []
    public var didChangeAmounr: (() -> Void)?
    var collectioView: UICollectionView!
    var doneButton: UIButton!
    var amountTextField: MPTextField!
    var indexPath: IndexPath?
    
    init(_ items: [PickerItemModel]) {
        self.dataArray = items
        heightOfCollectioView = (CGFloat(dataArray.count) * estimatedRowHeight) + (CGFloat(dataArray.count-1) * 30)
        let heightOfFooter = 70
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: heightOfCollectioView + CGFloat(heightOfFooter)))
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    func commonInit() {
        // Collection View
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width, height: estimatedRowHeight)
        layout.sectionInset = UIEdgeInsets(top: 24, left: 0, bottom: 16, right: 0)
        layout.minimumLineSpacing = 16
        collectioView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: heightOfCollectioView), collectionViewLayout: layout)
        addSubview(collectioView)
        collectioView.delegate = self
        collectioView.dataSource = self
        collectioView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectioView.register(AmountPicker.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
        // Button
        doneButton.addTarget(self, action: #selector(doneButtonClicked), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyBoardWillShow(_ notification: Notification)  {
        if let keyBoardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            superViewYoffset = self.superview?.frame.origin.y ?? 0
            self.superview?.frame.origin.y = superViewYoffset - keyBoardSize.height
        }
    }
    
    @objc func keyBoardWillHide(_ notification: Notification) {
        if (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue != nil {
            self.superview?.frame.origin.y = superViewYoffset
        }
    }
    
    @objc func doneButtonClicked(_ sender: UIButton) {
        
    }
}

extension AmountPicker: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath)
        let item = dataArray[indexPath.item]
        return cell
    }
}
