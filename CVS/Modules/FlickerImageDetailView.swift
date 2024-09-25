import SwiftUI

struct FlickerImageDetailView: View {
    @ObservedObject var viewModel: FlickerImageDetailViewModel


    init(image: FlickerImage) {
        viewModel = FlickerImageDetailViewModel(image: image)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                ZStack(alignment: .topTrailing) {
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
                                .scaledToFit()
                                .transition(.scale(scale: 0.1, anchor: .center))
                        default:
                            Image(systemName: "photo.artframe")
                                .resizable()
                                .scaledToFit()
                                .tint(Color(UIColor.systemGray5))

                        }
                    }
                    .frame(maxWidth: .infinity)

                    if !viewModel.getLink().isEmpty {
                        Link(destination: URL(string: viewModel.getLink())!) {
                            Image(systemName: "globe")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .tint(.primary)
                                .padding(4)
                                .background(Color(UIColor.systemGray5))
                                .clipShape(Circle())
                        }
                        .padding(8)
                    }

                }
                .frame(height: 250)

                Group {
                    Text(viewModel.getTitle())
                        .font(.title)
                        .foregroundStyle(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    HStack {
                        Text(viewModel.getAuthorName())
                            .font(.callout)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Spacer()

                        Text(viewModel.getPublished())
                            .font(.callout)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .frame(maxWidth: .infinity)

                    Text("Description")
                        .font(.title)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 16)

                    Divider()
                        .frame(height: 2)
                        .overlay(.secondary)

                    AttributedText(text: viewModel.getDescription())
                }
                .padding(.horizontal, 8)
            }
        }
        .navigationTitle(" ")
    }
}

#Preview {
    FlickerImageDetailView(image: FlickerImage.stubData())
}
