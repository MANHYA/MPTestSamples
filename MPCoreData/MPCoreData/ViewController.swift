//
//  ViewController.swift
//  MPCoreData
//
//  Created by Manish on 3/9/19.
//  Copyright © 2019 MANHYA. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var people: [NSManagedObject] = []
    
    
    @IBAction func addName(_ sender: Any) {
        
        let alert = UIAlertController(title: "New Name",
                                      message: "Add a new name",
                                      preferredStyle: .alert)
        
        
        alert.addTextField(configurationHandler: { (textFieldName) in
            textFieldName.placeholder = "name"
        })
        
        alert.addTextField(configurationHandler: { (textFieldMobile) in
            
            textFieldMobile.placeholder = "mobile"
        })
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            
            guard let textField = alert.textFields?.first,
                let nameToSave = textField.text else {
                    return
            }
            
            guard let textFieldMobile = alert.textFields?[1],
                let mobileToSave = textFieldMobile.text else {
                    return
            }
            
            self.save(name: nameToSave, mobile: mobileToSave)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    //insert
    func save(name: String, mobile : String) {
        
        let person = CoreDataManager.shared.insertPerson(name: name, mobile: mobile)
        
        if person != nil {
            people.append(person!)
            tableView.reloadData()
        }
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        
        /*init alert controller with title and message*/
        let alert = UIAlertController(title: "Delete by mobile", message: "Enter mobile", preferredStyle: .alert)
        
        /*configure delete action*/
        let deleteAction = UIAlertAction(title: "Delete", style: .default) { [unowned self] action in
            guard let textField = alert.textFields?.first , let itemToDelete = textField.text else {
                return
            }
            /*pass mobile number to delete(:) method*/
            self.delete(mobile: itemToDelete)
            /*reoad tableview*/
            self.tableView.reloadData()
            
        }
        
        /*configure cancel action*/
        let cancelAciton = UIAlertAction(title: "Cancel", style: .default)
        
        /*add text field*/
        alert.addTextField()
        /*add actions*/
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAciton)
        
        present(alert, animated: true, completion: nil)
    }
    
    func delete(mobile: String) {
        
        let arrRemovedObjects = CoreDataManager.shared.delete(mobile: mobile)
        people = people.filter({ (param) -> Bool in
            
            if (arrRemovedObjects?.contains(param as! Person))!{
                return false
            }else{
                return true
            }
        })
        
    }
    
    func fetchAllPersons(){
        
        if CoreDataManager.shared.fetchAllPersons() != nil{
            
            people = CoreDataManager.shared.fetchAllPersons()!
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAllPersons()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "Cell")
    }
    
    func delete(person : Person){
        CoreDataManager.shared.delete(person: person)
    }
    
    func update(name:String, mobile : String, person : Person) {
        CoreDataManager.shared.update(name: name, mobile: mobile, person: person)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let person = people[indexPath.row]
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "Cell")
        cell.textLabel?.text = person.value(forKeyPath: "name") as? String
        cell.detailTextLabel?.text = person.value(forKeyPath: "mobile") as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        /*get managed object*/
        let person = people[indexPath.row]
        
        /*initialize alert controller*/
        let alert = UIAlertController(title: "Update Name",
                                      message: "Update Name",
                                      preferredStyle: .alert)
        
        /*add name textfield*/
        alert.addTextField(configurationHandler: { (textFieldName) in
            
            /*set name as plaveholder in textfield*/
            textFieldName.placeholder = "name"
            
            /*use key value coding to get value for key "name" and set it as text of UITextField.*/
            textFieldName.text = person.value(forKey: "name") as? String
            
        })
        
        /*add mobile textfield*/
        alert.addTextField(configurationHandler: { (textFieldMobile) in
            
            /*set mobile as plaveholder in textfield*/
            textFieldMobile.placeholder = "mobile"
            
            /*use key value coding to get value for key "mobile" and set it as text of UITextField.*/
            
            textFieldMobile.text = person.value(forKey: "mobile") as? String
        })
        
        /*configure update event*/
        let updateAction = UIAlertAction(title: "Update", style: .default) { [unowned self] action in
            
            guard let textField = alert.textFields?[0],
                let nameToSave = textField.text else {
                    return
            }
            
            guard let textFieldMobile = alert.textFields?[1],
                let mobileToSave = textFieldMobile.text else {
                    return
            }
            
            /*imp part, responsible for update, pass nameToSave and mobile to update: method.*/
            self.update(name : nameToSave, mobile: mobileToSave, person : person as! Person)
            
            /*finally reload table view*/
            self.tableView.reloadData()
            
        }
        
        /*configure delete event*/
        let deleteAction = UIAlertAction(title: "Delete", style: .default) { [unowned self] action in
            
            /*look at implementation of delete method */
            
            self.delete(person : person as! Person)
            
            /*remove person object from array also, so that datasource have correct data*/
            self.people.remove(at: (self.people.index(of: person))!)
            
            /*Finally reload tableview*/
            self.tableView.reloadData()
            
        }
        
        /*configure cancel action*/
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        /*add all the actions*/
        alert.addAction(updateAction)
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        
        /*finally present*/
        present(alert, animated: true)
        
    }
}
