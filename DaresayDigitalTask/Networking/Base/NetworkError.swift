//

import Foundation

protocol NetworkError: Error {
	var code: Int { get }
	var message: String { get }
}


