//
//  TrendingViewModel.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/29.
//

import Foundation

final class TrendingKeyWordViewModel {
    let service = TrendingKeyWordService()
    
    var model: TrendingKeyWordModel = TrendingKeyWordModel.EMPTY
    var serviceError: Observable<ServiceError> = Observable(.jsonDecodeError)
    var fetchSuccess: Observable<Bool> = Observable(false)
}

extension TrendingKeyWordViewModel {
    var count: Int {
        let prefix = self.model.data.prefix(5)
        return prefix.count
    }
    func keyword(indexPath: Int) -> String {
        let prefix = self.model.data.prefix(5)
        return prefix[indexPath]
    }
    func fetchTrandingKeword() {
        let url = "https://api.giphy.com/v1/trending/searches?api_key=MjCPlYY5U7JKYjuCuWac3SSmrropRpI1"
        service.fetch(url: url) { [weak self] result in
            switch result {
            case .success(let model):
                self?.model = model
                DispatchQueue.main.async {
                    self?.fetchSuccess.value = true
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.serviceError.value = error
                }
            }
        }
    }
}

