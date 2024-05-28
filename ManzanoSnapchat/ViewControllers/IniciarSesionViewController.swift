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
import FirebaseDatabase

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
            if let error = error {
                print("Se presentó el siguiente error: \(error)")
                let alerta = UIAlertController(title: "Error al iniciar sesión", message: "Este usuario no se encuentra registrado en la base de datos", preferredStyle: .alert)
                let btnOk = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
                let btnRegistrar = UIAlertAction(title: "Crear usuario", style: .default) { (action) in
                    self.performSegue(withIdentifier: "registrarUsuarioSegue", sender: nil)
                }
                alerta.addAction(btnRegistrar)
                alerta.addAction(btnOk)
                self.present(alerta, animated: true, completion: nil)
            } else {
                print("Inicio de sesión exitoso")
                self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
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
                    print("Error iniciando sesión en Google: \(error)")
                    return
                }
                print("Inicio de sesión con Google exitoso")
            }
        }
    }
}
