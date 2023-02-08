//

import Foundation

protocol ServiceEndpoint {
	var path: String { get }
	var queryItems: [URLQueryItem]? { get }
	var body: Data? { get }
	var method: HTTPMethod { get }
}
