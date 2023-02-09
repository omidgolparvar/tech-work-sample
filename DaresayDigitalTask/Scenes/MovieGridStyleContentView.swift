//

import Foundation
import UIKit

final class MovieGridStyleContentView: UIView, ContentView {
	
	// MARK: - Subviews
	
	private let posterImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		imageView.backgroundColor = .systemGray6
		imageView.layer.cornerCurve = .continuous
		imageView.layer.cornerRadius = 8
		return imageView
	}()
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 3
		label.textColor = .white
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
		return label
	}()
	private let titleContainerView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .black.withAlphaComponent(0.7)
		return view
	}()
	private let isFavoriteCircleView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .white
		view.layer.cornerRadius = 16
		return view
	}()
	private let isFavoriteImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		imageView.image = .init(sfSymbol: "heart.circle", pointSize: 24, weight: .bold, scale: .large)
		imageView.tintColor = .systemRed
		return imageView
	}()
	
	// MARK: - Configuration
	
	var configuration: UIContentConfiguration {
		didSet { updateViewBasedOnConfiguration() }
	}
	
	// MARK: - Initializers
	
	init(contentConfiguration: Configuration) {
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
		backgroundColor = .tertiarySystemBackground
		layer.cornerCurve = .continuous
		layer.cornerRadius = 12
		clipsToBounds = true
		
		addSubview(posterImageView)
		addSubview(titleContainerView)
		titleContainerView.addSubview(titleLabel)
		bringSubviewToFront(titleContainerView)
		addSubview(isFavoriteImageView)
		addSubview(isFavoriteCircleView)
		bringSubviewToFront(isFavoriteCircleView)
		bringSubviewToFront(isFavoriteImageView)
		
		NSLayoutConstraint.activate([
			posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
			posterImageView.topAnchor.constraint(equalTo: topAnchor),
			posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
			posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
			
			titleContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
			titleContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
			titleContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),
			
			titleLabel.leadingAnchor.constraint(equalTo: titleContainerView.leadingAnchor, constant: 8),
			titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor, constant: 8),
			titleLabel.trailingAnchor.constraint(equalTo: titleContainerView.trailingAnchor, constant: -8),
			titleLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor, constant: -8),
			
			isFavoriteImageView.widthAnchor.constraint(equalToConstant: 32),
			isFavoriteImageView.heightAnchor.constraint(equalToConstant: 32),
			isFavoriteImageView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
			isFavoriteImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
			
			isFavoriteCircleView.widthAnchor.constraint(equalToConstant: 32),
			isFavoriteCircleView.heightAnchor.constraint(equalToConstant: 32),
			isFavoriteCircleView.centerXAnchor.constraint(equalTo: isFavoriteImageView.centerXAnchor),
			isFavoriteCircleView.centerYAnchor.constraint(equalTo: isFavoriteImageView.centerYAnchor),
		])
		
		updateViewBasedOnConfiguration()
	}
	
	private func updateViewBasedOnConfiguration() {
		let viewModel = contentConfiguration.movieViewModel
		titleLabel.text = viewModel.movieTitle
//		isFavoriteImageView.isHidden = !viewModel.isFavorite
//		isFavoriteCircleView.isHidden = !viewModel.isFavorite
		if let url = viewModel.moviePosterURL {
			posterImageView.load(url: url)
		}
	}
	
}

extension MovieGridStyleContentView {
	
	// MARK: - Configuration
	
	struct Configuration: ContentConfiguration {
		let movieViewModel: MovieViewModel
		
		func makeContentView() -> UIView & UIContentView {
			MovieGridStyleContentView(contentConfiguration: self)
		}
	}
	
}
