//
//  AddTaskVC.swift
//  HabitTraker
//
//  Created by Abduraxmon on 12/04/23.
//

import UIKit

class AddTaskVC: UIViewController, TypeDelegate {
    

    @IBOutlet weak var typeBtn: UIButton!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descTV: UITextView!
    @IBOutlet weak var addView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView.layer.borderWidth = 1
        addView.layer.borderColor = UIColor.green.cgColor
    }
    
    @IBAction func priorityPressed(_ sender: Any) {
        let vc = HabbitTypeVC(nibName: "HabbitTypeVC", bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        vc.delegate = self
        present(vc, animated: true)
    }
    
    
    @IBAction func addPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func colorOfView(color: UIColor, title: String) {
        typeBtn.setTitle(title, for: .normal)
        typeBtn.backgroundColor = color
    }
    
    
}
