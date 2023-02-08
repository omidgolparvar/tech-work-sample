//

import Foundation

class MovieViewModel {
	let movie: Movie
	
	init(movie: Movie) {
		self.movie = movie
	}
}

extension MovieViewModel: Equatable {
	static func == (lhs: MovieViewModel, rhs: MovieViewModel) -> Bool {
		lhs.movie == rhs.movie
	}
}

extension MovieViewModel: Hashable {
	func hash(into hasher: inout Hasher) {
		hasher.combine(movie.hashValue)
	}
}
