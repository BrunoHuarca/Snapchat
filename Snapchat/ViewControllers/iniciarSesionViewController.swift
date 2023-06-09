//
//  ViewController.swift
//  Snapchat
//
//  Created by Mac 06 on 1/06/23.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class iniciarSesionViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func IniciarSesionTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            print("Intentando Iniciar Sesion")
            if error != nil {
                print("Se presento el siguiente error: \(error)")
                
                let alerta = UIAlertController(title: "Usuario no existe", message: "El usuario no existe. ¿Desea crear uno nuevo?", preferredStyle: .alert)
                
                let crearUsuarioAction = UIAlertAction(title: "Crear usuario", style: .default) { (_) in
                    self.performSegue(withIdentifier: "crearUser", sender: nil)
                }
                
                let cancelarAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
                
                alerta.addAction(crearUsuarioAction)
                alerta.addAction(cancelarAction)
                
                self.present(alerta, animated: true, completion: nil)
            } else {
                print("Inicio de sesion exitoso")
                self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
            }
        }
    }


    
}

