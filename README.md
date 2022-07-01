# watcha-project
[필수구현기능](##팔수구현기능)     
[추가구현기능](##추가구현기능)     
[구현방법](##구현방법)
 


## 필수구현기능

1. KeyWord 검색 및 검색된 아이템 목록 화면   

![Simulator Screen Recording - iPhone 13 - 2022-07-01 at 01 53 04](https://user-images.githubusercontent.com/93653997/176734147-c4d0ef9d-ff43-4455-8993-dad368cb0962.gif)

2. 검색된 아이템 상세화면 및 Favorite On/Off 기능 (앱을 다시시작해도 유지)   

![Simulator Screen Recording - iPhone 13 - 2022-07-01 at 12 51 07](https://user-images.githubusercontent.com/93653997/176819992-755d8883-cd6d-4f8e-8081-8f2193d397ff.gif)


## 추가구현기능

1. 인기있는검색어 키워드를 사용해 검색할수 있는기능 / 인기있는 gif목록을 보여주는 기능   

![Simulator Screen Recording - iPhone 13 - 2022-07-01 at 12 43 35](https://user-images.githubusercontent.com/93653997/176819607-2311c2b1-c82d-41e1-bd09-8b29ed6801a0.gif)

2. 검색어 자동완성기능   

![Simulator Screen Recording - iPhone 13 - 2022-07-01 at 12 44 05](https://user-images.githubusercontent.com/93653997/176819641-0a2697da-f737-409c-afcd-f6a0c114f49f.gif)

3. 모든 아이템 목록화면에 무한스크롤기능    

![Simulator Screen Recording - iPhone 13 - 2022-07-01 at 12 45 32](https://user-images.githubusercontent.com/93653997/176819671-38a1a78a-5add-4daf-a20d-7a1d55a4dfef.gif)

## 구현방법
### API호출  
1. 여러개의 API호출을 한개의 메서드로 호출할수 있게 제네릭문법을 활용해 구현 했습니다   
   
Service
```swift
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
```
2. 인기검색어/인기GIF/검색/자동완성키워드 이렇게 총4개의 호출이 있었는데 이것들의 URL을 열거형으로 분기시켜 어떤 상태인지에 따라 받는 URL을 달리 구현했습니다.
    
APIKey
```swift
enum APIURL {
    var url: String {
        switch self {
        case .mostPopular:
            return "https://api.giphy.com/v1/gifs/trending?\(APIKey.key)&limit=20&rating=g"
        case .trendKeyword:
            return "https://api.giphy.com/v1/trending/searches?\(APIKey.key)"
        case .autocompleteKeword:
            return "https://api.giphy.com/v1/gifs/search/tags?\(APIKey.key)&limit=10"
        case .search:
            return "https://api.giphy.com/v1/gifs/search?\(APIKey.key)&limit=20&rating=g&q="
        }
    }
    case mostPopular
    case trendKeyword
    case autocompleteKeword
    case search
}
```
ViewModel
```swift
final class AutocompleteViewModelList {
    var fetchState: APIURL = .autocompleteKeword
    
    func fetchAutoCompleteKeyword(text: String) {
        let resource = Resource<AutocompleteModel>(url: fetchState.url + "&q=\(text)")
        Service.fetch(resource: resource) { [weak self] result in
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
```
### 즐겨찾기 기능
각각의 아이템마다 고유의 id가 있어서 그 id를 Coredata를 사용해 로컬에 저장해서 사용하는 방식으로 구현 했습니다.   
또한 현재 보고있는 아이템의 id와 CoreData에 저장되어있는 id를 반복문을 통해 비교해 즐겨찾기 버튼의 상태를 바꿨습니다.   
    
CoreDataService   
```swift
enum CoreDataError: Error {
    case uploadError
    case fetchError
    case deleteError
}

struct CoreDataService {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    func uploadCoreData(id: String, completion: @escaping (Result<Void,CoreDataError>) -> Void) {
        let model = Favorite(context: context)
        model.id = id
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(.uploadError))
        }
    }
    func fetchCoreData(completion: @escaping (Result<[Favorite],CoreDataError>) -> Void) {
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        do {
            let model = try context.fetch(request)
            completion(.success(model))
        } catch {
            completion(.failure(.fetchError))
        }
    }
    func deleteCoreData(model: Favorite, completion: @escaping (Result<Void, CoreDataError>) -> Void) {
        context.delete(model)
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(.deleteError))
        }
    }
}
```
CoreDataViewModel
```swift
final class FavoriteViewModel {
    var service: CoreDataService = CoreDataService()
    var model: [Favorite] = []
    var serviceError: Observer<CoreDataError> = Observer(value: .deleteError)
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
```
### 데이터바인딩
데이터 바인딩을 통해 API호출이 성공하는시점, 에러가나는경우, 상태 등을 바로바로 View에 전달할수 있게 구현했습니다.   
Observer
```swift
final class Observer<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    var value: T {
        didSet {
            listener?(value)
        }
    }
    func bind(completion: @escaping (T) -> Void) {
        self.listener = completion
    }
    init(value: T) {
        self.value = value
    }
}
```
ViewModel
```swift
var serviceError: Observer<CoreDataError> = Observer(value: .deleteError)
    var validLikeState: Observer<Bool> = Observer(value: false)
    var fetchSuccess: Observer<Bool> = Observer(value: false)
```
View
```swift
private func setBinding() {
        favoriteViewModel.serviceError.bind { error in
            print("debug: 코어데이터 에러 \(error)")
        }
        favoriteViewModel.fetchSuccess.bind { [weak self] _ in
            self?.favoriteViewModel.validLikeState(id: self?.GIFViewModel?.id ?? "")
        }
        favoriteViewModel.validLikeState.bind { [weak self] bool in
            if bool {
                self?.favoriteButton.tintColor = .red
            } else {
                self?.favoriteButton.tintColor = .white
            }
        }
    }
```
