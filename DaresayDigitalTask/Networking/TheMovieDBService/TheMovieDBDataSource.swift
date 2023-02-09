//

import Foundation
import Combine

struct List<T: Codable>: Codable {
	let page: TheMovieDBServicePage
	let result: [T]
}

protocol TheMovieDBPopularMoviesDataSource {
	func getPopularMovies(atPage page: TheMovieDBServicePage) -> AnyPublisher<PaginationResponse<Movie>, Error>
}
protocol TheMovieDBTopRatedMoviesDataSource {
	func getTopRatedMovies(atPage page: TheMovieDBServicePage) -> AnyPublisher<PaginationResponse<Movie>, Error>
}
protocol TheMovieDBMovieDetailsDataSource {
	func getMovieDetail(for movie: Movie) -> AnyPublisher<Movie, Error>
	func getMovieReviews(for movie: Movie, atPage page: TheMovieDBServicePage) -> AnyPublisher<PaginationResponse<MovieReview>, Error>
}

typealias TheMovieDBDataSource = TheMovieDBPopularMoviesDataSource & TheMovieDBTopRatedMoviesDataSource & TheMovieDBMovieDetailsDataSource
