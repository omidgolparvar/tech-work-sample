//

import Foundation
import UIKit

final class TopRatedMoviesViewController: UITabBarController, SceneController {
	
	typealias State = TopRatedMoviesScene.State
	typealias Action = TopRatedMoviesScene.Action
	
	let viewModel: any ViewModel<State, Action>
	
	init(viewModel: any ViewModel<State, Action>) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	func setupViews() {
		print(#function)
	}
	
	func setupBindings() {
		print(#function)
	}
	
}
