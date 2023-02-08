//

import Foundation

struct Movie: Codable, Identifiable {
	typealias ID = Int
	
	let id: Int
	let backdropPath: String
	let originalLanguage: String
	let overview: String
	let posterPath: String
	let releaseDate: Date
	let title: String
	let voteAverage: Double
	let voteCount: Int
	
	enum CodingKeys: String, CodingKey {
		case id
		case backdropPath = "backdrop_path"
		case originalLanguage = "original_language"
		case overview
		case posterPath = "poster_path"
		case releaseDate = "release_date"
		case title
		case voteAverage = "vote_average"
		case voteCount = "vote_count"
	}
	
}

extension Movie: Hashable {
	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
}

extension Movie: Equatable {
	static func == (lhs: Movie, rhs: Movie) -> Bool {
		lhs.id == rhs.id
	}
}
