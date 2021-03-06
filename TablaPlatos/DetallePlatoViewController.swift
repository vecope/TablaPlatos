//
//  DetallePlatoViewController.swift
//  TablaPlatos
//
//  Created by Camilo Alfonso on 20/09/17.
//  Copyright © 2017 Camilo Alfonso. All rights reserved.
//

import UIKit
import AFNetworking
import CoreLocation
import CoreMotion
import CoreData

var metodoSeleccionado: String = "Debito"


class DetallePlatoViewController: UIViewController, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var motionManager: CMMotionManager!
    
    var locationManager: CLLocationManager = CLLocationManager()
    var userLocation: CLLocation!

    var platoSeleccionado: NSManagedObject!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var labelMetodoPago: UILabel!
    
    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var lugarTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        userLocation = nil
        
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Método: \(metodoSeleccionado)")
        labelMetodoPago.text = "Pago con " + metodoSeleccionado
    }
    
    
    @IBAction func cambiarMetodoPago(_ sender: Any) {
        self.performSegue(withIdentifier: "GoToMetodoDePago", sender: sender)
    }
    
    @IBOutlet weak var labelInfoAcelerometro: UILabel!
    
    
    @IBAction func obtenerInfoAcelerometro(_ sender: Any) {
        
        if let accelerometerData = motionManager.accelerometerData{
            labelInfoAcelerometro.text = "X:" + String(accelerometerData.acceleration.x) + "Y:" + String(accelerometerData.acceleration.y) + "Z:" + String(accelerometerData.acceleration.z)
        }
        
    }
    
    
    
    
    
    @IBOutlet weak var imagenPreview: UIImageView!
    
    @IBAction func tomarFoto(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func seleccionarFoto(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum){
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        
        self.dismiss(animated: true, completion: nil)
        
        if mediaType.isEqual(to: kUTTypeImage as String){
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            imagenPreview.image = image
        }
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
            "platoID":String(describing: platoSeleccionado.value(forKeyPath: "id")),
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let latestLocation: CLLocation = locations[locations.count - 1]
        
        if userLocation == nil {
            userLocation = latestLocation
        }
        locationLabel.text = "("+String(userLocation.coordinate.latitude)+","+String(userLocation.coordinate.longitude)+")"
//        print("("+String(userLocation.coordinate.latitude)+","+String(userLocation.coordinate.longitude)+")")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager error: "+error.localizedDescription)
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
