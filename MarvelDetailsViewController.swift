//
//  MarvelDetailsViewController.swift
//  trainingApp
//
//  Created by Ulysse GUILLOT on 22/02/2023.
//

import UIKit

class MarvelDetailsViewController: UIViewController {
    
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var imageView: UIImageView?
    @IBOutlet var logoImageView: UIImageView?
    var descriptionText: String?
    var url: URL?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        logoImageView?.image = UIImage(named: "marvelLogo")
        
        
        downloadImage(from: url!)
        descriptionLabel.text = descriptionText
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.imageView?.image = UIImage(data: data)
            }
        }
    }
}
