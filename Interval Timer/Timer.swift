//
//  Timer.swift
//  Interval Timer
//
//  Created by Sofia Sanchez on 2024-08-28.
//

import Foundation
import UIKit

import Foundation
import UIKit

protocol TimerDelegate: AnyObject {
    // Define any delegate methods you may need here
}

class TimerViewController: UIViewController, UINavigationControllerDelegate, CustomTimerViewDelegate {

    var workout: ViewController.Workout?
    weak var delegate: TimerDelegate?
    private let customTimerView = CustomTimerView()
    private var timers: [TimeInterval] = []
    private var currentTimerIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = colors.lightPink
        
        if let warmUpTime = workout?.warmUpTime,
           let highIntensityTime = workout?.highIntensityTime,
           let lowIntensityTime = workout?.lowIntensityTime,
           let numberOfSets = workout?.numberOfSets,
           let numberOfCycles = workout?.numberOfCycles,
           let breakTime = workout?.breakTime {
            
            timers = fillTimeInterval(warmUpTime: warmUpTime, highInterval: highIntensityTime, lowInterval: lowIntensityTime, numberOfSets: numberOfSets, numberOfCycles: numberOfCycles, breakTime: breakTime)
        }
        
        setupTimerView()
        startNextTimer()
    }
    
    private func fillTimeInterval(warmUpTime: TimeInterval, highInterval: TimeInterval, lowInterval: TimeInterval, numberOfSets: Int, numberOfCycles: Int, breakTime: TimeInterval) -> [TimeInterval] {
        var timers: [TimeInterval] = []
        timers.append(warmUpTime)
        for _ in 1...numberOfCycles {
            for _ in 1...numberOfSets {
                timers.append(highInterval)
                timers.append(lowInterval)
            }
            timers.append(breakTime)
        }
        return timers
    }
    
    private func setupTimerView() {
        customTimerView.delegate = self
        customTimerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customTimerView)
        
        NSLayoutConstraint.activate([
            customTimerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customTimerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            customTimerView.widthAnchor.constraint(equalToConstant: 200),
            customTimerView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func startNextTimer() {
        if currentTimerIndex < timers.count {
            customTimerView.startTimer(with: timers[currentTimerIndex])
            currentTimerIndex += 1
        } else {
            print("All timers completed")
        }
    }
    
    // MARK: - CustomTimerViewDelegate
    
    func didCompleteTimer(complete: Bool) {
        if complete {
            startNextTimer()  
        }
    }
}
