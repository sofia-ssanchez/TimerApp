//
//  Timer.swift
//  Interval Timer
//
//  Created by Sofia Sanchez on 2024-08-28.
//

import Foundation
import UIKit

protocol TimerDelegate: AnyObject {
    
}

class Timer: UIViewController, UINavigationControllerDelegate {
    var workout: ViewController.Workout?
    weak var delegate: TimerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = colors.lightPink
        print(workout)
        
        if let warmUpTime = workout?.warmUpTime,
        let highIntensityTime = workout?.highIntensityTime,
        let lowIntensityTime = workout?.lowIntensityTime,
        let numberOfSets = workout?.numberOfSets,
        let numberOfCycles = workout?.numberOfCycles,
        let breakTime = workout?.breakTime
        {
            let numberOfIntervals = 1 + (numberOfSets * numberOfCycles * 2) + numberOfCycles
            print (numberOfIntervals)
        }
        
        
    }
}
