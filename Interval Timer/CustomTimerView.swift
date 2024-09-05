//
//  CustomTimerView.swift
//  Interval Timer
//
//  Created by Sofia Sanchez on 2024-09-03.
//

import Foundation
import UIKit

protocol CustomTimerViewDelegate: AnyObject {
    func didCompleteTimer(complete: Bool)
}

class CustomTimerView: UIView {

    weak var delegate: CustomTimerViewDelegate?
    
    private var timer: Timer?
    private var timeRemaining: TimeInterval = 0
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 70)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bottomColoredView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    enum TimerState {
        case warmup
        case high
        case low
        case rest
        
        var displayName: String {
                 switch self {
                 case .warmup: return "Warm Up"
                 case .high: return "High Intensity"
                 case .low: return "Low Intensity"
                 case .rest: return "Break"
                 }
             }
        
        var timerColor: UIColor {
            switch self {
            case .warmup: return colors.lightYellow
            case .high: return colors.lightRed
            case .low: return colors.lightGreen
            case .rest: return colors.lightBlue
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addSubview(bottomColoredView)
        bottomColoredView.addSubview(timerLabel)
        bottomColoredView.addSubview(typeLabel)

        
        NSLayoutConstraint.activate([
            bottomColoredView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomColoredView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomColoredView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            bottomColoredView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.6) // 40% of screen height
        ])
        
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: bottomColoredView.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: bottomColoredView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
                 typeLabel.centerXAnchor.constraint(equalTo: bottomColoredView.centerXAnchor),
                 typeLabel.bottomAnchor.constraint(equalTo: timerLabel.topAnchor, constant: -10)
             ])
    }
    
    func startTimer(with duration: TimeInterval, state: TimerState) {
        timeRemaining = duration
        updateLabel()
        updateBackgroundColor(for: state)
        typeLabel.text = state.displayName
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        if timeRemaining > 0 {
            timeRemaining -= 1
            updateLabel()
        } else {
            timer?.invalidate()
            delegate?.didCompleteTimer(complete: true)
        }
    }
    
    private func updateLabel() {
        let minutes = Int(timeRemaining) / 60
        let seconds = Int(timeRemaining) % 60
        timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func updateBackgroundColor(for state: TimerState) {
        switch state {
        case .warmup:
            bottomColoredView.backgroundColor = colors.lightYellow
        case .high:
            bottomColoredView.backgroundColor = colors.lightRed
        case .low:
            bottomColoredView.backgroundColor = colors.lightGreen
        case .rest:
            bottomColoredView.backgroundColor = colors.lightBlue
        }
    }

    deinit {
        timer?.invalidate()
    }
}
