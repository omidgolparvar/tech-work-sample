//

import Foundation
import Combine

class FavoriteMoviesViewModel: ViewModel {
	typealias State = FavoriteMoviesScene.State
	typealias Action = FavoriteMoviesScene.Action
	
	private var cancellables = Set<AnyCancellable>()
	
	@Published private var stateObject = State()
	
	var state: State { stateObject }
	var statePublisher: AnyPublisher<State, Never> { $stateObject.eraseToAnyPublisher() }
	
	init() {
		
	}
	
	func handle(action: Action) {
		
	}
	
}
