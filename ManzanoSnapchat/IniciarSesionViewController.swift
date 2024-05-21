//
//  IniciarSesionViewController.swift
//  ManzanoSnapchat
//
//  Created by Jorge Manuel Manzano Añamuro on 20/05/24.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class IniciarSesionViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: GIDSignInButton!
    
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
    
    @IBAction func iniciarSesionGoogle(_ sender: Any) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
          guard error == nil else {
            return
          }

          guard let user = result?.user,
            let idToken = user.idToken?.tokenString
          else {
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { (authResult, error) in
                print("Intentando Iniciar Sesion en Google")
                if let error = error {
                    print("Error iniciando sesion en Google: \(error)")
                    return
                }
                print("Inicio de sesion con Google exitoso")
            }
        }
    }
}
