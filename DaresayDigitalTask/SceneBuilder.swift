//

import Foundation
import Combine
import UIKit

protocol SceneBuilder<State, Action> {
	associatedtype BuildConfiguration
	associatedtype State: StateProtocol
	associatedtype Action
	associatedtype Controller: SceneController<State, Action>
	
	static func build(with configuration: BuildConfiguration) -> Controller
}

extension SceneBuilder where BuildConfiguration == Void {
	static func build() -> Controller {
		Self.build(with: ())
	}
}
