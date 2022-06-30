//
//  FavoriteViewModel.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/30.
//

import Foundation

final class FavoriteViewModel {
    var service: FavoriteService = FavoriteService()
    var model: [Favorite] = []
    var serviceError: Observer<FavoriteError> = Observer(value: .deleteError)
    var validLikeState: Observer<Bool> = Observer(value: false)
    var fetchSuccess: Observer<Bool> = Observer(value: false)
    var id: [String] {
        return self.model.map {
            $0.id ?? ""
        }
    }
}

extension FavoriteViewModel {
    func validLikeState(id: String) {
        for i in model {
            if i.id == id {
                self.validLikeState.value = true
                break
            } else {
                self.validLikeState.value = false
            }
        }
    }
    func like(id: String) {
        service.uploadCoreData(id: id) { [weak self] result in
            switch result {
            case .success():
                self?.validLikeState.value = true
            case .failure(let error):
                self?.serviceError.value = error
            }
        }
    }
    func fetch() {
        service.fetchCoreData { [weak self] result in
            switch result {
            case .success(let model):
                self?.model = model
                self?.fetchSuccess.value = true
            case .failure(let error):
                self?.serviceError.value = error
            }
        }
    }
    func unlike(id: String) {
        for i in model {
            if i.id == id {
                service.deleteCoreData(model: i) { [weak self] result in
                    switch result {
                    case .success():
                        self?.validLikeState.value = false
                    case .failure(let error):
                        self?.serviceError.value = error
                    }
                }
            }
        }

        
    }
}
