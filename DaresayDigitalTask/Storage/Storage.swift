//

import Foundation

protocol Storage<Object> {
	associatedtype Object
	
	func store(object: Object) -> Result<Void, Error>
	func currentObject() -> Result<Object?, Error>
	func removeObject() -> Result<Void, Error>
}

extension Storage {
	
	private var typeName: String {
		String(describing: Self.self)
	}
	
	var object: Object? {
		get {
			switch currentObject() {
			case .success(let value):
				return value
			case .failure(let error):
				print("\(typeName).currentObject() - Error:", error.localizedDescription)
				return nil
			}
		}
		
		set {
			if let newValue {
				if case .failure(let error) = store(object: newValue) {
					print("\(typeName).store(object:) - Error:", error.localizedDescription)
				}
			} else {
				if case .failure(let error) = removeObject() {
					print("\(typeName).removeObject() - Error:", error.localizedDescription)
				}
			}
		}
	}
	
}
