//
//  ButtonTableViewCell.swift
//  Task
//
//  Created by Michael Di Cesare on 9/25/19.
//  Copyright © 2019 Michael Di Cesare. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var taskButton: UIButton!
    
    @IBOutlet weak var taskNameLabel: UILabel!
    
    @IBAction func taskButtonPressed(_ sender: Any) {
        delegate?.buttonCellTapped(self)
    }
    weak var delegate: buttonTableViewCellDelegate?
    
    func updateButton(_ isComplete: Bool) {
        if isComplete {
            taskButton.setTitle("☑️", for: .normal)
        } else {
            taskButton.setTitle("⬜️", for: .normal)
        }
        
        
    }
}// end of class
extension ButtonTableViewCell {
    func update(withTask task: Task) {
        taskNameLabel.text = task.name
        updateButton(task.isComplete)
        
    }
}

protocol buttonTableViewCellDelegate: class {
    func buttonCellTapped(_ sender: ButtonTableViewCell)
    
    
}
