//

import Foundation

extension TheMovieDBService {
	
	static func `default`() -> Self {
		let baseURL = URL(string: "https://api.themoviedb.org/3/movie/")!
		let authorizationHeader = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4YTdhOWFhMjYyODZhOGMyZDE0OTBhNTIyNzljNzQwOSIsInN1YiI6IjYzY2ZiOGZjOGRiYzMzMDA5ZDdhNjBlZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.g3Fkog48ELAPsq80yL65wFfiNw-ZWcsGY74_NdzWz0o"
		return .init(baseURL: baseURL, authorizationHeader: authorizationHeader)
	}
	
}
