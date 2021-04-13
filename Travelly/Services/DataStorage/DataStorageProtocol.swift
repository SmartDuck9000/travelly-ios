//
//  DataStorageProtocol.swift
//  Travelly
//
//  Created by Георгий Куликов on 21.03.2021.
//



protocol DataStorageProtocol {
    func save(authData: AuthData)
    func getAuthData() -> AuthData?
    func update(authData: AuthData)
    func deleteAuthData()
}
