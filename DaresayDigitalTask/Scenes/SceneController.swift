//

import Foundation
import Combine
import UIKit

class SceneController<State: StateProtocol, Action>: UIViewController {
	typealias ViewModelType = ViewModel<State, Action>
	
	private(set) var cancellables = Set<AnyCancellable>()
	let viewModel: any ViewModelType
	
	init(viewModel: any ViewModelType) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
