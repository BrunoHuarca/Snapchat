//
//  TelefonoViewController.swift
//  Snapchat
//
//  Created by Mac 06 on 1/06/23.
//

import UIKit
import FirebaseAuth
class TelefonoViewController: UIViewController {

    @IBOutlet weak var verificarTelefono: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func iniciarSesionConTelefonoTapped(_ sender: Any) {
        guard let phoneNumber = phoneNumberTextField.text else {
            print("Ingrese un numero de telefono valido")
            return
        }
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                print("se presento un error")
                return
            }
            guard let verificationID = verificationID else {
                print("el verificador ID es nulo")
                return
            }
            print("Se envio un còdigo de verificaciòn")
            self.verificarCodigo(verificationID: verificationID)
        }
    }
    
    func verificarCodigo(verificationID: String) {
        guard let verificationCode = verificarTelefono.text else {
            print("Ingrese un código de verificación válido")
            return
        }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                print("Se presentó el siguiente error al verificar el código: \(error.localizedDescription)")
                return
            }
            
            // Aquí puedes realizar acciones adicionales después de que el usuario se haya autenticado correctamente
            print("Verificación del código exitosa. Usuario autenticado.")
        }
    }
    

}





