//
//  HabbitTracker.swift
//  HabitTraker
//
//  Created by Abduraxmon on 12/04/23.
//

import UIKit

class HabbitTracker: UIViewController {
    
    let date = Date()
    let calendar = Calendar.current
    var firstDay = 0
    var day = 0
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .gray
        title = "Habit calendar"
        day = UserDefaults.standard.integer(forKey: "day")
    }
    
    func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register( UICollectionViewCell.self, forCellWithReuseIdentifier: "default")
    }
    
    func setCellWidthHeight() {
        let width = collectionView.frame.size.width / 9
        let height = collectionView.frame.size.height / 10
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    
    @IBAction func donePressed(_ sender: Any) {
        
        if day == 0 {
            UserDefaults.standard.set(calendar.component(.day, from: date), forKey: "startedDay")
            let targetCell = collectionView.cellForItem(at: IndexPath(row: 0, section: 0))
            targetCell?.backgroundColor = .systemGreen
            //To-Do adda days to CoreData
        } else {
            var index = day - UserDefaults.standard.integer(forKey: "startedDay")
            for i in 0...9 {
                
                for j in 0...8 {
                    
                    if index == 0 {
                        print(i,j)
                        let cell = collectionView.cellForItem(at: IndexPath(row: j, section: i))
                        cell?.backgroundColor = .systemGreen
                    } else if index < 0 {
                        return
                    }
                    index -= 1
                    
                }
            }
        }
        if day != calendar.component(.day, from: date) {
            day = calendar.component(.day, from: date)
            UserDefaults.standard.set(day, forKey: "day")
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
