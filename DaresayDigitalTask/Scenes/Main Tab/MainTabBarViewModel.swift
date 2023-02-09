//

import Foundation
import Combine

class MainTabBarViewModel: ViewModel {
	typealias State = MainTabBarScene.State
	typealias Action = MainTabBarScene.Action
	
	@Published private var stateObject = State()
	
	var state: State { stateObject }
	var statePublisher: AnyPublisher<State, Never> { $stateObject.eraseToAnyPublisher() }
	
	init() {
		
	}
	
	func handle(action: Action) {
		
	}
	
}
