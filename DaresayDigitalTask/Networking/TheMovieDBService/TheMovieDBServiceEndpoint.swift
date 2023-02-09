//

import Foundation

#warning("implement model for pagination")
typealias TheMovieDBServicePage = UInt8

enum TheMovieDBServiceEndpoint: ServiceEndpoint {
	case topRated(page: TheMovieDBServicePage)
	case mostPopular(page: TheMovieDBServicePage)
	case movieDetail(movieID: Movie.ID)
	case movieReviews(movieID: Movie.ID, page: TheMovieDBServicePage)
	
	var path: String {
		switch self {
		case .topRated(let page):
			return "./top_rated".appendingPage(page)
		case .mostPopular(let page):
			return "./popular".appendingPage(page)
		case .movieDetail(let movieID):
			return "./\(movieID)"
		case .movieReviews(let movieID, let page):
			return "./\(movieID)/reviews".appendingPage(page)
		}
	}
	
	var queryItems: [URLQueryItem]? { nil }
	var body: Data? { nil }
	var method: HTTPMethod { .get }
}

private extension String {
	func appendingPage(_ page: TheMovieDBServicePage) -> String {
		self + (page > .zero ? "/\(page)" : "")
	}
}
