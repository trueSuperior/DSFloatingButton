//
//  ViewController.swift
//  DSFloatingButton
//
//  Created by Yuma Ikeda on 2018/12/19.
//  Copyright © 2018 UMA. All rights reserved.
//

import UIKit
import DSFloatingButton

class ViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Easy to create programmatically.
        let button = DSFloatingButton(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        button.backgroundColor = #colorLiteral(red: 1, green: 0.6453261971, blue: 0, alpha: 1)
        button.setTitle("Button", for: [])
        stackView.addArrangedSubview(button)
        
        
        // Set all custom attributes.
        let button2 = DSFloatingButton(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        button2.backgroundColor = .white
        button2.setTitle("Tap me!", for: [])
        // Define corner radius
        button2.cornerRadius = 5
        button2.useCornerRadius = true
        // Shadow
        button2.shadowColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        button2.shadowOpacity = 0.5
        button2.shadowOffset = CGSize(width: 0, height: 5)
        button2.shadowRadius = 10
        // Gradient
        button2.gradientStartColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        button2.gradientEndColor = #colorLiteral(red: 0.1084181443, green: 0.654640615, blue: 1, alpha: 1)
        button2.gradientStartPoint = CGPoint(x: 0, y: 0.5)
        button2.gradientEndPoint = CGPoint(x: 1, y: 0.5)
        stackView.addArrangedSubview(button2)
        // Tap event
        button2.tap = { _ in
            button2.setTitle("Cool!", for: [])
            button2.setTitleColor(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), for: [])
            button2.gradientLayer = nil
        }
    }


}

