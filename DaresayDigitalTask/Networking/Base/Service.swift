//

import Foundation

protocol Service {
	associatedtype Endpoint: ServiceEndpoint
	
	var baseURL: URL { get }
	func urlRequest(for endpoint: Endpoint) -> URLRequest
}
