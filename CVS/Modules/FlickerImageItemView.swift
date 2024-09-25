import SwiftUI

struct FlickerImageItemView: View {
    @ObservedObject var viewModel: FlickerImageItemViewModel

    init(image: FlickerImage) {
        viewModel = FlickerImageItemViewModel(image: image)
    }

    var body: some View {
        CachedAsyncImage(
            url: viewModel.getMediaURL(),
            transaction: Transaction(animation: .default)
        ) { phase in
            switch phase {
            case .empty:
                ZStack {
                    Image(systemName: "photo.artframe")
                        .resizable()
                        .scaledToFit()
                        .tint(Color(UIColor.systemGray5))

                    ProgressView()
                        .controlSize(.large)
                        .tint(Color.primary)
                }
            case .success(let image):
                image
                    .resizable()
                    .transition(.scale(scale: 0.1, anchor: .center))
            default:
                Image(systemName: "photo.artframe")
                    .resizable()
                    .scaledToFit()
                    .tint(Color(UIColor.systemGray5))

            }
        }
    }
}

#Preview {
    FlickerImageItemView(image: FlickerImage.stubData())
}
