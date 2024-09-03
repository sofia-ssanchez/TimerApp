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
        label.font = UIFont.systemFont(ofSize: 40)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addSubview(timerLabel)
        
        // Center the label in the view
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func startTimer(with duration: TimeInterval) {
        timeRemaining = duration
        updateLabel()
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
    
    deinit {
        timer?.invalidate()
    }
}
