//
//  MediaAdder.swift
//  Interval Timer
//
//  Created by Sofia Sanchez on 2024-09-10.
//

import Foundation
import UIKit

protocol MediaAdderDelegate: AnyObject {
    func didAddMedia(_ media: [MediaType])
}

class MediaAdderViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var numberOfSets: Int = 0;
    var mediaArray: [MediaType] = []
    weak var delegate: MediaAdderDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = colors.lightPink
        
        let exerciseStackView = UIStackView()
        exerciseStackView.axis = .vertical
        exerciseStackView.spacing = 20
        exerciseStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(exerciseStackView)
        
        
        for set in 1...numberOfSets {
            addExerciseView(to: exerciseStackView, forSet: set, exerciseType: "High Intensity")
            addExerciseView(to: exerciseStackView, forSet: set, exerciseType: "Low Intensity")
        }
        
        NSLayoutConstraint.activate([
            exerciseStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            exerciseStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            exerciseStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
    }
    
    func addExerciseView(to stackView: UIStackView, forSet set: Int, exerciseType: String){
        let exerciseView = UIView()
        exerciseView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(exerciseView)
        
        let exerciseLabel = UILabel()
        exerciseLabel.text = "\(exerciseType) \(set)"
        exerciseLabel.translatesAutoresizingMaskIntoConstraints = false
        exerciseView.addSubview(exerciseLabel)
        
        NSLayoutConstraint.activate([
            exerciseLabel.trailingAnchor.constraint(equalTo: exerciseView.trailingAnchor, constant: -30)
        
        ])
    }
}
