//

import Foundation
import Combine

class FavoriteMoviesViewModel: ViewModel {
	typealias State = FavoriteMoviesScene.State
	typealias Action = FavoriteMoviesScene.Action
	
	private let manager: FavoriteMoviesManagerProtocol
	
	@Published private var stateObject: State
	
	var state: State { stateObject }
	var statePublisher: AnyPublisher<State, Never> { $stateObject.eraseToAnyPublisher() }
	
	init(manager: FavoriteMoviesManagerProtocol) {
		self.manager = manager
		self.stateObject = .init(movies: manager.favorites.asSimpleMovieViewModels())
	}
	
	func handle(action: Action) {
		switch action {
		case .fetchMovies:
			performFetchMovies()
		case .remove(let movie):
			performRemoveMovie(movie)
		}
	}
	
	private func performFetchMovies() {
		stateObject.movies = manager.favorites.asSimpleMovieViewModels()
	}
	
	private func performRemoveMovie(_ movie: Movie) {
		_ = manager.removeFromFavorites(movie: movie)
		stateObject.movies = manager.favorites.asSimpleMovieViewModels()
	}
	
}

private extension Array where Element == Movie {
	
	func asSimpleMovieViewModels() -> [SimpleMovieViewModel] {
		return self.map { SimpleMovieViewModel.init(movie: $0, isFavorite: true) }
	}
	
}
