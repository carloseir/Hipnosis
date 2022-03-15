//
//  HipnosisView.swift
//  Hipnosis
//
//  Created by Virtualizacion12 on 10/02/22.
//

import UIKit

class HipnosisView: UIView {
    
    private var posicionInicial = CGPoint.zero
    private var colorCirculo = UIColor.red {
        didSet {
            setNeedsDisplay()
        }
    }
    
    func inicializaVista () {
        self.backgroundColor = .clear
        //self.colorCirculo = color
    }
    
    override init (frame: CGRect){
        super.init(frame: frame)
        inicializaVista()
    }
    required init? (coder: NSCoder){
        super.init(coder: coder)
        inicializaVista()
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        let rectDeVista = self.bounds
        let path = UIBezierPath()
        
        /*
        path.move(to: rectDeVista.origin)
        path.addLine(to: CGPoint(x: rectDeVista.maxX, y: rectDeVista.maxY))
        path.move(to: CGPoint(x: rectDeVista.maxX, y: 0))
        path.addLine(to: CGPoint(x: 0, y: rectDeVista.maxY))
         */
        
        var centro = CGPoint.zero
        centro.x = rectDeVista.midX
        centro.y = rectDeVista.midY
        //var radio = min(rectDeVista.size.width, rectDeVista.size.height) / 2
        //otra forma de hacerlo
        //var radio = min(rectDeVista.midX, rectDeVista.midY) / 2
        
        
        //path.move(to: CGPoint(x: rectDeVista.maxX, y: rectDeVista.midY))
        //path.addArc(withCenter: centro, radius: radio, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        //path.fill()
        
        let radioMaximo = hypot(rectDeVista.midX, rectDeVista.midY)
        for radioActual in stride(from: Int(radioMaximo), to: 0, by: -10){
            path.move(to: CGPoint(x:centro.x+CGFloat(radioActual),y: centro.y))
            path.addArc(withCenter: centro, radius: CGFloat(radioActual), startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        }
        path.lineWidth = 5
        //UIColor.lightGray.setStroke()
        self.colorCirculo.setStroke()
        path.stroke()
        
        /*
        let texto = "MUEREEEE"
        let atributosTexto = [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 20)!]
        var rectTexto = CGRect.zero
        rectTexto.size = texto.size(withAttributes: atributosTexto)
        rectTexto.origin.x = centro.x - rectTexto.size.width/2.0
        rectTexto.origin.y = centro.y - centro.y/2.0
        texto.draw(in: rectTexto, withAttributes: atributosTexto)
         */
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print ("Me tocaron")
        let rojo = CGFloat.random(in: 0...1)
        let verde = CGFloat.random(in: 0...1)
        let azul = CGFloat.random(in: 0...1)
        
        let colorRandom = UIColor(red: rojo, green: verde, blue: azul, alpha: 1)
        print(colorRandom)
        self.colorCirculo = colorRandom
        posicionInicial = touches.first!.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print ("El dedo se movio")
        let toque = touches.first!
        let puntoToque = toque.location(in: self)
        self.frame.origin.x += puntoToque.x - posicionInicial.x
        self.frame.origin.y += puntoToque.y - posicionInicial.y
    }
    

}
