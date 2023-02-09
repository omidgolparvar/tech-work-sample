//

import Foundation

protocol MovieViewModel {
	var movieTitle: String { get }
	var movieOverview: String { get }
	var releaseDateString: String { get }
	var rateString: String { get }
	var moviePosterURL: URL? { get }
	var isFavorite: Bool { get }
}

class SimpleMovieViewModel: MovieViewModel {
	private static let defaultDateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.calendar = Calendar.current
		formatter.locale = .current
		formatter.dateFormat = "yyyy"
		return formatter
	}()
	
	private static let defaultNumberFormatter: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.locale = .current
		formatter.maximumFractionDigits = 1
		return formatter
	}()
	
	private let dateFormatter: DateFormatter
	private let numberFormatter: NumberFormatter
	private let movie: Movie
	
	var movieTitle: String {
		movie.title
	}
	var movieOverview: String {
		movie.overview
	}
	var releaseDateString: String {
		dateFormatter.string(from: movie.releaseDate)
	}
	var rateString: String {
		numberFormatter.string(from: movie.voteAverage as NSNumber) ?? ""
	}
	var moviePosterURL: URL? {
		guard !movie.posterPath.isEmpty else { return nil }
		let type = ImageType.poster(ImageType.PosterSizes.w342)
		return TheMovieDBService
			.imageBaseURL
			.appending(component: type.size.rawValue)
			.appending(path: movie.posterPath)
	}
	let isFavorite: Bool
	
	init(
		movie: Movie,
		isFavorite: Bool,
		dateFormatter: DateFormatter = SimpleMovieViewModel.defaultDateFormatter,
		numberFormatter: NumberFormatter = SimpleMovieViewModel.defaultNumberFormatter
	) {
		self.movie = movie
		self.isFavorite = isFavorite
		self.dateFormatter = dateFormatter
		self.numberFormatter = numberFormatter
	}
	
}

extension SimpleMovieViewModel: Equatable {
	static func == (lhs: SimpleMovieViewModel, rhs: SimpleMovieViewModel) -> Bool {
		lhs.movie == rhs.movie
	}
}

extension SimpleMovieViewModel: Hashable {
	func hash(into hasher: inout Hasher) {
		hasher.combine(movie.hashValue)
	}
}
