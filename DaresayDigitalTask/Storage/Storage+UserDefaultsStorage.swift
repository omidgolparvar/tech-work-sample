//

import Foundation

class UserDefaultsStorage<Object: Codable>: Storage {
	private let userDefaults: UserDefaults
	private let key: String
	
	init(userDefaults: UserDefaults, key: String) {
		self.userDefaults = userDefaults
		self.key = key
	}
	
	func store(object: Object) -> Result<Void, Error> {
		let encoder = JSONEncoder()
		do {
			let data = try encoder.encode(object)
			let string = String(data: data, encoding: .utf8)
			userDefaults.set(string, forKey: key)
			return .success(())
		} catch {
			return .failure(error)
		}
	}
	
	func currentObject() -> Result<Object?, Error> {
		guard
			let string = userDefaults.string(forKey: key),
			let data = string.data(using: .utf8)
		else { return .success(nil) }
		
		let decoder = JSONDecoder()
		do {
			let object = try decoder.decode(Object.self, from: data)
			return .success(object)
		} catch {
			return .failure(error)
		}
	}
	
	func removeObject() -> Result<Void, Error> {
		userDefaults.removeObject(forKey: key)
		return .success(())
	}
	
}
