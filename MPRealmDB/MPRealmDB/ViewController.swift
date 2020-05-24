//
//  ViewController.swift
//  MPRealmDB
//
//  Created by Manish on 4/16/19.
//  Copyright © 2019 MANHYA. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    var index: IndexPath?
    var item: Item?
    
    var items: Results<Item> {
        return RealmManager.sharedInstance.getDataFromDB()
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noteTxt: UITextField!
    
    @IBAction func deleteBtnAction(_ sender: Any) {
        if let item = item {
            RealmManager.sharedInstance.deleteData(object: item)
            refresh()
        }
    }
    
    @IBAction func updateBtnAction(_ sender: Any) {
        guard !noteTxt.text!.isEmpty else {return}
        
        if let item = item {
            let workouts = items.filter({$0.id == item.id})
            RealmManager.sharedInstance.update(object: workouts.first!, name: noteTxt.text!)
            refresh()
        }
    }
    
    @IBAction func addBtnAction(_ sender: Any) {
        guard !noteTxt.text!.isEmpty else {return}
        let item = Item(id:Int(Date().timeIntervalSince1970), name: noteTxt.text ?? "")
        RealmManager.sharedInstance.addData(object: item)
        refresh()
    }

    func refresh() {
        noteTxt.text = ""
        self.view.endEditing(true)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        
        let item = items[indexPath.row]
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.id.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath
        item = items[indexPath.row]
        noteTxt.text = item?.name
    }

}

