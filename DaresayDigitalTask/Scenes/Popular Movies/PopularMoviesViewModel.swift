//

import Foundation
import Combine

class PopularMoviesViewModel: ViewModel {
	typealias State = PopularMoviesScene.State
	typealias Action = PopularMoviesScene.Action
	
	private var cancellables = Set<AnyCancellable>()
	private let dataSource: TheMovieDBPopularMoviesDataSource
	
	@Published private var stateObject = State()
	
	var state: State { stateObject }
	var statePublisher: AnyPublisher<State, Never> { $stateObject.eraseToAnyPublisher() }
	
	init(dataSource: TheMovieDBPopularMoviesDataSource) {
		self.dataSource = dataSource
	}
	
	func handle(action: Action) {
		switch action {
		case .fetchMovies:
			performFetchMovies()
		}
	}
	
	private func performFetchMovies() {
		guard !stateObject.fetchMoviesStatus.isLoading else { return }
		
		stateObject.fetchMoviesStatus = .loading
		
		dataSource
			.getPopularMovies(atPage: 0)
			.sinkAsResult { [weak self] result in
				guard let self else { return }
				
				switch result {
				case .success(let value):
					self.stateObject.fetchMoviesStatus = .loaded(value)
				case .failure(let error):
					self.stateObject.fetchMoviesStatus = .failed(error)
				}
			}
			.store(in: &cancellables)
	}
	
}
