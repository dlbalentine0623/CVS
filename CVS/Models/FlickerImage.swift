import Foundation

struct FlickerImage: Decodable, Identifiable {
    internal let id = UUID()

    private let author: (String, String)
    private let authorId: String
    private let dateTaken: String
    private let description: String
    private let media: [String : String]
    private let link: String
    private let published: String
    private let tags: String
    private let title: String

    private enum CodingKeys: String, CodingKey {
        case author
        case authorId = "author_id"
        case dateTaken = "date_taken"
        case description
        case link
        case media
        case published
        case tags
        case title
    }

    init(
        author: (String,String),
        authorId: String,
        dateTaken: String,
        description: String,
        media: [String : String],
        link: String,
        published: String,
        tags: String,
        title: String
    ) {
        self.author = author
        self.authorId = authorId
        self.dateTaken = dateTaken
        self.description = description
        self.media = media
        self.link = link
        self.published = published
        self.tags = tags
        self.title = title
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let authorString = try container.decodeIfPresent(String.self, forKey: .author) ?? ""
        authorId = try container.decodeIfPresent(String.self, forKey: .authorId) ?? ""
        dateTaken = try container.decodeIfPresent(String.self, forKey: .dateTaken) ?? ""
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        media = try container.decodeIfPresent([String:String].self, forKey: .media) ?? [:]
        link = try container.decodeIfPresent(String.self, forKey: .link) ?? ""
        published = try container.decodeIfPresent(String.self, forKey: .published) ?? ""
        tags = try container.decodeIfPresent(String.self, forKey: .tags) ?? ""
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""

        if let indexNameStart = authorString.firstIndex(of: "("),
           let indexNameEnd = authorString.firstIndex(of: ")") {

            let endOfEmail = authorString.index(indexNameStart, offsetBy: -2)
            
            let startOfName = authorString.index(indexNameStart, offsetBy: 2)
            let endOfName = authorString.index(indexNameEnd, offsetBy: -2)
            
            let authorEmail = String(authorString[authorString.startIndex...endOfEmail])
            let authorName = String(authorString[startOfName...endOfName])

            author = (authorEmail, authorName)
        } else {
            author = ("", "")
        }
    }

    static func stubData(
        author: (String, String) = ("nobody@flickr.com", "CoasterMadMatt"),
        authorId: String = "15523409@N05",
        dateTaken: String = "2024-07-07T15:56:16-08:00",
        description: String = "<p><a href=\"https://www.flickr.com/people/coastermadmatt/\">CoasterMadMatt</a> posted a photo:</p> <p><a href=\"https://www.flickr.com/photos/coastermadmatt/54013510363/\" title=\"Crested Porcupine\"><img src=\"https://live.staticflickr.com/65535/54013510363_96e701ec86_m.jpg\" width=\"240\" height=\"160\" alt=\"Crested Porcupine\" /></a></p> ",
        media: [String : String] = ["m": "https://live.staticflickr.com/65535/54013510363_96e701ec86_m.jpg"],
        link: String = "https://www.flickr.com/photos/coastermadmatt/54013510363/",
        published: String = "2024-09-22T16:17:56Z",
        tags: String = "chessingtonworldofadventures2024 chessington chessingtonworldofadventures 2024season",
        title: String = "Crested Porcupine"
    ) -> FlickerImage {
        return FlickerImage(
            author: author,
            authorId: authorId,
            dateTaken: dateTaken,
            description: description,
            media: media,
            link: link,
            published: published,
            tags: tags,
            title: title
        )
    }

    func getAuthor() -> (String, String) {
        return author
    }

    func getAuthorId() -> String {
        return authorId
    }
    
    func getDateTaken() -> String {
        return convertDate(dateString: dateTaken)
    }
    
    func getDescription() -> String {
        return description
    }
    
    func getMedia() -> [String : String] {
        return media
    }
    
    func getLink() -> String {
        return link
    }

    func getPublished() -> String {
        return convertDate(dateString: published)
    }
    
    func getTags() -> String {
        return tags
    }
    
    func getTitle() -> String {
        return title
    }

    private func convertDate(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: dateString) ?? Date()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none

        return dateFormatter.string(from: date)
    }
}
