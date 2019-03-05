//
//  addTaskButton.swift
//  playingTask
//
//  Created by 松田陽佑 on 2019/03/06.
//  Copyright © 2019 松田陽佑. All rights reserved.
//

import UIKit

class addTaskButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.touchStartAnimation()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        self.touchEndAnimation()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.touchEndAnimation()
    }
    
    private func touchStartAnimation(){
        UIView.animate(withDuration: 0.1,
                                   delay: 0.0,
                                   options: UIView.AnimationOptions.curveEaseIn,
                                   animations: {() -> Void in
                                    self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95);
                                    self.alpha = 0.7
        },
                                   completion: nil
        )
    }
    private func touchEndAnimation(){
        UIView.animate(withDuration: 0.1,
                                   delay: 0.0,
                                   options: UIView.AnimationOptions.curveEaseIn,
                                   animations: {() -> Void in
                                    self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0);
                                    self.alpha = 1
        },
                                   completion: nil
        )
    }
}
