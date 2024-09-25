import XCTest
@testable import CVS

final class CVSTests: XCTestCase {

    private var flickerImage: FlickerImage!

    override func setUpWithError() throws {
        flickerImage = FlickerImage.stubData()
    }

    override func tearDownWithError() throws {
        flickerImage = nil
    }

    func testFlickerImageItemViewModel() {
        let viewModel = FlickerImageItemViewModel(image: flickerImage)
        XCTAssertEqual(viewModel.getMediaURL()?.absoluteString, flickerImage.getMedia()["m"])
    }

    func testFlickerImageDetailViewModel() {
        let viewModel = FlickerImageDetailViewModel(image: flickerImage)
        let authorTupleTest = "\((viewModel.getAuthorEmail(), viewModel.getAuthorName()))"
        XCTAssertEqual(authorTupleTest, "\(flickerImage.getAuthor())")
        XCTAssertEqual(viewModel.getDateTaken(), flickerImage.getDateTaken())
        XCTAssertEqual(viewModel.getDescription(), flickerImage.getDescription())
        XCTAssertEqual(viewModel.getLink(), flickerImage.getLink())
        XCTAssertEqual(viewModel.getMediaURL()?.absoluteString, flickerImage.getMedia()["m"])
        XCTAssertEqual(viewModel.getPublished(), flickerImage.getPublished())
        XCTAssertEqual(viewModel.getTitle(), flickerImage.getTitle())
    }

}
