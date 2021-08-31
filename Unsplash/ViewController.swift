//
//  ViewController.swift
//  Unsplash
//
//  Created by Иван Карамазов on 30.08.2021.
//

import UIKit

fileprivate let CLIENT_ID = "pb4AHq38jJjrIN1UZLV88xdW2ROfuhPxT2w-2DlQ20w"

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var noImagesLabel: UICollectionView!
    var queryOptional: String?
    var response: [Results] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        if let query = queryOptional {
            fetchImages(with: query)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return response.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.id, for: indexPath) as! PhotoCollectionViewCell
        let imageURL = response[indexPath.row].urls.small
        cell.configure(with: imageURL)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2, height: view.frame.size.width/2 )
    }
    
    func fetchImages(with query: String) {
        noImagesLabel.isHidden = true
        let url = "https://api.unsplash.com/search/photos?page=1&per_page=50&query=\(query)&client_id=\(CLIENT_ID)"
        
        guard let url  = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: url ) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
                self?.response = jsonResult.results
                DispatchQueue.main.async {
                    if self?.response.isEmpty == true {
                        self?.noImagesLabel.isHidden = false
                    }
                    else {
                        self?.noImagesLabel.isHidden = true
                    }
                    self?.imagesCollectionView.reloadData()
                }
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    
}

