//
//  ViewController.swift
//  TablaPlatos
//
//  Created by Camilo Alfonso on 13/09/17.
//  Copyright © 2017 Camilo Alfonso. All rights reserved.
//

import UIKit
import AFNetworking

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewPlatos: UITableView!
    
    //Definición del array de celdas en la tabla
    var platos:[Plato] = [Plato]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Agrega los platos al array
        tableViewPlatos.delegate = self
        tableViewPlatos.dataSource = self
        
        getPlatos()
    }
    
    func getPlatos(){
        manager.get("/platos", parameters: nil, progress: {(progress) in
        }, success: { (task: URLSessionDataTask, response) in
            let arrayResponse: NSArray = response! as! NSArray
            
            for item in arrayResponse {
                let currentPlato: Plato = Plato(item as! Dictionary<String,AnyObject>)
                self.platos.append(currentPlato)
                self.tableViewPlatos.reloadData()
            }
        }) { (task: URLSessionDataTask?, error: Error) in
            print("Errortask: \(task) --ErrorResponse: \(error) ")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return platos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Define reutilizamiento de las celdas
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "PlatoCell", for: indexPath)
        
        //Obtener el plato en la posición actual
        let currentPlato: Plato = platos[indexPath.row]
        
        //Obtener (con el tag) la referencia a la vista de la imagen en la celda
        let imageView: UIImageView = cell.viewWithTag(1) as! UIImageView
        imageView.setImageWith(URL(string: currentPlato.imagen!)!)
        
        //Obtener (con el tag) la referencia al campo de texto para el nombre
        let labelNombre: UILabel = cell.viewWithTag(2) as! UILabel
        labelNombre.text = currentPlato.nombre!
        
        //Obtener (con el tag) la referencia al capmo de texto para el precio
        let labelPrecio: UILabel = cell.viewWithTag(3) as! UILabel
        labelPrecio.text = String(currentPlato.precio!)
        
        //Se retorna la celda actual
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let platoSeleccionado: Plato = platos[indexPath.row]
        self.performSegue(withIdentifier: "GoToDetallePlato", sender: platoSeleccionado)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToDetallePlato" {
            let viewController: DetallePlatoViewController = segue.destination as! DetallePlatoViewController
            viewController.platoSeleccionado = sender as! Plato
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

