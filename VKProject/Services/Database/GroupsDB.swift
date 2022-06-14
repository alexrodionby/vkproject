//
//  GroupsDB.swift
//  VKProject
//
//  Created by Alexandr Rodionov on 14.06.22.
//

import Foundation
import RealmSwift

final class GroupsDB {
    
    init() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 4)
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
    }
    
    func save(_ items: [GroupDAO]) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(items)
        }
    }
    
    func fetch() -> Results<GroupDAO> {
        let realm = try! Realm()
        
        let groups: Results<GroupDAO> = realm.objects(GroupDAO.self)
        return groups
    }
    
    func delete(_ item: GroupDAO) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(item)
        }
    }
    
}
