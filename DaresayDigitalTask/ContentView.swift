//

import Foundation
import UIKit

protocol ContentView: UIView, UIContentView {
	associatedtype Configuration: ContentConfiguration
	
	var contentConfiguration: Configuration { get set }
	
	init(contentConfiguration: Configuration)
}

extension ContentView {
	var contentConfiguration: Configuration {
		get { configuration as! Configuration }
		set { configuration = newValue }
	}
}

protocol ContentConfiguration: UIContentConfiguration {
	
}

extension ContentConfiguration {
	func updated(for state: UIConfigurationState) -> Self {
		return self
	}
}
