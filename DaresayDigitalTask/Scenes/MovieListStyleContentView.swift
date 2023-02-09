//

import Foundation
import UIKit

final class MovieListStyleContentView: UIView, ContentView {
	
	// MARK: - Subviews
	
	private let mainStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .horizontal
		stackView.alignment = .top
		stackView.distribution = .fill
		stackView.spacing = 12
		stackView.isLayoutMarginsRelativeArrangement = true
		stackView.directionalLayoutMargins = .init(top: 12, leading: 16, bottom: 12, trailing: 12)
		return stackView
	}()
	private let posterImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		imageView.backgroundColor = .systemGray6
		imageView.layer.cornerCurve = .continuous
		imageView.layer.cornerRadius = 8
		imageView.clipsToBounds = true
		return imageView
	}()
	private let textsStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.alignment = .leading
		stackView.distribution = .fill
		stackView.spacing = 8
		return stackView
	}()
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 3
		label.textColor = .label
		label.font = UIFont.preferredFont(forTextStyle: .headline, compatibleWith: nil)
		return label
	}()
	private let subtitleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 3
		label.textColor = .secondaryLabel
		label.font = UIFont.preferredFont(forTextStyle: .caption1, compatibleWith: nil)
		return label
	}()
	private let metadataStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.alignment = .center
		stackView.distribution = .fill
		stackView.spacing = 20
		return stackView
	}()
	private let rateStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.alignment = .center
		stackView.distribution = .fill
		stackView.spacing = 4
		return stackView
	}()
	private let rateIconImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		imageView.image = .init(sfSymbol: "heart.fill")
		imageView.tintColor = .systemRed
		return imageView
	}()
	private let rateLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .systemRed
		label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
		return label
	}()
	private let releaseDateLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .secondaryLabel
		label.font = UIFont.preferredFont(forTextStyle: .caption2, compatibleWith: nil)
		return label
	}()
	private let isFavoriteLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .white
		label.font = UIFont.systemFont(ofSize: 8, weight: .semibold)
		label.text = "Favorite".uppercased()
		return label
	}()
	private let isFavoriteLabelContainer: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .systemRed
		view.layer.cornerRadius = 6
		return view
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
		addSubview(mainStackView)
		mainStackView.addArrangedSubview(posterImageView)
		mainStackView.addArrangedSubview(textsStackView)
		metadataStackView.addArrangedSubview(releaseDateLabel)
		metadataStackView.addArrangedSubview(rateStackView)
		isFavoriteLabelContainer.addSubview(isFavoriteLabel)
		metadataStackView.addArrangedSubview(isFavoriteLabelContainer)
		rateStackView.addArrangedSubview(rateIconImageView)
		rateStackView.addArrangedSubview(rateLabel)
		textsStackView.addArrangedSubview(titleLabel)
		textsStackView.addArrangedSubview(metadataStackView)
		textsStackView.addArrangedSubview(subtitleLabel)
		
		NSLayoutConstraint.activate([
			mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
			mainStackView.topAnchor.constraint(equalTo: topAnchor),
			mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
			mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
			
			posterImageView.widthAnchor.constraint(equalToConstant: 80),
			posterImageView.heightAnchor.constraint(equalToConstant: 120),
			
			rateIconImageView.widthAnchor.constraint(equalToConstant: 12),
			rateIconImageView.heightAnchor.constraint(equalToConstant: 12),
			
			isFavoriteLabelContainer.heightAnchor.constraint(equalToConstant: 12),
			
			isFavoriteLabel.leadingAnchor.constraint(equalTo: isFavoriteLabelContainer.leadingAnchor, constant: 6),
			isFavoriteLabel.topAnchor.constraint(equalTo: isFavoriteLabelContainer.topAnchor),
			isFavoriteLabel.trailingAnchor.constraint(equalTo: isFavoriteLabelContainer.trailingAnchor, constant: -6),
			isFavoriteLabel.bottomAnchor.constraint(equalTo: isFavoriteLabelContainer.bottomAnchor),
		])
		
		updateViewBasedOnConfiguration()
	}
	
	private func updateViewBasedOnConfiguration() {
		let viewModel = contentConfiguration.movieViewModel
		titleLabel.text = viewModel.movieTitle
		subtitleLabel.text = viewModel.movieOverview
		rateLabel.text = viewModel.rateString
		releaseDateLabel.text = viewModel.releaseDateString
//		isFavoriteLabelContainer.isHidden = viewModel.isFavorite
		if let url = viewModel.moviePosterURL {
			posterImageView.load(url: url)
		}
	}
	
}

extension MovieListStyleContentView {
	
	// MARK: - Configuration
	
	struct Configuration: ContentConfiguration {
		let movieViewModel: MovieViewModel
		
		func makeContentView() -> UIView & UIContentView {
			MovieListStyleContentView(contentConfiguration: self)
		}
	}
	
}
