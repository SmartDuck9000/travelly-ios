//
//  RealmDataStorage.swift
//  Travelly
//
//  Created by Георгий Куликов on 21.03.2021.
//

import RealmSwift


class RealmDataStorage: DataStorageProtocol {
    
    private let realm: Realm
    
    init() {
        realm = try! Realm()
    }
    
    
    func save<DataModel: Entity>(entity: DataModel) {
        try! realm.write {
            realm.add(entity)
        }
    }
    
    func getFirst<DataModel: Entity>(type: DataModel.Type) -> DataModel? {
        return realm.objects(type).first
    }
    
    func updateFirst<DataModel: Entity>(entity: DataModel) {
        try! realm.write {
            realm.add(entity, update: .modified)
        }
    }
    
    func deleteFirst<DataModel: Entity>(type: DataModel.Type) {
        try! realm.write {
            if let obj = realm.objects(type).first {
                realm.delete(obj)
            }
        }
    }
}
