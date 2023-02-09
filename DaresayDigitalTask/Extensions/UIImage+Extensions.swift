//
//  UIImage+Extensions.swift
//  DaresayDigitalTask
//
//  Created by Omid Golparvar on 2/9/23.
//

import Foundation
import UIKit

extension UIImage {
	
	convenience init?(sfSymbol: String, pointSize: CGFloat = 0, weight: UIImage.SymbolWeight = .regular, scale: SymbolScale = .default) {
		let configuration = UIImage.SymbolConfiguration.init(pointSize: pointSize, weight: weight, scale: scale)
		self.init(systemName: sfSymbol, withConfiguration: configuration)
	}
	
}
