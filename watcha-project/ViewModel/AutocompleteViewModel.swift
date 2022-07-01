//
//  AutocompleteViewModel.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/30.
//

import Foundation

final class AutocompleteViewModelList {
    var items: [AutocompleteViewModelItem] = []
    var serviceError: Observer<WebServiceError> = Observer(value: .URLError)
    var fetchSuccess: Observer<Bool> = Observer(value: false)
    var fetchState: APIURL = .autocompleteKeyword
}

extension AutocompleteViewModelList {
    var count: Int {
        return items.count
    }
    func itemAtIndex(_ index: Int) -> AutocompleteViewModelItem {
        return items[index]
    }
    func fetchAutoCompleteKeyword(text: String) {
        let resource = Resource<AutocompleteModel>(url: fetchState.url + "&q=\(text)")
        WebService.fetch(resource: resource) { [weak self] result in
            switch result {
            case .success(let model):
                let items = model.data.map {
                    AutocompleteViewModelItem(model: $0)
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

final class AutocompleteViewModelItem {
    init(model: AutocompleteDatum) {
        self.model = model
    }
    let model: AutocompleteDatum
    var showKeyword: String {
        return self.model.name
    }
    var searchKeyword: String {
        let string = self.model.name.removingWhitespaces()
        return string
    }
}
