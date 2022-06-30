//
//  WebService.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/07/01.
//

import Foundation

enum ServiceError: Error {
    case URLError
    case fetchError
    case dataError
    case responseError
    case jsonDecodeError
}

struct Resource<T: Decodable> {
    let url: String

}

struct Service {
   static func fetch<T>(resource: Resource<T>, completion: @escaping (Result<T,ServiceError>) -> Void) {
        guard let url = URL(string: resource.url) else {
            completion(.failure(.URLError))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.fetchError))
                return
            }
            guard let data = data else {
                completion(.failure(.dataError))
                return
            }
            let result = try? JSONDecoder().decode(T.self, from: data)
            guard let result = result else {
                completion(.failure(.jsonDecodeError))
                return
            }
            DispatchQueue.main.async {
                completion(.success(result))
            }
        }.resume()
    }
}
