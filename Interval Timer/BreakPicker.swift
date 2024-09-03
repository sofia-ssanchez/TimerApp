//
//  BreakPicker.swift
//  Interval Timer
//
//  Created by Sofia Sanchez on 2024-09-03.
//

import Foundation
import UIKit

protocol BreakPickerDelegate: AnyObject{
    func didSelectBreakTime( time: TimeInterval, forType: String)
}

class BreakPickerViewController: UIViewController, CustomTimePickerDelegate{

    let customTimePicker = CustomTimePickerView()
    var timeType: String? {
        didSet{
            customTimePicker.timeType = timeType
        }
    }
    
    weak var delegate : BreakPickerDelegate?
    var selectedTime : TimeInterval = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = colors.lightPink
        title = "Select Time"
        
        customTimePicker.delegate = self
        customTimePicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customTimePicker)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTime))
        
        NSLayoutConstraint.activate([
            customTimePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customTimePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            customTimePicker.widthAnchor.constraint(equalTo: view.widthAnchor),
            customTimePicker.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    @objc func saveTime(){
        if let type = timeType{
            delegate?.didSelectBreakTime(time: selectedTime, forType: type)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func didSelectTime(_ time: TimeInterval, forType type: String) {
        if let type = timeType{
            selectedTime = time
        }
    }
}
