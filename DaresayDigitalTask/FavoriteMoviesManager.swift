//

import Foundation

protocol FavoriteMoviesManagerProtocol {
	var favorites: [Movie] { get }
	func isFavorite(movie: Movie) -> Bool
	func addToFavorites(movie: Movie) -> Bool
	func removeFromFavorites(movie: Movie) -> Bool
}

class FavoriteMoviesManager: FavoriteMoviesManagerProtocol {
	
	private let storage: any Storage<[Movie]>
	
	var favorites: [Movie] {
		favoriteMovies()
	}
	
	init(storage: any Storage<[Movie]>) {
		self.storage = storage
	}
	
	func isFavorite(movie: Movie) -> Bool {
		favorites.contains(movie)
	}
	
	@discardableResult
	func addToFavorites(movie: Movie) -> Bool {
		guard case .success(let movies) = storage.currentObject() else { return false }
		
		let newValue = movies.flatMap { $0 + [movie] } ?? [movie]
		
		guard case .success = storage.store(object: newValue) else { return false }
		return true
	}
	
	@discardableResult
	func removeFromFavorites(movie: Movie) -> Bool {
		guard
			case .success(var movies?) = storage.currentObject(),
			let index = movies.firstIndex(of: movie)
		else { return false }
		
		movies.remove(at: index)
		
		guard case .success = storage.store(object: movies) else { return false }
		return true
	}
	
	private func favoriteMovies() -> [Movie] {
		guard case .success(let movies?) = storage.currentObject() else { return [] }
		return movies
	}
	
}
