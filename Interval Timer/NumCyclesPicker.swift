//
//  NumCyclesPicker.swift
//  Interval Timer
//
//  Created by Sofia Sanchez on 2024-08-22.
//

import Foundation
import UIKit

protocol NumCyclesPickerDelegate: AnyObject{
    func didSelectNumCycles( _ numCycles: Int)
}

class NumCyclesPickerViewController: UIViewController, CustomIntPickerDelegate {
    
    let customIntPicker = CustomIntPickerView(integers: Array(1...100))
    weak var delegate : NumCyclesPickerDelegate?
    var selectedNumber: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = colors.lightPink
        title = "Select Number of Cycles"
        customIntPicker.delegate = self
        customIntPicker.pickerType = "Cycles"
        customIntPicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customIntPicker)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveInt))
        
        NSLayoutConstraint.activate([
            customIntPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customIntPicker.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            customIntPicker.widthAnchor.constraint(equalTo: view.widthAnchor),
            customIntPicker.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc func saveInt(){
        delegate?.didSelectNumCycles(selectedNumber)
        navigationController?.popViewController(animated: true)
    }
    
    func didSelectInt(_ selectedInt: Int, forType type: String) {
        selectedNumber = selectedInt
    }
    
}
