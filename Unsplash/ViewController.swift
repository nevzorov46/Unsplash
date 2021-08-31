//
//  ViewController.swift
//  Unsplash
//
//  Created by Иван Карамазов on 30.08.2021.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    var queryOptional: String?
    let url = "https://api.unsplash.com/search/photos?page=1&per_page=50&query=sea&client_id=pb4AHq38jJjrIN1UZLV88xdW2ROfuhPxT2w-2DlQ20w"
    
    
    var response: [Results] = []
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
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
        
        let url = "https://api.unsplash.com/search/photos?page=1&per_page=50&query=\(query)&client_id=pb4AHq38jJjrIN1UZLV88xdW2ROfuhPxT2w-2DlQ20w"
        
        guard let url  = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: url ) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
                self?.response = jsonResult.results
                DispatchQueue.main.async {
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

