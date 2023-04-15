//
//  MainVC.swift
//  HabitTraker
//
//  Created by Abduraxmon on 12/04/23.
//

import UIKit
import CoreData

class MainVC: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    // Reference to managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // Data for collectionView
    var items: [Habit]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.refresh), name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Habit tracker"
        setUpTableView()
        fetchHabbit()
    }
    
    func fetchHabbit() {
        // fetch the date from core data to diplay in collview
        do {
            self.items = try context.fetch(Habit.fetchRequest())
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        } catch {
            
        }
    }
    
    func setUpTableView() {
        tableview.separatorStyle = .none
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UINib(nibName:"HabitCell" , bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    @objc func refresh() {
       fetchHabbit()
   }
    
    @IBAction func addHabbit(_ sender: Any) {
        let vc = AddTaskVC(nibName: "AddTaskVC" , bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HabitCell
        let item = items![indexPath.row]
        cell.titleLbl.text = item.title
        cell.descLbl.text = item.desc
        switch item.type {
        case "Other":
            cell.typeView.backgroundColor = .systemGray
        case "Study":
            cell.typeView.backgroundColor = UIColor.systemRed
        case "Finance":
            cell.typeView.backgroundColor = .systemYellow
        case "Health":
            cell.typeView.backgroundColor = .systemGreen
        default:
            cell.typeView.backgroundColor = .systemGray
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
        let vc = HabbitTracker(nibName: "HabbitTracker", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
