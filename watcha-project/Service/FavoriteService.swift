//
//  CoreDataService.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/30.
//

import CoreData
import UIKit

enum FavoriteError: Error {
    case uploadError
    case fetchError
    case deleteError
}

struct FavoriteService {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    func uploadCoreData(id: String, completion: @escaping (Result<Void,FavoriteError>) -> Void) {
        let model = Favorite(context: context)
        model.id = id
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(.uploadError))
        }
    }
    func fetchCoreData(completion: @escaping (Result<[Favorite],FavoriteError>) -> Void) {
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        do {
            let model = try context.fetch(request)
            completion(.success(model))
        } catch {
            completion(.failure(.fetchError))
        }
    }
    func deleteCoreData(model: Favorite, completion: @escaping (Result<Void, FavoriteError>) -> Void) {
        context.delete(model)
        do {
            try context.save()
            completion(.success(()))
        } catch {
            print("디버그")
            completion(.failure(.deleteError))
        }
    }
    
}
