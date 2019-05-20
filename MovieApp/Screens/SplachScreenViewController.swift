//
//  SplachScreenViewController.swift
//  MovieApp
//
//  Created by JETS Mobile Lab - 5 on 5/19/19.
//  Copyright © 2019 iti. All rights reserved.
//

import UIKit

class SplachScreenViewController: UIViewController {
    @IBOutlet weak var appTitleLabel: UILabel!
    
    @IBOutlet weak var appIconImgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        appIconImgView.image=UIImage(named: "film-reel.png")
        UIView.animate(withDuration: 2.0, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: ({
            self.appTitleLabel.center.y=self.view.frame.height/2
            self.appIconImgView.center.y=self.view.frame.height/2
        })) { (Bool) in
           
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3){
                    self.performSegue(withIdentifier: "afterSplash", sender: nil)
                
            }
        }
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
