//

import Foundation

struct PaginationResponse<Element: Codable>: Codable {
	private(set) var page: Int
	private(set) var results: [Element]
	private(set) var totalPages: Int
	private(set) var totalResults: Int
	
	init(page: Int = 0, result: [Element], totalPages: Int, totalResults: Int) {
		self.page = page
		self.results = result
		self.totalPages = totalPages
		self.totalResults = totalResults
	}
	
	mutating func update(with newResponse: Self) {
		self.page = newResponse.page
		self.results.append(contentsOf: newResponse.results)
	}
	
	func updated(with newResponse: Self) -> Self {
		var copy = self
		copy.update(with: newResponse)
		return copy
	}
	
	enum CodingKeys: String, CodingKey {
		case page
		case results
		case totalPages = "total_pages"
		case totalResults = "total_results"
	}
}

extension PaginationResponse: Equatable where Element: Equatable {
	
}

extension PaginationResponse: Hashable where Element: Hashable {
	
}

