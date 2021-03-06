//
//  TrendingViewModel.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/29.
//

import Foundation

final class KeywordViewModelList {
    private var items: [TrendingKeyWordViewModelItem] = []
    var serviceError: Observer<WebServiceError> = Observer(value: .URLError)
    var fetchSuccess: Observer<Bool> = Observer(value: false)
    var fetchState: APIURL = .trendKeyword
}

extension KeywordViewModelList {
    var count: Int {
        return items.count
    }
    func itemAtIndex(_ index: Int) -> TrendingKeyWordViewModelItem {
        return items[index]
    }
    func fetchTrandingKeword() {
        let resource = Resource<KeywordModel>(url: fetchState.url)
        WebService.fetch(resource: resource) { [weak self] result in
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
        self.showKeyword = data
    }
    let showKeyword: String
    var searchKeyword: String {
        return showKeyword.removingWhitespaces()
    }
}
