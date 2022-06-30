//
//  TrendingViewModel.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/29.
//

import Foundation

final class KeywordViewModel {
    private let service = KeywordService()
    private var items: [TrendingKeyWordViewModelItem] = []
    var serviceError: Observer<ServiceError> = Observer(value: .URLError)
    var fetchSuccess: Observer<Bool> = Observer(value: false)
}

extension KeywordViewModel {
    var count: Int {
        return items.count
    }
    func itemAtIndex(_ index: Int) -> TrendingKeyWordViewModelItem {
        return items[index]
    }
    func fetchTrandingKeword() {
        let url = "https://api.giphy.com/v1/trending/searches?\(APIKey.key)"
        service.fetch(url: url) { [weak self] result in
            switch result {
            case .success(let model):
                let items = model.data.prefix(5).map {
                    TrendingKeyWordViewModelItem(data: $0)
                }
                self?.items = items
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

final class TrendingKeyWordViewModelItem {
    init(data: String) {
        self.keyword = data
    }
    let keyword: String
}
