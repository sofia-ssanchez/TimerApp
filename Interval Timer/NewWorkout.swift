import UIKit

protocol NewWorkoutDelegate: AnyObject {
    func didSaveWorkout( _ workout: ViewController.Workout)
}

class NewWorkout: UIViewController, UITextFieldDelegate, WarmUpTimePickerDelegate, NumberOfSetsPickerDelegate, HighIntensityTimePickerDelegate, LowIntensityTimePickerDelegate, NumCyclesPickerDelegate, BreakPickerDelegate, MediaAdderDelegate, UINavigationControllerDelegate {
    
    
    let timerName = UITextField()
    var name = "name"
    let typeLabel = UILabel()
    let typeControl = UISegmentedControl(items: ["Simple", "Complex"])
    let warmUpLabel = UILabel()
    let warmUpButton = UIButton()
    var warmUpTime: TimeInterval = 0
    let intervalCycleLabel = UILabel()
    let numSetsButton = UIButton()
    var sets = 1
    let highIntensityLabel = UILabel()
    let highIntensityButton = UIButton()
    var highIntensityTime: TimeInterval = 0
    let lowIntensityLabel = UILabel()
    let lowIntensityButton = UIButton()
    var lowIntensityTime: TimeInterval = 0
    let numCycleLabel = UILabel()
    let numCyclesButton = UIButton()
    var cycles = 1
    let breakLabel = UILabel()
    let breakButton = UIButton()
    var breakTime: TimeInterval = 0
    let picturesButton = UIButton()
    
    
    weak var delegate: NewWorkoutDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = colors.lightPink
        
