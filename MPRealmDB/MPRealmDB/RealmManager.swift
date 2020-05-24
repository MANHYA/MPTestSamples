//
//  RealmManager.swift
//  MPRealmDB
//
//  Created by Manish on 4/16/19.
//  Copyright © 2019 MANHYA. All rights reserved.
//

import UIKit
import RealmSwift

class RealmManager {
    private var   database:Realm
    static let   sharedInstance = RealmManager()
    
    private init() {
        database = try! Realm()
    }
    
    func incrementID() -> Int {
        return (database.objects(Item.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
    
    func getDataFromDB() ->   Results<Item> {
        let results: Results<Item> =   database.objects(Item.self)
        return results
    }
    
    // update particular Object
    func update(object: Item, name:String) {
        try! database.write {
            object.name = name
            database.add(object, update: true)
        }
    }
    
    // add particular object
    func addData(object: Item)   {
        try! database.write {
            database.add(object)
        }
    }
    
    // add array of objects
    func addData(objects: Results<Item>) {
        try? database.write ({
            database.add(objects)
        })
    }
    
    // delete all objects
    func deleteAllFromDatabase()  {
        try!   database.write {
            database.deleteAll()
        }
    }
    
    // delete array of objects
    func deleteData(objects: Results<Item>)  {
        try!   database.write {
            database.deleteAll()
        }
    }
    
    // delete particular object
    func deleteData(object: Item)   {
        try!   database.write {
            database.delete(object)
        }
    }
}

class Item: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id : Int, name: String) {
        self.init()
        self.id = id
        self.name = name
    }
}
