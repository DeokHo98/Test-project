//
//  GIFViewModel.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/29.
//

import Foundation


final class GIFViewModelList {
    var items: [GIFViewModelItem] = []
    var serviceError: Observer<ServiceError> = Observer(value: .URLError)
    var fetchSuccess: Observer<Bool> = Observer(value: true)
    var fetchState: APIURL = .mostPopular
    var pagingStart: Bool = false
    var offset: Int = 0
    var cellOffSet: Observer<Int> = Observer(value: 0)
}
extension GIFViewModelList {
    var count: Int {
        return items.count
    }
    func itemAtIndex(_ index: Int) -> GIFViewModelItem {
        return items[index]
    }
    func fetchMostGIF(text: String = "") {
        let resource = Resource<GIFModel>(url: fetchState.url + text)
        Service.fetch(resource: resource) { [weak self] result in
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
    func nextPageFetch(text: String = "") {
        offset += 20
        let resource = Resource<GIFModel>(url: fetchState.url + text + "&offset=\(offset)")
        Service.fetch(resource: resource) { [weak self] result in
            switch result {
            case .success(let model):
                model.data.forEach {
                    let item = GIFViewModelItem.init(model: $0)
                    self?.items.append(item)
                }
                DispatchQueue.main.async {
                    self?.pagingStart = false
                    self?.fetchSuccess.value = true
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.serviceError.value = error
                    self?.pagingStart = false
                    self?.offset -= 20
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
    var userName: String {
        return model.user?.displayName ?? "Source"
    }
    var email: String {
        return "@\(model.username)"
    }
    var userProfileImage: String {
        return model.user?.avatarURL ?? ""
    }
    var id: String {
        return model.id
    }
}






