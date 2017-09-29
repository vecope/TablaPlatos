//
//  MetodoPagoViewController.swift
//  TablaPlatos
//
//  Created by Camilo Alfonso on 29/09/17.
//  Copyright © 2017 Camilo Alfonso. All rights reserved.
//

import UIKit

class MetodoPagoViewController: UIViewController {

    struct ConstantsSegmented {
        let Credito = 0
        let Debito = 1
        let Efectivo = 2
    }
    
    
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var segmentedPago: UISegmentedControl!
    
    var timerREST: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadingSpinner.startAnimating()
        segmentedPago.isHidden = true
        
        // El timer simula la solicitud REST
        
        timerREST = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(getMetodosPago), userInfo: nil, repeats: false)
    }

    @objc func getMetodosPago(){
        loadingSpinner.stopAnimating()
        segmentedPago.isHidden = false
    }
    
    @IBAction func cambiarMetodoPago(_ sender: Any) {
        if segmentedPago.selectedSegmentIndex == ConstantsSegmented().Credito {
            metodoSeleccionado = "Tarjeta de Crédito"
        }
        else if segmentedPago.selectedSegmentIndex == ConstantsSegmented().Credito {
            metodoSeleccionado = "Tarjeta de Crédito"
        }
        else if segmentedPago.selectedSegmentIndex == ConstantsSegmented().Efectivo {
            metodoSeleccionado = "Efectivo"
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timerREST.invalidate()
    }
    
    @IBAction func confirmar(_ sender: Any) {
        self.dismiss(animated: true){
            
        }
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true){
            
        }
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
