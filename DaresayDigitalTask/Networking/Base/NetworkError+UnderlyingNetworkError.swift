//

import Foundation

struct UnderlyingNetworkError: NetworkError {
	let code: Int
	let message: String
}
