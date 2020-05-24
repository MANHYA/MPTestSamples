//
//  ViewController.swift
//  MPMVVMTableView
//
//  Created by Manish on 3/5/20.
//  Copyright © 2020 MANHYA. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: BaseViewController {
    
    private var viewModel = ViewModel()
    private var tableView: UITableView = UITableView.init(frame: CGRect.zero, style: .plain)
    private lazy var tableViewDataSource = TableViewDataSource(viewModel: viewModel)
    private lazy var tableViewDelegate = TableViewDelegate(viewModel: viewModel)
    
    var sd: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constants.title
        viewModel.delegate = self
        // Set up tableview
        self.setUpTableView()
    }
    
    func setUpTableView() {
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 200
        tableView.register(TableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDelegate
        tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (maker) in
            maker.leftMargin.rightMargin.equalTo(0)
            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview().inset(300)
        }
    }
}

extension ViewController: ViewModelDelegate {
    func reloadTable() {
        if #available(iOS 13.0, *) {
            Router.shared.launch(on: self)
         //   let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController2")
         //   self.present(vc, animated: false, completion: {})
        } else {
            // Fallback on earlier versions
        }
        
    }
}
