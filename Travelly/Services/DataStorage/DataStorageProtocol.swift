//
//  DataStorageProtocol.swift
//  Travelly
//
//  Created by Георгий Куликов on 21.03.2021.
//



protocol DataStorageProtocol {
    func save<DataModel: Entity>(dataModel: DataModel)
    func getFirst<DataModel: Entity>(type: DataModel.Type) -> DataModel?
}
