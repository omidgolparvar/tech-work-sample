//

import Foundation

typealias HTTPHeaders = [String: String]

struct HTTPHeader {
	let name: String
	let value: String
}

extension HTTPHeader {
	static func authorization(bearer: String) -> Self {
		.init(name: "Authorization", value: "Bearer \(bearer)")
	}
	
	static func contentType(_ string: String) -> Self {
		.init(name: "Content-Type", value: string)
	}
}

func + (header: HTTPHeader, headers: HTTPHeaders) -> HTTPHeaders {
	var result = headers
	result[header.name] = header.value
	return result
}

func + (headers: HTTPHeaders, header: HTTPHeader) -> HTTPHeaders {
	var result = headers
	result[header.name] = header.value
	return result
}

func + (left: HTTPHeader, right: HTTPHeader) -> HTTPHeaders {
	return [
		left.name: left.value,
		right.name: right.value
	]
}
