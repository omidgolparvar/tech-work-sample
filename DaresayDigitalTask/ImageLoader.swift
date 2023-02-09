//
//  ImageLoader.swift
//  DaresayDigitalTask
//
//  Created by Omid Golparvar on 2/9/23.
//

import Foundation
import UIKit

protocol ImageLoader {
	func cacheImage(_ image: UIImage, for url: URL)
	func cachedImage(for url: URL) -> UIImage?
	func cachedImage(for urlRequest: URLRequest) -> UIImage?
	func load(url: URL, completion: @escaping (_ image: UIImage?) -> Void)
}

class URLCacheBasedImageLoader: ImageLoader {
	
	static let shared = URLCacheBasedImageLoader()
	
	private let urlCache: URLCache
	
	init(urlCache: URLCache = .shared) {
		self.urlCache = urlCache
	}
	
	func cacheImage(_ image: UIImage, for url: URL) {
		guard
			let data = image.jpegData(compressionQuality: 1),
			let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
		else { return }
		
		let cachedData = CachedURLResponse(response: response, data: data)
		let request = URLRequest(url: url)
		urlCache.storeCachedResponse(cachedData, for: request)
	}
	
	func cachedImage(for request: URLRequest) -> UIImage? {
		return urlCache
			.cachedResponse(for: request)
			.flatMap { $0.data }
			.flatMap { UIImage(data: $0) }
	}
	
	func cachedImage(for url: URL) -> UIImage? {
		let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
		return cachedImage(for: request)
	}
	
	func load(url: URL, completion: @escaping (_ image: UIImage?) -> Void) {
		if let image = cachedImage(for: url) {
			DispatchQueue.main.async {
				completion(image)
			}
		} else {
			let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
			
			URLSession
				.shared
				.dataTask(with: request, completionHandler: { [weak self] (data, response, _) in
					guard let self else { return }
					guard let response = response as? HTTPURLResponse else { return }
					guard 200 ..< 300 ~= response.statusCode else { return }
					guard let data, let image = UIImage(data: data) else { return }
					
					self.cacheImage(image, for: url)
					DispatchQueue.main.async {
						completion(image)
					}
				})
				.resume()
		}
	}
	
	
}

extension UIImageView {
	
	func load(url: URL, using loader: ImageLoader = URLCacheBasedImageLoader.shared) {
		self.image = nil
		loader.load(url: url) { image in
			DispatchQueue.main.async {
				self.image = image
			}
		}
	}
	
}
