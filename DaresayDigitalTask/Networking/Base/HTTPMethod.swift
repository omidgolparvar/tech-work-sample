//

import Foundation

struct HTTPMethod: RawRepresentable {
	typealias RawValue = String
	
	let rawValue: RawValue
	
	init(rawValue: String) {
		self.rawValue = rawValue
	}
	
	static let get = Self.init(rawValue: "GET")
	static let post = Self.init(rawValue: "POST")
	static let head = Self.init(rawValue: "HEAD")
}
