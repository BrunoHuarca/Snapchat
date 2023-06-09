//
//  CrearUserViewController.swift
//  Snapchat
//
//  Created by Mac 06 on 9/06/23.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CrearUserViewController: UIViewController {
    @IBOutlet weak var nombreUsuarioTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func crearCuentaButtonTapped(_ sender: Any) {
        
        guard let nombreUsuario = nombreUsuarioTextField.text, !nombreUsuario.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            // Validar que los campos no estén vacíos
            // Mostrar una alerta de error si es necesario
            return
        }

        Auth.auth().createUser(withEmail: nombreUsuario, password: password) { (user, error) in
            if error != nil {
                print("Se presentó el siguiente error al crear el usuario: \(error)")
                // Mostrar una alerta de error si es necesario
            } else{
                print("El usuario fue creado exitosamente")
                
                Database.database().reference().child("usuarios").child(user!.user.uid).child("email").setValue(user!.user.email)
                let alerta = UIAlertController(title: "Creacion de Usuario", message: "Usuario: \(self.nombreUsuarioTextField.text) se creo correctamente.", preferredStyle: .alert)
                let btnOK = UIAlertAction(title: "Agregar", style: .default, handler: { (UIAlertAction) in
                    self.performSegue(withIdentifier: "iniciarsesionsegue2", sender: nil)
                })
                alerta.addAction(btnOK)
                self.present(alerta, animated: true, completion: nil)
                                   
                // Realizar la transición a la vista de éxito o a la vista deseada
            }
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

