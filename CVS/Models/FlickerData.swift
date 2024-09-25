import Foundation

struct FlickerData: Decodable {
    let description: String
    let generator: String
    let items: [FlickerImage]
    let link: String
    let title: String
    let modified: String

    init(
        description: String,
        generator: String,
        items: [FlickerImage],
        link: String,
        title: String,
        modified: String
    ) {
        self.description = description
        self.generator = generator
        self.items = items
        self.link = link
        self.title = title
        self.modified = modified
    }

    enum CodingKeys: CodingKey {
        case description
        case generator
        case items
        case link
        case title
        case modified
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.description = try container.decode(String.self, forKey: .description)
        self.generator = try container.decode(String.self, forKey: .generator)
        self.items = try container.decode([FlickerImage].self, forKey: .items)
        self.link = try container.decode(String.self, forKey: .link)
        self.title = try container.decode(String.self, forKey: .title)
        self.modified = try container.decode(String.self, forKey: .modified)
    }
}
