//
//  HabbitTypeVC.swift
//  HabitTraker
//
//  Created by Abduraxmon on 12/04/23.
//

import UIKit

protocol TypeDelegate {
    
    func colorOfView(color: UIColor, title: String)
}

class HabbitTypeVC: UIViewController {
    
    var colorPriority = [UIColor.systemRed,
                         UIColor.systemYellow,
                         UIColor.systemGreen,
                         UIColor.systemGray,
    ]
    
    var delegate: TypeDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func typePressed(_ sender: UIButton) {
        self.delegate!.colorOfView(color: colorPriority[sender.tag], title: sender.currentTitle!)
        dismiss(animated: true)
    }
    
}
