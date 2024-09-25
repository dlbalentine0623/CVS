import Foundation

class ContentViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var images: [FlickerImage] = []
    @Published var searchText = "" {
        didSet {
            if searchText.isEmpty {
                makeNetworkRequest()
            } else {
                searchForImageWtihTag()
            }
        }
    }

    init() {
        makeNetworkRequest()
    }

    func makeNetworkRequest() {
        isLoading = true
        Task {
            do {
                let results = try await NetworkRequest.fetchData()
                await MainActor.run {
                    images = results
                    isLoading = false
                }
            }
        }
    }

    func searchForImageWtihTag() {
        Task {
            do {
                let results = try await NetworkRequest.fetchQuerySearch(query: searchText)
                await MainActor.run {
                    images = results
                    isLoading = false
                }
            }
        }
    }
}
