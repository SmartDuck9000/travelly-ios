//
//  RealmDataStorage.swift
//  Travelly
//
//  Created by Георгий Куликов on 21.03.2021.
//

import RealmSwift


class RealmDataStorage: DataStorageProtocol {
    
    private let realm: Realm?
    
    init() {
        do {
            realm = try Realm()
        } catch {
            realm = nil
            print(error.localizedDescription)
        }
    }
    
    func save(authData: AuthData) {
        do {
            try realm?.write {
                realm?.add(authData)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    func getAuthData() -> AuthData? {
        realm?.objects(AuthData.self).first
    }
    
    func update(authData: AuthData) {
        do {
            try realm?.write {
                realm?.add(authData, update: .modified)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteAuthData() {
        do {
            try realm?.write {
                if let obj = realm?.objects(AuthData.self).first {
                    realm?.delete(obj)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
