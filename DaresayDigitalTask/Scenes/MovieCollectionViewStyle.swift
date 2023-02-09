//

import Foundation
import UIKit

enum MovieCollectionViewStyle {
	
	static func list() -> UICollectionViewLayout {
		let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
		return UICollectionViewCompositionalLayout.list(using: configuration)
	}
	
	static func grid() -> UICollectionViewLayout {
		return UICollectionViewCompositionalLayout.init { section, environment in
			let numberOfColumn: CGFloat = 2
			let ratio: CGFloat = 4 / 3
			let itemSize = NSCollectionLayoutSize(
				widthDimension: .fractionalWidth(1.0 / numberOfColumn),
				heightDimension: .fractionalHeight(1.0)
			)
			let item = NSCollectionLayoutItem(layoutSize: itemSize)
			item.contentInsets.leading = 4
			item.contentInsets.trailing = 4
			
			let groupSize = NSCollectionLayoutSize(
				widthDimension: .fractionalWidth(1.0),
				heightDimension: .fractionalWidth((1.0 / numberOfColumn) * ratio)
			)
			let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
			group.contentInsets.bottom = 8
			
			let section = NSCollectionLayoutSection(group: group)
			section.contentInsets = .init(top: 0, leading: 12, bottom: 20, trailing: 12)
			
			return section
		}
	}
	
}
