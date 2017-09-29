//
//  DetallePlatoViewController.swift
//  TablaPlatos
//
//  Created by Camilo Alfonso on 20/09/17.
//  Copyright © 2017 Camilo Alfonso. All rights reserved.
//

import UIKit
import AFNetworking

class DetallePlatoViewController: UIViewController {

    var platoSeleccionado: Plato!
    
  
    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var lugarTextField: UITextField!
    
    override func viewDidLoad() {

        // Do any additional setup after loading the view.
    }

    @IBAction func hacerPedido(_ sender: Any) {
        
        if nombreTextField.text == nil || nombreTextField.text == "" {
            showAlert(title: "Nombre vacío", message: "Debe agregar un nombre para realizar el pedido", closeButtonTitle: "Cerrar")
            return
        }
        
        if lugarTextField.text == nil || lugarTextField.text == "" {
            showAlert(title: "Lugar vacío", message: "Debe agregar un lugar para realizar el pedido", closeButtonTitle: "Cerrar")
            return
        }
    
        let params: [String:Any] = [
            "platoID":String(platoSeleccionado.id),
            "cliente":nombreTextField.text!,
            "lugar":lugarTextField.text!
        ]
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.post("/pedidos", parameters: params, progress: { (progress) in
        }, success: { (task:URLSessionDataTask, response) in
            
            let dictionaryResponse: NSDictionary = response! as! NSDictionary
            print(dictionaryResponse)
            
            let alertController = UIAlertController(title: "Pedido exitoso", message: dictionaryResponse["msg"] as? String, preferredStyle: .alert)
            
            let volverAction = UIAlertAction(title: "Volver a platos", style: .default){ (action: UIAlertAction) in
                self.dismiss(animated: true, completion: nil)
            }
            alertController.addAction(volverAction)
            
            self.present(alertController, animated: true){
            }

            
        })  {  (task: URLSessionDataTask?, error: Error) in
            print("Error Task: \(task) -- Error response: \(error) ")
            self.showAlert(title: "Error en la solicitud", message: error.localizedDescription, closeButtonTitle: "Cerrar")
        }
    }
    
    
    func showAlert(title:String, message:String, closeButtonTitle:String){
        let alertController = UIAlertController(title: title, message:message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title:closeButtonTitle, style: .default){ (action: UIAlertAction) in
            //Ejecutar algún código al pulsar esta opcion
        }
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true){
            
        }
    }
    
    @IBAction func volverBtn(_ sender: Any) {
        //Método para deshacer la transición
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
