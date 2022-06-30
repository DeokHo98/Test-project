//
//  GIFViewModel.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/29.
//

import Foundation

final class GIFViewModelList {
    private let service = GIFService()
    var items: [GIFViewModelItem] = []
    var serviceError: Observer<ServiceError> = Observer(value: .URLError)
    var fetchSuccess: Observer<Bool> = Observer(value: true)
}
extension GIFViewModelList {
    var count: Int {
        return items.count
    }
    func itemAtIndex(_ index: Int) -> GIFViewModelItem {
        return items[index]
    }
    func fetchMostPopular() {
        let url = "https://api.giphy.com/v1/gifs/trending?\(APIKey.key)&limit=20&rating=g"
        service.fetch(url: url) { [weak self] result in
            switch result {
            case .success(let model):
                let items = model.data.map {
                    GIFViewModelItem.init(model: $0)
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

final class GIFViewModelItem {
    init(model: Datum) {
        self.model = model
    }
    let model: Datum
    
    var imageURL: String {
        return model.images.fixedWidthStill.url
    }
    var height: Int {
        return Int(model.images.fixedWidthStill.height) ?? 0
    }
}
