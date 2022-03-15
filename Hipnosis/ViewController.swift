//
//  ViewController.swift
//  Hipnosis
//
//  Created by Virtualizacion12 on 10/02/22.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var vistaHipnosis: HipnosisView!
    var campoTexto : UITextField!
    var animador : UIDynamicAnimator!
    var gravedad : UIGravityBehavior!
    var colision : UICollisionBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /*
        let tamanoDePantalla = self.view.bounds.size
        self.view.backgroundColor = .red
        
        //let miVista1 = UIView(frame: CGRect (x:30, y:50, width: 200, height: 500))
        let miVista1 = UIView(frame: CGRect (x:30, y:50, width: tamanoDePantalla.width / 3, height:tamanoDePantalla.height / 2))
        miVista1.backgroundColor = .green
        miVista1.alpha = 1
        self.view.addSubview(miVista1)
        
        let miLabel = UILabel (frame : CGRect(x:30, y:50, width: miVista1.bounds.size.width/2, height: miVista1.bounds.size.height/10))
        miLabel.text = "Hola Mundo"
        miVista1.addSubview(miLabel)
        */
        let anchoCampoTexto = self.view.bounds.maxX * 0.75
        let origenCampoTexto = (self.view.bounds.maxX - anchoCampoTexto) / 2.0
        let rectanguloCampotexto = CGRect(x: origenCampoTexto, y: -70, width: anchoCampoTexto, height: 30)
        //let campoTexto = UITextField (frame: rectanguloCampotexto)
        self.campoTexto = UITextField (frame: rectanguloCampotexto)
        campoTexto.placeholder = "Hipnotizar"
        
        campoTexto.borderStyle = .roundedRect
        campoTexto.returnKeyType = .done
        campoTexto.delegate = self
        self.vistaHipnosis.addSubview(campoTexto)
        
        self.animador = UIDynamicAnimator(referenceView: vistaHipnosis)
        self.gravedad = UIGravityBehavior()
        self.gravedad.magnitude = 0.25
        //self.gravedad.angle = 0.25 * Double.pi
        self.animador.addBehavior(gravedad)
        
        self.colision = UICollisionBehavior()
        self.colision.translatesReferenceBoundsIntoBoundary = true
        self.animador.addBehavior(colision)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let textoIngresado = textField.text!
        avientaTexto(texto: textoIngresado)
        textField.placeholder = "Hipnotizame"
        textField.resignFirstResponder()//El teclado se esconde despues del DONE
        return true
    }
    
    func avientaTexto(texto: String){
        //print("El usuario tecleo \(texto)")
        for _ in 1...20 {
            let labelTexto = UILabel()
            labelTexto.backgroundColor = .clear
            labelTexto.textColor = .black
            labelTexto.text = texto
            labelTexto.sizeToFit()
            let anchoDisponiblePantalla = self.view.bounds.size.width - labelTexto.bounds.size.width
            var coordenadaXRandom = Double.random(in: 0...anchoDisponiblePantalla)
            let altoDisponiblePantalla = self.view.bounds.size.height - labelTexto.bounds.size.height
            var coordenadaYRandom = Double.random(in: 0...altoDisponiblePantalla)
            labelTexto.frame.origin = CGPoint(x: coordenadaXRandom, y: coordenadaYRandom)
            self.vistaHipnosis.addSubview(labelTexto)
            labelTexto.alpha = 0.0
            UIView.animate(withDuration: 3.0, animations: {
                labelTexto.alpha = 1.0
            })
            
            UIView.animateKeyframes(withDuration: 1, delay: 3, options: .layoutSubviews, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.8, animations: {
                    labelTexto.center = self.vistaHipnosis.center
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2, animations: {
                    coordenadaXRandom = Double.random(in: 0...anchoDisponiblePantalla)
                    coordenadaYRandom = Double.random(in: 0...anchoDisponiblePantalla)
                    labelTexto.frame.origin = CGPoint(x: coordenadaXRandom, y: coordenadaYRandom)
                })
                
            }, completion: {
                finAnimacion in//argumento booleano que recibimos, mientras es true
                if (finAnimacion) {
                    self.gravedad.addItem(labelTexto)
                    self.colision.addItem(labelTexto)
                }
            })
            
        }
    }
    
    @IBAction func drag(_ sender: UIPanGestureRecognizer) {
        //print("Estan haciendo drag.")
        let traslacion = sender.translation(in: self.view)
        self.vistaHipnosis.frame.origin.x += traslacion.x
        self.vistaHipnosis.frame.origin.y += traslacion.y
        sender.setTranslation(.zero, in: self.view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 2.0, delay: 0.5, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.4, options: .layoutSubviews, animations: {
            self.campoTexto.frame.origin.y = 70
        }, completion: nil)
        
    }

}

