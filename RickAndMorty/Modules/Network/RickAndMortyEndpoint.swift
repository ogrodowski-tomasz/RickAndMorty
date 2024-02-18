import Foundation

enum RickAndMortyEndpoint {
    case charactersList(page: Int)
}

extension RickAndMortyEndpoint {
    var scheme: String {
        "https"
    }

    var host: String {
        "rickandmortyapi.com"
    }

    var path: String {
        switch self {
        case .charactersList:
            "/api/character"
        }
    }

    var queryItems: [URLQueryItem] {
        var items = [URLQueryItem]()
        switch self {
        case .charactersList(let page):
            items.append(URLQueryItem(name: "page", value: "\(page)"))
        }
        return items
    }

    var url: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems
        let url = components.url
        print("DEBUG: url: \(url)")
        return url
    }
}
