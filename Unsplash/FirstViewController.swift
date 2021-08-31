//
//  FirstViewController.swift
//  Unsplash
//
//  Created by Иван Карамазов on 30.08.2021.
//

import UIKit

class FirstViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var welcomeImage: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    var stringRequest: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        //welcomeImage.image = UIImage(named: "Rome")
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        if let text = searchBar.text {
            self.stringRequest = text
        }

    }

    @IBAction func findImage(_ sender: Any) {
        performSegue(withIdentifier: "openVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openVC", let vc = segue.destination as? ViewController, let request = stringRequest {
            vc.queryOptional = request
        }
    }
    
}
