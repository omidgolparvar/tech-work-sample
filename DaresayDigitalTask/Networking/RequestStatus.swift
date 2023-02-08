//

import Foundation

enum RequestStatus<Model> {
	case idle
	case loading
	case failed(Error)
	case loaded(Model)
}

extension RequestStatus {
	
	var isLoading: Bool {
		guard case .loading = self else { return false }
		return true
	}
	
	var value: Model? {
		guard case .loaded(let model) = self else { return nil }
		return model
	}
	
	var error: Error? {
		guard case .failed(let error) = self else { return nil }
		return error
	}
	
}
