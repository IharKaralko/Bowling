//
//  DemoViewController.swift
//  Bowling
//
//  Created by Ihar_Karalko on 02.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit

class DemoViewController: UIViewController {

    @IBOutlet weak var greenView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let custom = CustomCalloutView()
//        greenView.addSubview(custom)
        
       // custom.translatesAutoresizingMaskIntoConstraints = false
//         custom.frame = CGRect(x: 0, y: 0, width: 300, height: 160)
//        custom.layer.cornerRadius = 35
//        custom.clipsToBounds = true
        //        NSLayoutConstraint.activate([
//            custom.bottomAnchor.constraint(equalTo:  greenView.bottomAnchor),
//            custom.topAnchor.constraint(equalTo:  greenView.topAnchor),
//            custom.leadingAnchor.constraint(equalTo: greenView.leadingAnchor),
//            custom.trailingAnchor.constraint(equalTo: greenView.trailingAnchor)
//            ])
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let width: CGFloat = 40.0
        let height: CGFloat = 20.0
        
        let demoView = CalloutLegView(frame: CGRect(x: self.view.frame.size.width/2 - width/2,
                                              y: self.view.frame.size.height/2 - height/2,
                                              width: width,
                                              height: height))
        
        self.view.addSubview(demoView)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
