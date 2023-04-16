//
//  AddTaskVC.swift
//  HabitTraker
//
//  Created by Abduraxmon on 12/04/23.
//

import UIKit
import CoreData

class AddTaskVC: UIViewController, TypeDelegate {
    

    @IBOutlet weak var typeBtn: UIButton!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descTV: UITextView!
    @IBOutlet weak var addView: UIView!
    var priorityTitle = "Other"
    
    
    // Reference to managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // Data for collectionView
    var items: [Habit]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchHabbit()
        
        addView.layer.borderWidth = 1
        addView.layer.borderColor = UIColor.green.cgColor
    }
    
    func fetchHabbit() {
        // fetch the date from core data to diplay in collview
        do {
            self.items = try context.fetch(Habit.fetchRequest())
        } catch {
            
        }
        
    }
    
    @IBAction func priorityPressed(_ sender: Any) {
        let vc = HabbitTypeVC(nibName: "HabbitTypeVC", bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        vc.delegate = self
        present(vc, animated: true)
    }
    
    
    @IBAction func addPressed(_ sender: Any) {
        // create Habit object
        let newHabit = Habit(context: self.context)
        newHabit.title = titleTF.text
        newHabit.desc = descTV.text
        newHabit.type = priorityTitle
        
        // savedate
        do {
            try context.save()
        } catch {
            
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
        dismiss(animated: true)
    }
    
    func colorOfView(color: UIColor, title: String) {
        typeBtn.setTitle(title, for: .normal)
        typeBtn.backgroundColor = color
        priorityTitle = title
    }
    
    
}
