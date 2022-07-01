//
//  WebService.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/07/01.
//

import Foundation

enum WebServiceError: Error {
    case URLError
    case fetchError
    case dataError
    case jsonDecodeError
}

struct Resource<T: Decodable> {
    let url: String

}

struct WebService {
   static func fetch<T>(resource: Resource<T>, completion: @escaping (Result<T,WebServiceError>) -> Void) {
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
                completion(.success(result))
        }.resume()
    }
}
