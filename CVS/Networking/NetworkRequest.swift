import Foundation

enum NetworkError: Error {
    case invalidRequest(_ description: String)
}

class NetworkRequest {
    private static let API_URL = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1"

    class func loadData(url: URL?) async throws -> Data {
        guard let url else {
            throw NetworkError.invalidRequest("Invalid URL")
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 400
        guard statusCode >= 200 && statusCode < 400 else {
            throw NetworkError.invalidRequest("Network Error: status code \(statusCode)")
        }

        return data
    }

    class func fetchData() async throws -> [FlickerImage] {
        let data = try await loadData(url: URL(string: API_URL))

        do {
            let results = try JSONDecoder().decode(FlickerData.self, from: data)
            return results.items
        } catch {
            return []
        }
    }

    class func fetchQuerySearch(query searchText: String) async throws -> [FlickerImage] {
        guard !searchText.isEmpty else { return [] }

        let parameters = searchText.components(separatedBy: .whitespaces).joined(separator: ",")
        var urlComponent = URLComponents(string: API_URL)
        let queryItem = [
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "nojsoncallback", value: "1"),
            URLQueryItem(name: "tags", value: parameters)
        ]
        urlComponent?.queryItems = queryItem
        let data = try await loadData(url: urlComponent?.url)

        do {
            let results = try JSONDecoder().decode(FlickerData.self, from: data)
            return results.items
        } catch {
            return []
        }
    }
}
