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
    private var timers: [TimerDetails] = []
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
    
    struct TimerDetails {
        let duration: TimeInterval
        let type: CustomTimerView.TimerState
    }
    
    private func fillTimeInterval(warmUpTime: TimeInterval, highInterval: TimeInterval, lowInterval: TimeInterval, numberOfSets: Int, numberOfCycles: Int, breakTime: TimeInterval) -> [TimerDetails] {
        var timers: [TimerDetails] = []
        timers.append(TimerDetails(duration:warmUpTime, type: .warmup))
        for _ in 1...numberOfCycles {
            for _ in 1...numberOfSets {
                timers.append(TimerDetails(duration: highInterval, type: .high))
                timers.append(TimerDetails(duration: lowInterval, type: .low))
            }
            timers.append(TimerDetails(duration:breakTime, type: .rest))
        }
        return timers
    }
    
    private func setupTimerView() {
        customTimerView.delegate = self
        customTimerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customTimerView)
        
        NSLayoutConstraint.activate([
            customTimerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customTimerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customTimerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 40),
            customTimerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6)
        ])
    }
    
    private func startNextTimer() {
        if currentTimerIndex < timers.count {            customTimerView.startTimer(with: timers[currentTimerIndex].duration, state: timers[currentTimerIndex].type)
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
