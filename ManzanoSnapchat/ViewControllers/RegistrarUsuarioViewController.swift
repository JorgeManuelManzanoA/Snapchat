//
//  RegistrarUsuarioViewController.swift
//  ManzanoSnapchat
//
//  Created by Jorge Manuel Manzano Añamuro on 27/05/24.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegistrarUsuarioViewController: UIViewController {

    @IBOutlet weak var usuarioTextField: UITextField!
    @IBOutlet weak var contraseñaTextField: UITextField!
    @IBOutlet weak var registrarButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registrarUsuario(_ sender: Any) {
        Auth.auth().createUser(withEmail: usuarioTextField.text!, password: contraseñaTextField.text!) { (user, error) in
                if let error = error {
                    print("Se presentó el siguiente error al crear el usuario: \(error)")
                    let alerta = UIAlertController(title: "Error al registrar usuario", message: "Error: \(error.localizedDescription)", preferredStyle: .alert)
                    let btnOk = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alerta.addAction(btnOk)
                    self.present(alerta, animated: true, completion: nil)
                } else {
                    print("El usuario fue creado exitosamente")
                    let userData = ["email": user?.user.email ?? "", "uid": user?.user.uid ?? ""]
                    Database.database().reference().child("usuarios").child(user!.user.uid).setValue(userData)
                    let alerta = UIAlertController(title: "Creación de Usuario", message: "Usuario: \(self.usuarioTextField.text!) se creó correctamente.", preferredStyle: .alert)
                    let btnOk = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alerta.addAction(btnOk)
                    self.present(alerta, animated: true, completion: nil)
                }
            }
    }
    

}
