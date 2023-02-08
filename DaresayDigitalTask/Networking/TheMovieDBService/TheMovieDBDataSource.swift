//

import Foundation
import Combine

struct List<T: Codable>: Codable {
	let page: TheMovieDBServicePage
	let result: [T]
}

protocol TheMovieDBDataSource {
	func getPopularMovies(atPage page: TheMovieDBServicePage) -> AnyPublisher<List<Movie>, Error>
	func getTopRatedMovies(atPage page: TheMovieDBServicePage) -> AnyPublisher<List<Movie>, Error>
	func getMovieDetail(for movie: Movie) -> AnyPublisher<Movie, Error>
	func getMovieReviews(for movie: Movie, atPage page: TheMovieDBServicePage) -> AnyPublisher<List<MovieReview>, Error>
}
