//

import Foundation
import Combine

extension Publisher {
	typealias PublisherResult = Result<Output, Failure>
	
	func sinkAsResult(_ result: @escaping (PublisherResult) -> Void) -> AnyCancellable {
		sink { completion in
			switch completion {
			case let .failure(error):
				result(.failure(error))
			case .finished:
				return
			}
		} receiveValue: { value in
			result(.success(value))
		}
	}
	
}
