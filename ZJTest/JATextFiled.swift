//
//  JATextFiled.swift
//  ZJTest
//
//  Created by 庄记 on 2017/1/9.
//  Copyright © 2017年 庄记. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func animateMoveTextFiled(time:TimeInterval , rate:Int , distance: CGFloat, direction:Direction) {
        switch direction {
        case .hori:
            let x = self.myFrameX
            UIView.animateKeyframes(withDuration: time, delay: 0, options: UIViewKeyframeAnimationOptions(), animations: {
                for i in 0...rate {
                    UIView.addKeyframe(withRelativeStartTime: time/TimeInterval(rate)*TimeInterval(i), relativeDuration: time/TimeInterval(rate), animations: {
                        if i == rate {self.myFrameX = x} else {
                            self.myFrameX = (i%2 == 0) ? x + distance : x - distance
                        }
                    })
                }
            })
        case .vert:
            let y = self.myFrameY
            UIView.animateKeyframes(withDuration: time, delay: 0, options: UIViewKeyframeAnimationOptions(), animations: {
                for i in 0...rate {
                    UIView.addKeyframe(withRelativeStartTime: time/TimeInterval(rate)*TimeInterval(i), relativeDuration: time/TimeInterval(rate), animations: {
                        if i == rate {
                            self.myFrameY = y
                        } else {
                            self.myFrameY = (i%2 == 0) ? y + distance : y - distance
                        }
                    })
                }
            })
        }
    }
}
