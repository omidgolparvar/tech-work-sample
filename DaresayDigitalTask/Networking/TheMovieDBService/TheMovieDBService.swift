//

import Foundation

struct TheMovieDBService: Service {
	
	static let imageBaseURL = URL(string: "https://image.tmdb.org/t/p").unsafelyUnwrapped
	
	typealias Endpoint = TheMovieDBServiceEndpoint
	
	private let cachePolicy: URLRequest.CachePolicy = .returnCacheDataElseLoad
	private let timeoutInterval: TimeInterval = 10
	private let authorizationHeader: String
	
	let baseURL: URL
	
	init(baseURL: URL, authorizationHeader: String) {
		self.baseURL = baseURL
		self.authorizationHeader = authorizationHeader
	}
	
	func urlRequest(for endpoint: TheMovieDBServiceEndpoint) -> URLRequest {
		var url = URL(string: endpoint.path, relativeTo: baseURL).unsafelyUnwrapped
		
		if let queryItems = endpoint.queryItems, !queryItems.isEmpty {
			url.append(queryItems: queryItems)
		}
		
		var request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
		request.httpMethod = endpoint.method.rawValue
		request.httpBody = endpoint.body
		request.allHTTPHeaderFields = [:]
		+ .authorization(bearer: authorizationHeader)
		+ .contentType("application/json;charset=utf-8")
		
		return request
	}
	
}
