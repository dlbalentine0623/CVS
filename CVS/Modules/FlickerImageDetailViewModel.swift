import Foundation
import UIKit

class FlickerImageDetailViewModel: ObservableObject {

    var displayImage: UIImage?

    private var flickerImage: FlickerImage

    init(image: FlickerImage) {
        self.flickerImage = image
    }

    func getAuthorName() -> String {
        return flickerImage.getAuthor().1
    }

    func getAuthorEmail() -> String {
        return flickerImage.getAuthor().0
    }

    func getDateTaken() -> String {
        return flickerImage.getDateTaken()
    }

    func getDescription() -> String {
        return flickerImage.getDescription()
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

    func getLink() -> String {
        let linkString = flickerImage.getLink()
        guard !linkString.isEmpty else {
            return "https://www.flickr.com/photos"
        }

        return linkString
    }

    func getPublished() -> String {
        return flickerImage.getPublished()
    }

    func getTitle() -> String {
        return flickerImage.getTitle()
    }

    func goToLink() {
        guard let url = URL(string: getLink()) else { return }
        UIApplication.shared.open(url)
    }
}
