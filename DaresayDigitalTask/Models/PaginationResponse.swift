//

import Foundation

struct PaginationResponse<Element: Codable>: Codable {
	let page: UInt
	let result: [Element]
	let totalPages: UInt
	let totalResults: UInt
	
	enum CodingKeys: String, CodingKey {
		case page
		case result
		case totalPages = "total_pages"
		case totalResults = "total_results"
	}
}
