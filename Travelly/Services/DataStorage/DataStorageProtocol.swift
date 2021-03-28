//
//  DataStorageProtocol.swift
//  Travelly
//
//  Created by Георгий Куликов on 21.03.2021.
//



protocol DataStorageProtocol {
    func save<DataModel: Entity>(entity: DataModel)
    func getFirst<DataModel: Entity>(type: DataModel.Type) -> DataModel?
    func updateFirst<DataModel: Entity>(entity: DataModel)
    func deleteFirst<DataModel: Entity>(type: DataModel.Type)
}
