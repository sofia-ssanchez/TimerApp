import UIKit

protocol WarmUpTimePickerDelegate: AnyObject {
    func didSelectWarmUpTime(_ time: TimeInterval, forType type: String)
}

class WarmUpTimePickerViewController: UIViewController, CustomTimePickerDelegate {
    let customTimePicker = CustomTimePickerView()
    var timeType: String? {
        didSet {
            customTimePicker.timeType = timeType
            print("WarmUpTimePickerViewController: timeType set to \(String(describing: timeType))")
        }
    }
    weak var delegate: WarmUpTimePickerDelegate?
    var selectedTime: TimeInterval = 0
    
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
    
    @objc func saveTime() {
        if let type = timeType {
            print("WarmUpTimePickerViewController: forwarding selected time \(selectedTime) for type \(type)")
            delegate?.didSelectWarmUpTime(selectedTime, forType: type)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func didSelectTime(_ time: TimeInterval, forType type: String) {
        if let type = timeType {
            print("WarmUpTimePickerViewController: storing selected time \(time) for type \(type)")
            selectedTime = time
        }
    }
}
