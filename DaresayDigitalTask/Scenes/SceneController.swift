//

import Foundation
import Combine
import UIKit

protocol SceneController<State, Action>: UIViewController {
	associatedtype State: StateProtocol
	associatedtype Action
	
	var viewModel: any ViewModel<State, Action> { get }
	
	init(viewModel: any ViewModel<State, Action>)
	
	func setupViews()
	func setupBindings()
}
