//

import Foundation

class MovieViewModel {
	let movie: Movie
	let isFavorite: Bool
	
	init(movie: Movie, isFavorite: Bool) {
		self.movie = movie
		self.isFavorite = isFavorite
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
