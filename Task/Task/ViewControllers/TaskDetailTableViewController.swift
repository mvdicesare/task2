//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by Michael Di Cesare on 9/25/19.
//  Copyright © 2019 Michael Di Cesare. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController, UITextViewDelegate, UITextFieldDelegate{

    var task: Task? {
        didSet {
            updateViews()
        }
    }
        
    var dueDate: Date?
    // MARK: - Outlets
    
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var dueTF: UITextField!
    @IBOutlet weak var notesTV: UITextView!
    @IBOutlet var dueDatePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTF.delegate = self
        dueTF.delegate = self
        notesTV.delegate = self
        dueTF.inputView = dueDatePicker
        let tap = UITapGestureRecognizer(target: self, action: #selector(resignKeyboard))
        self.view.addGestureRecognizer(tap)
        notesTV.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        notesTV.layer.borderWidth = 0.7
        notesTV.layer.cornerRadius = 0.5
    }
    @objc func resignKeyboard () {
        nameTF.resignFirstResponder()
        dueTF.resignFirstResponder()
        notesTV.resignFirstResponder()
    }
    
    func updateViews() {
        guard let task = task else {return}
            loadViewIfNeeded()
        nameTF.text = task.name
        dueTF.text = task.due?.stringValue()
        notesTV.text = task.notes
        
    }
    
    // MARK: - Actions
    
    @IBAction func dueDatePickerChanged(_ sender: UIDatePicker) {
        dueDate = sender.date
        dueTF.text = sender.date.stringValue()
    }
    
    
    @IBAction func savedButtonPressed(_ sender: Any) {
        guard let name = nameTF.text,
            !name.isEmpty else { return }
        
        
        if task == nil {
            guard let dueDate = dueDate else {return}
            TaskController.shared.add(taskWithName: name, notes: notesTV.text, due: dueDate)
        } else {
            guard let task = task else {return}
            TaskController.shared.update(task: task, name: name, notes: notesTV.text, due: dueDate)
        }
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func cancleButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
} // end of class
