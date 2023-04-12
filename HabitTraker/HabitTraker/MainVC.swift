//
//  MainVC.swift
//  HabitTraker
//
//  Created by Abduraxmon on 12/04/23.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Habit tracker"
        setUpTableView()
    }
    
    func setUpTableView() {
        tableview.separatorStyle = .none
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UINib(nibName:"HabitCell" , bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    @IBAction func addHabbit(_ sender: Any) {
        let vc = AddTaskVC(nibName: "AddTaskVC" , bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
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
