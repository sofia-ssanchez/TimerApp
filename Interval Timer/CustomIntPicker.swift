//
//  CustomIntPicker.swift
//  Interval Timer
//
//  Created by Sofia Sanchez on 2024-08-03.
//

import Foundation
import UIKit

protocol CustomIntPickerDelegate: AnyObject {
    func didSelectInt(_ selectedInt: Int, forType type: String)
}

class CustomIntPickerView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    weak var delegate: CustomIntPickerDelegate?
    var pickerType: String?
    let pickerView = UIPickerView()
    let integers: [Int]
    
    
    init(integers: [Int]) {
        self.integers = integers
        super.init(frame: .zero)
        setupPickerView()
    }
    
    required init?(coder: NSCoder) {
        self.integers = Array(1...100) // Default range if not provided
        super.init(coder: coder)
        setupPickerView()
    }
    
    private func setupPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.backgroundColor = colors.lightPink
        addSubview(pickerView)
        
        NSLayoutConstraint.activate([
            pickerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pickerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            pickerView.widthAnchor.constraint(equalTo: self.widthAnchor),
            pickerView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return integers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(integers[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedInt = integers[row]
        if let type = pickerType {
            delegate?.didSelectInt(selectedInt, forType: type)
        }
    }
}
