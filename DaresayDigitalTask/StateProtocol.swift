//

import Foundation

protocol StateProtocol {
	func updated(_ handler: (inout Self) -> Void) -> Self
}

extension StateProtocol {
	func updated(_ handler: (inout Self) -> Void) -> Self {
		var result = self
		handler(&result)
		return result
	}
	
	mutating func update(_ handler: (inout Self) -> Void) {
		var result = self
		handler(&result)
		self = result
	}
	
	mutating func update<Value>(_ keyPath: WritableKeyPath<Self,Value>, to value: Value) {
		self[keyPath: keyPath] = value
	}
}
