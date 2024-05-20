//
//  IniciarSesionViewController.swift
//  ManzanoSnapchat
//
//  Created by Jorge Manuel Manzano Añamuro on 20/05/24.
//

import UIKit
import FirebaseAuth

class IniciarSesionViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func iniciarSesionTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            print("Intentando Iniciar Sesion")
            if error != nil {
                print("Se presento el siguiente error \(error)")
            } else {
                print("Inicio de sesion exitoso")
            }
        }
    }
}
