import Foundation

struct ListModel: Codable {
	let hits: [Hits]?
	let totalPages: Int?

	enum CodingKeys: String, CodingKey {
		case hits = "hits"
        case totalPages = "nbPages"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		hits = try values.decodeIfPresent([Hits].self, forKey: .hits)
        totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages)
	}
}

struct Hits: Codable {
    let created_at: String?
    let title: String?
    var isSelected: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case created_at = "created_at"
        case title = "title"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }
}
