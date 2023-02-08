//

import Foundation

class JSONFileStorage<Object: Codable>: Storage {
	private let fileManager: FileManager = .default
	private let fileURL: URL
	
	private var isFileExist: Bool {
		fileManager.fileExists(atPath: fileURL.absoluteString)
	}
	
	init(fileURL: URL) {
		self.fileURL = fileURL
	}
	
	func store(object: Object) -> Result<Void, Error> {
		let encoder = JSONEncoder()
		do {
			let directory = fileURL.deletingLastPathComponent()
			try fileManager.createDirectory(at: directory, withIntermediateDirectories: true)
			try encoder.encode(object).write(to: fileURL)
			return .success(())
		} catch {
			return .failure(error)
		}
	}
	
	func currentObject() -> Result<Object?, Error> {
		guard isFileExist else { return .success(nil) }
		
		let decoder = JSONDecoder()
		do {
			let data = try Data(contentsOf: fileURL)
			let object = try decoder.decode(Object.self, from: data)
			return .success(object)
		} catch {
			return .failure(error)
		}
	}
	
	func removeObject() -> Result<Void, Error> {
		guard isFileExist else { return .success(()) }
		
		do {
			try fileManager.removeItem(at: fileURL)
			return .success(())
		} catch {
			return .failure(error)
		}
	}
}
