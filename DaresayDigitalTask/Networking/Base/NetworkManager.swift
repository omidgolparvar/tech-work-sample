//

import Foundation
import Combine

protocol NetworkManager {
	func responsePublisher<R: Decodable>(for request: URLRequest, ofType ResponseType: R.Type, decoder: JSONDecoder) -> AnyPublisher<R, Error>
}

extension NetworkManager {
	func responsePublisher<R: Decodable>(for request: URLRequest, ofType ResponseType: R.Type) -> AnyPublisher<R, Error> {
		responsePublisher(for: request, ofType: R.self, decoder: JSONDecoder())
	}
}

class HTTPNetworkManager: NetworkManager {
	private let session: URLSession
	var isLogginEnabled: Bool = false
	
	init(session: URLSession = .shared) {
		self.session = session
	}
	
	func responsePublisher<R: Decodable>(for request: URLRequest, ofType ResponseType: R.Type, decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<R, Error> {
		let publisher = session
			.dataTaskPublisher(for: request)
			.tryMap { data, response in
				guard let response = response as? HTTPURLResponse else { throw NSError() }
				guard 200..<400 ~= response.statusCode else { throw NSError() }
				return data
			}
			.decode(type: ResponseType.self, decoder: decoder)
			.mapError { error in
				return error
			}
			.receive(on: DispatchQueue.main)
			.eraseToAnyPublisher()
		
		return isLogginEnabled
		? publisher.print().eraseToAnyPublisher()
		: publisher
	}
}
