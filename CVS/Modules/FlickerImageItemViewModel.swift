import Foundation
import UIKit

class FlickerImageItemViewModel: ObservableObject {
    @Published var isLoading = false
    var displayImage: UIImage?

    private var flickerImage: FlickerImage

    init(image: FlickerImage) {
        self.flickerImage = image
    }

    func getMediaURL() -> URL? {
        let media = flickerImage.getMedia()
        guard
            let urlString = media["m"],
            let url = URL(string: urlString) else {
            return nil
        }

        return url
    }
}
