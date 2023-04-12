//
//  HabitCell.swift
//  HabitTraker
//
//  Created by Abduraxmon on 12/04/23.
//

import UIKit

class HabitCell: UITableViewCell {
    
    
    @IBOutlet weak var statusImg: UIImageView!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
