# watcha-project

## 필수 구현 기능

1. KeyWord 검색 및 검색된 아이템 목록 화면   

![Simulator Screen Recording - iPhone 13 - 2022-07-01 at 01 53 04](https://user-images.githubusercontent.com/93653997/176734147-c4d0ef9d-ff43-4455-8993-dad368cb0962.gif)

2. 검색된 아이템 상세화면 및 Favorite On/Off 기능 (앱을 다시시작해도 유지)   

![Simulator Screen Recording - iPhone 13 - 2022-07-01 at 12 51 07](https://user-images.githubusercontent.com/93653997/176819992-755d8883-cd6d-4f8e-8081-8f2193d397ff.gif)


## 추가 구현 기능

1. 인기있는검색어 키워드를 사용해 검색할수 있는기능 / 인기있는 gif목록을 보여주는 기능   

![Simulator Screen Recording - iPhone 13 - 2022-07-01 at 12 43 35](https://user-images.githubusercontent.com/93653997/176819607-2311c2b1-c82d-41e1-bd09-8b29ed6801a0.gif)

2. 검색어 자동완성기능   

![Simulator Screen Recording - iPhone 13 - 2022-07-01 at 12 44 05](https://user-images.githubusercontent.com/93653997/176819641-0a2697da-f737-409c-afcd-f6a0c114f49f.gif)

3. 모든 아이템 목록화면에 무한스크롤기능    

![Simulator Screen Recording - iPhone 13 - 2022-07-01 at 12 45 32](https://user-images.githubusercontent.com/93653997/176819671-38a1a78a-5add-4daf-a20d-7a1d55a4dfef.gif)

## 구현 방법
### API호출  
1. API 호출의 경우 인기검색어/인기GIF/검색/자동완성키워드 이렇게 총4개의 호출이 있었는데 이것들의 URL을 열거형으로 분기시켜 어떤 상태인지에 따라 받는 URL을 달리 구현했습니다.

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
