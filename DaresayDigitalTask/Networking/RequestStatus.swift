//

import Foundation

enum RequestStatus<Model> {
	case idle
	case loading
	case failed(Error)
	case loaded(Model)
}

extension RequestStatus: Equatable where Model: Equatable {
	
	static func == (lhs: RequestStatus<Model>, rhs: RequestStatus<Model>) -> Bool {
		switch (lhs, rhs) {
		case (.idle, .idle):
			return true
		case (.loading, .loading):
			return true
		case (.loaded(let model0), .loaded(let model1)):
			return model0 == model1
		case (.failed, .failed):
			return false
		default:
			return false
		}
	}
	
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

extension RequestStatus: CustomDebugStringConvertible {
	
	var debugDescription: String {
		let type = String(describing: type(of: self))
		switch self {
		case .idle:
			return "\(type).idle"
		case .loading:
			return "\(type).loading"
		case .failed(let error):
			return "\(type).failed(\(error.localizedDescription))"
		case .loaded(let model):
			return "\(type).loaded(\(String(describing: model)))"
		}
	}
	
}
