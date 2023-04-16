//
//  HabbitTracker.swift
//  HabitTraker
//
//  Created by Abduraxmon on 12/04/23.
//

import UIKit
import CoreData

class HabbitTracker: UIViewController {
    
    let date = Date()
    let calendar = Calendar.current
    var tableIndex = 0
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Reference to managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // Data for collectionView
    var items: [Habit]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .gray
        title = "Habit calendar"
        // Get items from core data
        fetchHabbit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        check()
        
    }
    
    func check() {
        guard let item = items?[tableIndex].days else {
            return
        }
        
        if item.count != 0 {
            let count = Int(item.last!)
            
            for day in 0...count {
                if item.contains(Int64(day)) {
                    markedDay(day: day, done: true)
                } else {
                    markedDay(day: day, done: false)
                }
            }
        }
    }
    
    func fetchHabbit() {
        // fetch the date from core data to diplay in collview
        do {
            self.items = try context.fetch(Habit.fetchRequest())
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        } catch {
            
        }
        
    }
    
    
    func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register( UICollectionViewCell.self, forCellWithReuseIdentifier: "default")
    }
    
    @IBAction func donePressed(_ sender: Any) {
        let day = Int64(calendar.component(.day, from: date))
        let item = items![tableIndex]
        var index = 0
        
        if item.startingDay == 0 {
            item.startingDay = day
            item.days.append(0)
            markedDay(day: 0, done: true)
        } else if item.startingDay < day, (item.startingDay + item.days.last!) != day {
            index = Int(day - item.startingDay)
            markedDay(day: index, done: true)
            item.days.append(Int64(index))
        } else if item.startingDay > day, item.days.last != day {
            index = Int(day - item.startingDay) + 30
            markedDay(day: index, done: true)
            item.days.append(Int64(index))
        } else if item.startingDay == day , item.days.count != 1 {
            
        }
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        
        check()
    }
    
    func markedDay(day: Int, done: Bool) {
        var index = day
        for i in 0...9 {
            
            for j in 0...8 {
                
                if index == 0 {
                    let cell = collectionView.cellForItem(at: IndexPath(row: j, section: i))
                    if done {
                        cell?.backgroundColor = .systemGreen
                    } else {
                        cell?.backgroundColor = .systemPink
                    }
                } else if index < 0 {
                    return
                }
                
                index -= 1
                
            }
        }
    }
    
}

extension HabbitTracker: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath)
        cell.backgroundColor = .systemGray5
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        
        return cell
    }
}

extension HabbitTracker: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width / 9
        let height = width
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}
