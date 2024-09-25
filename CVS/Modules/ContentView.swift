import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel()

    private let columns = [GridItem(.flexible(minimum: 100)), GridItem(.flexible(minimum: 100))]

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.images) { image in
                            NavigationLink(destination: FlickerImageDetailView(image: image)) {
                                FlickerImageItemView(image: image)
                            }
                        }
                    }
                    .searchable(text: $viewModel.searchText)
                }
                .refreshable {
                    viewModel.makeNetworkRequest()
                }

                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(3)
                        .progressViewStyle(CircularProgressViewStyle())
                        .tint(Color.indigo)
                }
            }
            .navigationTitle("Flickr")
        }
    }
}

#Preview {
    ContentView()
}
