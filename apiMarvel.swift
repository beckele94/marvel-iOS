//
//  apiMarvel.swift
//  trainingApp
//
//  Created by Ulysse GUILLOT on 21/02/2023.
//

import Foundation
import UIKit

struct Marvel: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let results: [ResultData]
}

// MARK: - Result
struct ResultData: Codable {
    let id: Int
    let name, description: String
    let thumbnail: Thumbnail
}

struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: Extension
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

enum Extension: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
    case png = "png"
}

class ApiMarvel{
    
    public var marvelItems: Marvel?
    
    func retrieveData(completion: @escaping (Result<Marvel, Error>) -> Void){
        let url = URL(string: "https://gateway.marvel.com/v1/public/characters?ts=10000&apikey=9324990817df03907a237fc52958e4f1&hash=a53826a71981b7eb2bde14709476d4f1")!
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data {
                        do {
                            // Analyser les données JSON en un tableau d'objets
                            let decoder = JSONDecoder()
                            let marvels = try decoder.decode(Marvel.self, from: data)
                            completion(.success(marvels))
                        } catch let error {
                            print("Erreur lors de la récupération des données JSON : \(error.localizedDescription)")
                            completion(.failure(error))
                        }
                    } else if let error = error {
                        print("Erreur lors de la récupération des données JSON : \(error.localizedDescription)")
                        completion(.failure(error))
                    }
                }.resume()
    }
}
