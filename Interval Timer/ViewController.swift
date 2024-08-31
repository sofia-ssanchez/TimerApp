//
//  ViewController.swift
//  Interval Timer
//
//  Created by Sofia Sanchez on 2024-07-02.
//

import UIKit

protocol createWorkoutdelegate: AnyObject {
    func didSaveWorkout( _ workout: ViewController.Workout)
}

class ViewController: UIViewController, NewWorkoutDelegate, TimerDelegate {
    
    struct Workout {
        var id: UUID // unique ID for each workout, in case they have same name
        var warmUpTime: TimeInterval
        var highIntensityTime: TimeInterval
        var lowIntensityTime: TimeInterval
        var numberOfSets: Int
        var numberOfCycles: Int
        var workoutName: String

        init(warmUpTime: TimeInterval, highIntensityTime: TimeInterval, lowIntensityTime: TimeInterval, numberOfSets: Int, numberOfCycles: Int, workoutName: String) {
            self.id = UUID()
            self.warmUpTime = warmUpTime
            self.highIntensityTime = highIntensityTime
            self.lowIntensityTime = lowIntensityTime
            self.numberOfSets = numberOfSets
            self.numberOfCycles = numberOfCycles
            self.workoutName = workoutName
        }
    }
    
   
    
    var workouts: [Workout] = []
    var workoutStackView: UIStackView!
    var workoutScrollView: UIScrollView!
    
    let plusButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = colors.lightPink
        setupScrollView()
        setupStackView()
        addButton()
    }
    
    func setupScrollView(){
        workoutScrollView = UIScrollView()
        workoutScrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(workoutScrollView)
        
        NSLayoutConstraint.activate([
            workoutScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            workoutScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            workoutScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            workoutScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupStackView(){
        workoutStackView = UIStackView()
        workoutStackView.axis = .vertical
        workoutStackView.alignment = .fill
        workoutStackView.distribution = .equalSpacing
        workoutStackView.spacing = 10
        workoutStackView.translatesAutoresizingMaskIntoConstraints = false
        workoutScrollView.addSubview(workoutStackView)
        
        NSLayoutConstraint.activate([
            workoutStackView.topAnchor.constraint(equalTo: workoutScrollView.topAnchor),
            workoutStackView.leadingAnchor.constraint(equalTo: workoutScrollView.leadingAnchor, constant: 20),
            workoutStackView.trailingAnchor.constraint(equalTo: workoutScrollView.trailingAnchor, constant: -20),
            workoutStackView.bottomAnchor.constraint(equalTo: workoutScrollView.bottomAnchor),
            workoutStackView.widthAnchor.constraint(equalTo: workoutScrollView.widthAnchor, constant: -40)
        ])
    }
    
    
    
    func addButton(){
        plusButton.setTitle("+", for: .normal)
        plusButton.backgroundColor = colors.darkPink
        plusButton.addTarget(self, action:#selector(addButtonClicked) , for: .touchUpInside)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(plusButton)
        
        NSLayoutConstraint.activate([
            plusButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            plusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            plusButton.heightAnchor.constraint(equalToConstant: 50),
            plusButton.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        // to make button a circle
        plusButton.layer.cornerRadius = 25 // half the height/width
        plusButton.clipsToBounds = true
    }
    
    
    @objc func addButtonClicked(){
        let newWorkout = NewWorkout()
        newWorkout.delegate = self
        navigationController?.pushViewController(newWorkout, animated: true)
    }
    
    func didSaveWorkout(_ workout: Workout) {
        workouts.append(workout)
        let workoutButton = UIButton(type: .system)
        workoutButton.setTitle(workout.workoutName, for: .normal)
        workoutButton.translatesAutoresizingMaskIntoConstraints = false
        workoutButton.addTarget(self, action: #selector(workoutButtonClicked(_:)), for: .touchUpInside)
        
        workoutButton.tag = workouts.count - 1
                
        // Style the button
        workoutButton.contentHorizontalAlignment = .center
        workoutButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        workoutButton.setTitleColor(colors.lightPink, for: .normal)
        workoutButton.backgroundColor = .white
        workoutButton.layer.cornerRadius = 8
        
        workoutStackView.addArrangedSubview(workoutButton)
        
        NSLayoutConstraint.activate([
            workoutButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func workoutButtonClicked(_ sender: UIButton){
        let workoutIndex = sender.tag
        let selectedWorkout = workouts[workoutIndex]
        let timer = Timer()
        timer.delegate = self
        timer.workout = selectedWorkout
        navigationController?.pushViewController(timer, animated: true)
    }
    
}




