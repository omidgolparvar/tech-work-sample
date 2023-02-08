//

import Foundation

class InMemoryStorage<Object>: Storage {
	private var object: Object?
	
	init(initialObject: Object? = nil) {
		self.object = initialObject
	}
	
	func store(object: Object) -> Result<Void, Error> {
		self.object = object
		return .success(())
	}
	
	func currentObject() -> Result<Object?, Error> {
		return .success(object)
	}
	
	func removeObject() -> Result<Void, Error> {
		self.object = nil
		return .success(())
	}
	
}
