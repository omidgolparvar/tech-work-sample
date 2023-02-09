//

import Foundation

struct PaginationResponse<Element: Codable>: Codable {
	private(set) var page: UInt
	private(set) var result: [Element]
	private(set) var totalPages: UInt
	private(set) var totalResults: UInt
	
	init(page: UInt = 0, result: [Element], totalPages: UInt, totalResults: UInt) {
		self.page = page
		self.result = result
		self.totalPages = totalPages
		self.totalResults = totalResults
	}
	
	mutating func update(with newResponse: Self) {
		self.page = newResponse.page
		self.result.append(contentsOf: newResponse.result)
	}
	
	func updated(with newResponse: Self) -> Self {
		var copy = self
		copy.update(with: newResponse)
		return copy
	}
	
	enum CodingKeys: String, CodingKey {
		case page
		case result
		case totalPages = "total_pages"
		case totalResults = "total_results"
	}
}

extension PaginationResponse: Equatable where Element: Equatable {
	
}

extension PaginationResponse: Hashable where Element: Hashable {
	
}

