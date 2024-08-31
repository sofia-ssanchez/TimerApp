import UIKit

protocol NumberOfSetsPickerDelegate: AnyObject {
    func didSelectNumSets(_ numSets: Int)
}

class NumberOfSetsPickerViewController: UIViewController, CustomIntPickerDelegate {
    let customIntPicker = CustomIntPickerView(integers: Array(1...100))
    
    weak var delegate: NumberOfSetsPickerDelegate?
    var selectedNumSets: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = colors.lightPink
        title = "Select Number of Sets"
        
        customIntPicker.delegate = self // send the info back here
        customIntPicker.pickerType = "Sets"
        customIntPicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customIntPicker)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveInt))
        
        NSLayoutConstraint.activate([
            customIntPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customIntPicker.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            customIntPicker.widthAnchor.constraint(equalTo: view.widthAnchor),
            customIntPicker.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc func saveInt() {
        delegate?.didSelectNumSets(selectedNumSets)
        navigationController?.popViewController(animated: true)
    }
    
    func didSelectInt(_ selectedInt: Int, forType type: String) {
        selectedNumSets = selectedInt
    }
}
