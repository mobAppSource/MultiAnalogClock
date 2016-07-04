//
//  AlarmMainVC.swift
//  New_MultiWatchApp
//
//  Created by Master on 6/29/16.
//  Copyright © 2016 Master. All rights reserved.
//

import UIKit

class AlarmMainVC: UIViewController {

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Alarm"
        self.view.backgroundColor = UIColor.whiteColor()
        let saveBtn = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: #selector(AlarmMainVC.saveBtnTapped(_:)))
        self.navigationItem.rightBarButtonItem = saveBtn
        
    }
    func saveBtnTapped(sender: UIBarButtonItem)
    {
        print("Tapped save btn")
    }
    
    var alarmTimePicker: UIDatePicker!

}
extension AlarmMainVC{
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}