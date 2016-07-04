//
//  HelpVC.swift
//  multiWatchApp
//
//  Created by Master on 6/25/16.
//  Copyright © 2016 Master. All rights reserved.
//

import UIKit

class HelpVC: UIViewController {
    
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = true
        self.view.backgroundColor = UIColor(red: 175/255, green: 175/255, blue: 175/255, alpha: 1)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Instructions"
        print("Here is Instruction Page")
        // Do any additional setup after loading the view.
        let backImage = UIImage(named: "instructions@2x.png")
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        imgView.contentMode = .ScaleAspectFit
        imgView.image = backImage
        self.view.addSubview(imgView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension HelpVC{
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}