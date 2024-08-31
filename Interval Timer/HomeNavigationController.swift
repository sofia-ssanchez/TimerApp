//
//  HomeNavigationController.swift
//  Interval Timer
//
//  Created by Sofia Sanchez on 2024-07-02.
//

import UIKit

class HomeNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let viewController = ViewController()
        self.setViewControllers([viewController], animated: true)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
