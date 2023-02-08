//

import Foundation

extension Data {
	
	var prettyPrintedJSONString: String? {
		guard
			let object = try? JSONSerialization.jsonObject(with: self, options: []),
			let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted])
		else { return nil }
		return String.init(data: data, encoding: .utf8)
	}
	
}
