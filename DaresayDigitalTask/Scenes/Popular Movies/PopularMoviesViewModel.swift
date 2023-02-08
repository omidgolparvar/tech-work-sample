//

import Foundation
import Combine

class PopularMoviesViewModel: ViewModel {
	typealias State = PopularMoviesScene.State
	typealias Action = PopularMoviesScene.Action
	
	private var cancellables = Set<AnyCancellable>()
	private let tmdbDataSource: TheMovieDBDataSource
	
	@Published private var stateObject = State()
	
	var state: State { stateObject }
	var statePublisher: AnyPublisher<State, Never> { $stateObject.eraseToAnyPublisher() }
	
	init(tmdbDataSource: TheMovieDBDataSource) {
		self.tmdbDataSource = tmdbDataSource
	}
	
	func handle(action: Action) {
		switch action {
		case .fetchMovies:
			performFetchMovies()
		}
	}
	
	private func performFetchMovies() {
		
	}
	
}
