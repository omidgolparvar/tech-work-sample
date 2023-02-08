//

import Foundation

struct HTTPResponseError: NetworkError {
	let code: Int
	let message: String
	
	var statusCode: Int {
		code
	}
}
