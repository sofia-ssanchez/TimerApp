import UIKit

protocol CustomTimePickerDelegate: AnyObject {
    func didSelectTime(_ selectedTime: TimeInterval, forType type: String)
}

class CustomTimePickerView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    weak var delegate: CustomTimePickerDelegate?
    var timeType: String? {
        didSet {
            print("CustomTimePickerView: timeType set to \(String(describing: timeType))")
        }
    }
    
    let pickerView = UIPickerView()
    let minutes = Array(0...59)
    let seconds = Array(0...59)
    
    var selectedTime: TimeInterval = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPickerView()
    }
    
    required init?(coder: NSCoder) {
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
        return 2 // Minutes and Seconds
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? minutes.count : seconds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return component == 0 ? "\(minutes[row]) m" : "\(seconds[row]) s"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedMinutes = minutes[pickerView.selectedRow(inComponent: 0)]
        let selectedSeconds = seconds[pickerView.selectedRow(inComponent: 1)]
        selectedTime = TimeInterval(selectedMinutes * 60 + selectedSeconds)
        
        // No delegate call here
        if let type = timeType {
            print("CustomTimePickerView: selected time \(selectedTime) for type \(type)")
            delegate?.didSelectTime(selectedTime, forType: type)
        }
    }
}