        self.title = "New Workout"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveWorkoutDetails))
        
        timerName.textColor = .black
        timerName.placeholder = "Timer Name"
        timerName.backgroundColor = .white
        timerName.borderStyle = .roundedRect
        timerName.delegate = self
        
        let placeHolderAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.gray]
        timerName.attributedPlaceholder = NSAttributedString(string: "Timer Name", attributes: placeHolderAttributes)
        
        typeLabel.text = "Type"
        typeControl.selectedSegmentIndex = 0
        
        warmUpLabel.text = "Warm Up"
        
        intervalCycleLabel.text = "Number of Sets"
        
        highIntensityLabel.text = "High Intensity"
        lowIntensityLabel.text = "Low Intensity"
        
        numCycleLabel.text = "Number of Cycles"
        
        breakLabel.text = "Break Between Cycles"
        
        
        // grouping all the views so the step after doesnt need to be repeated for each element
        let views = [
            timerName, typeLabel, typeControl, warmUpLabel, warmUpButton, intervalCycleLabel, numSetsButton, highIntensityLabel, highIntensityButton, lowIntensityLabel, lowIntensityButton, numCycleLabel, numCyclesButton, breakLabel, breakButton, picturesButton
        ]
        
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false // turns off auto layout
            self.view.addSubview(view)
        }
        
        // WarmUp button setup
        warmUpButton.setTitle("00:00", for: .normal)
        warmUpButton.setTitleColor(.black, for: .normal)
        warmUpButton.backgroundColor = .white
        warmUpButton.addTarget(self, action: #selector(openWarmUpTimePicker), for: .touchUpInside)
        
        // Sets button setup
        numSetsButton.setTitle("1 Set", for: .normal)
        numSetsButton.setTitleColor(.black, for: .normal)
        numSetsButton.backgroundColor = .white
        numSetsButton.addTarget(self, action: #selector(openNumSetsPicker), for: .touchUpInside)
        
        // High Intensity Button setup
        highIntensityButton.setTitle("00:00", for: .normal)
        highIntensityButton.setTitleColor(.black, for: .normal)
        highIntensityButton.backgroundColor = .white
        highIntensityButton.addTarget(self, action: #selector(openHighIntensityPicker), for: .touchUpInside)
        
        // Low Intensity Button setup
        lowIntensityButton.setTitle("00:00", for: .normal)
        lowIntensityButton.setTitleColor(.black, for: .normal)
        lowIntensityButton.backgroundColor = .white
        lowIntensityButton.addTarget(self, action: #selector(openLowIntensityPicker), for: .touchUpInside)
        
        // Number of Cycles Button setup
        numCyclesButton.setTitle("1", for: .normal)
        numCyclesButton.setTitleColor(.black, for: .normal)
        numCyclesButton.backgroundColor = .white
        numCyclesButton.addTarget(self, action: #selector(openNumCyclesPicker), for: .touchUpInside)
        
        breakButton.setTitle("00:00", for: .normal)
        breakButton.setTitleColor(.black, for: .normal)
        breakButton.backgroundColor = .white
        breakButton.addTarget(self, action: #selector(openBreakPicker), for: .touchUpInside)
        
        picturesButton.setTitle("Add Media", for: .normal)
        picturesButton.setTitleColor(.black, for: .normal)
        picturesButton.backgroundColor = colors.darkPink
        picturesButton.addTarget(self, action: #selector(openMediaAdder), for: .touchUpInside)
        
        
        // Layout
        NSLayoutConstraint.activate([
            timerName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            timerName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            timerName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            timerName.heightAnchor.constraint(equalToConstant: 40),
            
            typeLabel.topAnchor.constraint(equalTo: timerName.bottomAnchor, constant: 20),
            typeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            typeControl.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 5),
            typeControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            typeControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            warmUpLabel.topAnchor.constraint(equalTo: typeControl.bottomAnchor, constant: 20),
            warmUpLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            warmUpButton.topAnchor.constraint(equalTo: warmUpLabel.bottomAnchor, constant: 5),
            warmUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            warmUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            intervalCycleLabel.topAnchor.constraint(equalTo: warmUpButton.bottomAnchor, constant: 20),
            intervalCycleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            numSetsButton.topAnchor.constraint(equalTo: intervalCycleLabel.bottomAnchor, constant: 5),
            numSetsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            numSetsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            highIntensityLabel.topAnchor.constraint(equalTo: numSetsButton.bottomAnchor, constant: 20),
            highIntensityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            highIntensityButton.topAnchor.constraint(equalTo: highIntensityLabel.bottomAnchor, constant: 5),
            highIntensityButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            highIntensityButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            lowIntensityLabel.topAnchor.constraint(equalTo: highIntensityButton.bottomAnchor, constant: 20),
            lowIntensityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lowIntensityButton.topAnchor.constraint(equalTo: lowIntensityLabel.bottomAnchor, constant: 5),
            lowIntensityButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lowIntensityButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            numCycleLabel.topAnchor.constraint(equalTo: lowIntensityButton.bottomAnchor, constant: 20),
            numCycleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            numCyclesButton.topAnchor.constraint(equalTo: numCycleLabel.bottomAnchor, constant: 5),
            numCyclesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            numCyclesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            breakLabel.topAnchor.constraint(equalTo: numCyclesButton.bottomAnchor, constant: 20),
            breakLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            breakButton.topAnchor.constraint(equalTo: breakLabel.bottomAnchor, constant: 5),
            breakButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            breakButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            picturesButton.topAnchor.constraint(equalTo: breakButton.bottomAnchor, constant: 30),
            picturesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            picturesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            picturesButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
  // To save the workout
    @objc func saveWorkoutDetails() {
        name = timerName.text ?? "New Workout"
        let newWorkout = ViewController.Workout(warmUpTime: warmUpTime, highIntensityTime: highIntensityTime, lowIntensityTime: lowIntensityTime, numberOfSets: sets, numberOfCycles: cycles, breakTime: breakTime,workoutName: name)
        // Notify delegate
        delegate?.didSaveWorkout(newWorkout)
        // Pop page and navigate back to previous view controller
        navigationController?.popViewController(animated: true)
    }
    
// To open the warm up time picker
    @objc func openWarmUpTimePicker() {
        let timePickerVC = WarmUpTimePickerViewController()
        timePickerVC.timeType = "Warm Up"
        timePickerVC.delegate = self // sets this view controller as the next view controllers deligate (i.e. saying pass the info back here once you get it)
        navigationController?.pushViewController(timePickerVC, animated: true) // pushes a new view controller onto navigation stack ( ? makes sure the view controller is part of a navigation controller stack)
    }
    
// Receiving the info from warm up time picker
    func didSelectWarmUpTime(_ time: TimeInterval, forType type: String) {
        if type == "Warm Up" {
            warmUpTime = time
            let minutes = Int(time) / 60
            let seconds = Int(time) % 60
            warmUpButton.setTitle(String(format: "%02d:%02d", minutes, seconds), for: .normal)
        }
    }
   // To open the number of sets picker
    @objc func openNumSetsPicker(){
        let numSetsPickerVC = NumberOfSetsPickerViewController()
        numSetsPickerVC.delegate = self // send info back to this page when you get it
        navigationController?.pushViewController(numSetsPickerVC, animated: true) //push new view
    }
    
  // Receiving info from Number of sets picker
    func didSelectNumSets(_ numSets: Int) {
        sets = numSets
        numSetsButton.setTitle("\(sets) Set" + (sets > 1 ? "s" : ""), for: .normal)
    }
                                      
    @objc func openHighIntensityPicker(){
        let HIPickerVC = HighIntensityTimePickerViewController()
        HIPickerVC.timeType = "High Intensity"
            HIPickerVC.delegate = self
            navigationController?.pushViewController(HIPickerVC, animated: true)
        }
    
    func didSelectHITime(time: TimeInterval, forType type: String) {
        if type == "High Intensity"{
            highIntensityTime = time
            let minutes = Int(time) / 60
            let seconds = Int(time) % 60
            highIntensityButton.setTitle(String(format: "%02d:%02d", minutes, seconds), for: .normal)
        }
    }
    
    @objc func openLowIntensityPicker(){
        let LIPickerVC = LowIntensityTimePickerViewController()
        LIPickerVC.timeType = "Low Intensity"
        LIPickerVC.delegate = self
        navigationController?.pushViewController(LIPickerVC, animated: true)
    }
    
    func didSelectLITime(time: TimeInterval, forType type: String) {
        if type == "Low Intensity"{
            lowIntensityTime = time
            let minutes = Int(time)/60
            let seconds = Int(time) % 60
            lowIntensityButton.setTitle(String(format: "%02d:%02d", minutes, seconds), for: .normal)
        }
    }
    
    @objc func openNumCyclesPicker(){
        let numCyclesPickerVC = NumCyclesPickerViewController()
        numCyclesPickerVC.delegate = self
        navigationController?.pushViewController(numCyclesPickerVC, animated: true)
    }
    
    func didSelectNumCycles( _ numCycles: Int){
        cycles = numCycles
        numCyclesButton.setTitle("\(cycles) Set" + (cycles > 1 ? "s" : ""), for: .normal)
    }
    
    @objc func openBreakPicker(){
        let breakPickerVC = BreakPickerViewController()
        breakPickerVC.timeType = "Break"
        breakPickerVC.delegate = self
        navigationController?.pushViewController(breakPickerVC, animated: true)
    }
    
    func didSelectBreakTime(time time: TimeInterval, forType type: String){
        if type == "Break" {
            breakTime = time
            let minutes = Int(time)/60
            let seconds = Int(time) % 60
            breakButton.setTitle(String(format: "%02d:%02d", minutes, seconds), for: .normal)
        }
    }
    
    @objc func openMediaAdder(){
        let mediaAdderVC = MediaAdderViewController()
        mediaAdderVC.numberOfSets = sets
        mediaAdderVC.delegate = self
        navigationController?.pushViewController(mediaAdderVC, animated: true)
    }
    
    func didAddMedia(_ media: [MediaType]) {
        
    }
    
}
        enum MediaType {
            case pictures(UIImage)
            case video(URL)
            case label(String)
        }
        var mediaArray: [MediaType] = []


