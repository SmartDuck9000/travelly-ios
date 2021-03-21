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
    
    
    func save<DataModel: Entity>(dataModel: DataModel) {
        try! realm.write {
            self.realm.add(dataModel)
        }
    }
    
    func getFirst<DataModel: Entity>(type: DataModel.Type) -> DataModel? {
        return realm.objects(type).first
    }
}
