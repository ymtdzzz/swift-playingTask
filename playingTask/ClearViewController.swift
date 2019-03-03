//
//  ClearViewController.swift
//  playingTask
//
//  Created by 松田陽佑 on 2019/03/03.
//  Copyright © 2019 松田陽佑. All rights reserved.
//

import UIKit

class ClearViewController: UIViewController {

    @IBOutlet weak var clearTask: UILabel!
    var data:MyTodo = MyTodo()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        clearTask.text = data.todoTitle
    }
    
    @IBAction func tapClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
