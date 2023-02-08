//

import Foundation

struct MovieReview: Codable, Identifiable {
	typealias ID = String
	
	let id: String
	let authorName: String
	let authorUsername: String
	let authorAvatar: String
	let rating: Double
	let content: String
	let createDate: Date
	let url: URL
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let authorDetailsContainer = try container.nestedContainer(keyedBy: AuthorDetailsCodingKeys.self, forKey: .authorDetails)
		
		id = try container.decode(ID.self, forKey: .id)
		authorName = try authorDetailsContainer.decode(String.self, forKey: .name)
		authorUsername = try authorDetailsContainer.decode(String.self, forKey: .username)
		authorAvatar = try authorDetailsContainer.decode(String.self, forKey: .avatarPath)
		rating = try authorDetailsContainer.decode(Double.self, forKey: .rating)
		content = try container.decode(String.self, forKey: .content)
		createDate = try container.decode(Date.self, forKey: .createDate)
		url = try container.decode(URL.self, forKey: .url)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		var authorDetailsContainer = container.nestedContainer(keyedBy: AuthorDetailsCodingKeys.self, forKey: .authorDetails)
		
		try authorDetailsContainer.encode(authorName, forKey: .name)
		try authorDetailsContainer.encode(authorUsername, forKey: .username)
		try authorDetailsContainer.encode(authorAvatar, forKey: .avatarPath)
		try authorDetailsContainer.encode(rating, forKey: .rating)
		try container.encode(id, forKey: .id)
		try container.encode(content, forKey: .content)
		try container.encode(createDate, forKey: .createDate)
		try container.encode(url, forKey: .url)
	}
	
	enum CodingKeys: String, CodingKey {
		case id
		case authorDetails = "author_details"
		case url
		case content
		case createDate = "created_at"
	}
	
	enum AuthorDetailsCodingKeys: String, CodingKey {
		case name
		case username
		case avatarPath = "avatar_path"
		case rating
	}
	
}

extension MovieReview: Hashable {
	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
}

extension MovieReview: Equatable {
	static func == (lhs: MovieReview, rhs: MovieReview) -> Bool {
		lhs.id == rhs.id
	}
}
