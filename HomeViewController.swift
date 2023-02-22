//
//  HomeViewController.swift
//  trainingApp
//
//  Created by Ulysse GUILLOT on 20/02/2023.
//

import UIKit


class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView?
    @IBOutlet var activityIndicator: UIActivityIndicatorView?
    private let cellId = "cellId"
    private var marvelItems: Marvel?
    var apiMarvel: ApiMarvel? = ApiMarvel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator?.hidesWhenStopped = true
        activityIndicator?.startAnimating()
        
        tableView?.dataSource = self
        tableView?.delegate = self
        
        
        
        apiMarvel?.retrieveData(completion: { result in
            switch result {
            case .success(let marvels):
                self.marvelItems = marvels
                // Actualiser la table view sur le thread principal
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                    self.activityIndicator?.stopAnimating()
                }
                
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return marvelItems?.data.results.count ?? 0
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath)
        let marvelItem = marvelItems?.data.results[indexPath.row]
        cell.textLabel?.text = marvelItem?.name
        
        if((marvelItem?.description) != ""){
            cell.detailTextLabel?.text = "..."
        }else{
            cell.detailTextLabel?.text = ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Récupérer le personnage Marvel sélectionné
        guard let marvelItem = marvelItems?.data.results[indexPath.row] else {
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let marvelDetailsViewController = storyboard.instantiateViewController(withIdentifier: "MarvelDetailsViewController") as? MarvelDetailsViewController else {
            return
        }
        
        marvelDetailsViewController.descriptionText = marvelItem.description
        
        let path = marvelItem.thumbnail.path.replacingOccurrences(of: "http", with: "https", options: .literal, range: nil)
        
        marvelDetailsViewController.url = URL(string: path + "." + marvelItem.thumbnail.thumbnailExtension.rawValue)
        
        self.present(marvelDetailsViewController, animated: true)
    }
}
