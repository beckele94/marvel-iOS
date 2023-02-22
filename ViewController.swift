//
//  ViewController.swift
//  trainingApp
//
//  Created by Ulysse GUILLOT on 09/01/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var grayView: UIView?
    @IBOutlet var buttonLogin: UIButton?
    @IBOutlet var textFieldLogin: UITextField?
    @IBOutlet var textFieldPassword: UITextField?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldLogin?.placeholder = "Nom de compte"
        textFieldPassword?.placeholder = "Mot de passe"
        textFieldPassword?.isSecureTextEntry = true
    }
    
    @IBAction func connect(){
        if(textFieldLogin?.text == "" && textFieldPassword?.text == ""){
            let alertController = UIAlertController(title: "Info", message: "Authentification réussie !", preferredStyle: .alert)

            let defaultAction = UIAlertAction(title: "OK", style: .default) { action in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
                //self.present(viewController, animated: true)
                
                self.navigationController?.pushViewController(viewController, animated: true)

                
            }
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            
        }
        else{
            let alertController = UIAlertController(title: "Erreur", message: "Mauvais login ou mot de passe !", preferredStyle: .alert)

            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            alertController.view.tintColor = UIColor.red
            
            present(alertController, animated: true, completion: nil)
            
        }
    }
}
