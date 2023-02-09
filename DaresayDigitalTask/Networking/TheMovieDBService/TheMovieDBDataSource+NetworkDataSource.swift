//

import Foundation
import Combine

class TheMovieDBNetworkDataSource: TheMovieDBDataSource {
	private let service: TheMovieDBService
	private let manager: NetworkManager
	
	private lazy var topRatedMoviesJSONDecoder: JSONDecoder = {
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "en-us")
		dateFormatter.calendar = Calendar(identifier: .gregorian)
		dateFormatter.dateFormat = "yyyy-MM-dd"
		
		let jsonDecoder = JSONDecoder()
		jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
		
		return jsonDecoder
	}()
	
	private lazy var movieReviewsJSONDecoder: JSONDecoder = {
		let jsonDecoder = JSONDecoder()
		jsonDecoder.dateDecodingStrategy = .iso8601
		
		return jsonDecoder
	}()
	
	init(service: TheMovieDBService, manager: NetworkManager) {
		self.service = service
		self.manager = manager
	}
	
	func getPopularMovies(atPage page: TheMovieDBServicePage) -> AnyPublisher<PaginationResponse<Movie>, Error> {
		let request = service.urlRequest(for: .mostPopular(page: page))
		return manager.responsePublisher(for: request, ofType: PaginationResponse<Movie>.self)
	}
	
	func getTopRatedMovies(atPage page: TheMovieDBServicePage) -> AnyPublisher<PaginationResponse<Movie>, Error> {
		let request = service.urlRequest(for: .topRated(page: page))
		return manager.responsePublisher(for: request, ofType: PaginationResponse<Movie>.self, decoder: topRatedMoviesJSONDecoder)
	}
	
	func getMovieDetail(for movie: Movie) -> AnyPublisher<Movie, Error> {
		let request = service.urlRequest(for: .movieDetail(movieID: movie.id))
		return manager.responsePublisher(for: request, ofType: Movie.self)
	}
	
	func getMovieReviews(for movie: Movie, atPage page: TheMovieDBServicePage) -> AnyPublisher<PaginationResponse<MovieReview>, Error> {
		let request = service.urlRequest(for: .movieReviews(movieID: movie.id, page: page))
		return manager.responsePublisher(for: request, ofType: PaginationResponse<MovieReview>.self, decoder: movieReviewsJSONDecoder)
	}
	
}

extension TheMovieDBNetworkDataSource {
	
	static let `default`: TheMovieDBNetworkDataSource = {
		let service = TheMovieDBService.default()
		let manager = HTTPNetworkManager()
		return TheMovieDBNetworkDataSource.init(service: service, manager: manager)
	}()
	
}
