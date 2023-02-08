//

import Foundation
import UIKit

final class TopRatedMovieContentView: UIView, ContentView {
	
	var configuration: UIContentConfiguration {
		didSet { updateViewBasedOnConfiguration() }
	}
	
	init(contentConfiguration: Configuration) {
		self.configuration = contentConfiguration
		super.init(frame: .zero)
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupViews() {
		updateViewBasedOnConfiguration()
	}
	
	private func updateViewBasedOnConfiguration() {
		
	}
	
}

extension TopRatedMovieContentView {
	
	struct Configuration: ContentConfiguration {
		
		func makeContentView() -> UIView & UIContentView {
			fatalError()
		}
		
	}
	
}
