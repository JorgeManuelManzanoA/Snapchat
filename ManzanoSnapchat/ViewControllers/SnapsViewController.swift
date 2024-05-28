//
//  SnapsViewController.swift
//  ManzanoSnapchat
//
//  Created by Jorge Manuel Manzano Añamuro on 27/05/24.
//

import UIKit

class SnapsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func cerrarSesionTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
