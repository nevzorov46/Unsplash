//
//  FirstViewController.swift
//  Unsplash
//
//  Created by Иван Карамазов on 30.08.2021.
//

import UIKit

fileprivate let MAIN_SEGUE_NAME = "openVC"


class FirstViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        searchBar.delegate = self
    }
    @objc func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
     

    @IBAction func findImage(_ sender: Any) {
        guard searchBar.text != nil && searchBar.text != "" else {return}
        performSegue(withIdentifier: MAIN_SEGUE_NAME, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == MAIN_SEGUE_NAME, let vc = segue.destination as? ViewController, let request = searchBar.text, request != "" {
            vc.queryOptional = request
        }
    }
    
}
