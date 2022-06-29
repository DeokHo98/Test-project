//
//  GIFService.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/29.
//

import Foundation

struct GIFService {
    func fetch(url: String, completion: @escaping (Result<GIFModel,ServiceError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.URLError))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.fetchError))
            }
            let response = response as? HTTPURLResponse
            if response?.statusCode != 200 {
                completion(.failure(.responseError))
            }
            guard let data = data else {
                completion(.failure(.dataError))
                return
            }
            do {
                let result = try JSONDecoder().decode(GIFModel.self, from: data)
                    completion(.success(result))
            } catch {
                completion(.failure(.jsonDecodeError))
            }
        }.resume()
    }
}
