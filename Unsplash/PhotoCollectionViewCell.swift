//
//  PhotoCollectionViewCell.swift
//  Unsplash
//
//  Created by Иван Карамазов on 30.08.2021.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    static let id = "images"
    @IBOutlet weak var mainImage: UIImageView!
    
    func configure (with urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self?.mainImage.image = image
            }
        }
        task.resume()
    }
    
}
