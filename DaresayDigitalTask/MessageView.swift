//

import Foundation
import UIKit

class MessageView: UIView, ContentView {
	
	private let mainStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.alignment = .fill
		stackView.distribution = .fill
		stackView.spacing = 24
		return stackView
	}()
	private let emojiLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.font = .systemFont(ofSize: 48)
		return label
	}()
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.textColor = .label
		label.font = .systemFont(ofSize: 24, weight: .bold)
		label.numberOfLines = 0
		return label
	}()
	private let messageLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.textColor = .secondaryLabel
		label.font = .systemFont(ofSize: 18, weight: .regular)
		label.numberOfLines = 0
		return label
	}()
	private let button: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	// MARK: - Configuration
	
	var configuration: UIContentConfiguration {
		didSet { updateViewBasedOnConfiguration() }
	}
	
	// MARK: - Initializers
	
	required init(contentConfiguration: Configuration) {
		self.configuration = contentConfiguration
		super.init(frame: .zero)
		setupViews()
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Setup Subviews
	
	private func setupViews() {
		backgroundColor = .systemBackground
		
		addSubview(mainStackView)
		mainStackView.addArrangedSubview(emojiLabel)
		mainStackView.addArrangedSubview(titleLabel)
		mainStackView.setCustomSpacing(12, after: titleLabel)
		mainStackView.addArrangedSubview(messageLabel)
		
		let buttonContainer = UIView()
		buttonContainer.addSubview(button)
		mainStackView.addArrangedSubview(buttonContainer)
		
		NSLayoutConstraint.activate([
			mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
			mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
			mainStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
			
			button.topAnchor.constraint(equalTo: buttonContainer.topAnchor),
			button.bottomAnchor.constraint(equalTo: buttonContainer.bottomAnchor),
			button.centerXAnchor.constraint(equalTo: buttonContainer.centerXAnchor),
		])
		
		updateViewBasedOnConfiguration()
	}
	
	private func updateViewBasedOnConfiguration() {
		emojiLabel.text = contentConfiguration.emoji
		titleLabel.text = contentConfiguration.title
		messageLabel.text = contentConfiguration.message
		button.setTitle(contentConfiguration.buttonAction?.title, for: .normal)
		button.isHidden = contentConfiguration.buttonAction == nil
		
		if let buttonAction = contentConfiguration.buttonAction {
			var buttonConfiguration = UIButton.Configuration.filled()
			buttonConfiguration.title = buttonAction.title
			button.configuration = buttonConfiguration
			
			let action = UIAction { _ in buttonAction.action() }
			button.addAction(action, for: .touchUpInside)
			button.isHidden = false
		} else {
			button.isHidden = true
		}
	}
	
}

extension MessageView {
	
	struct Configuration: ContentConfiguration {
		let emoji: String
		let title: String
		let message: String
		let buttonAction: ButtonAction?
		
		func makeContentView() -> UIView & UIContentView {
			MessageView(contentConfiguration: self)
		}
	}
	
	struct ButtonAction {
		let title: String
		let action: () -> Void
	}
	
}

extension MessageView.Configuration {
	
	static func presetError(_ error: Error, action: @escaping () -> Void) -> Self {
		presetError(error.localizedDescription, action: action)
	}
	
	static func presetError(_ errorMessage: String, action: @escaping () -> Void) -> Self {
		.init(emoji: "❌", title: "Error", message: errorMessage, buttonAction: .init(title: "Retry", action: action))
	}
	
}
