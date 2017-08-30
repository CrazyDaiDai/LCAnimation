//
//  ViewController.swift
//  LCAnimation
//
//  Created by 呆仔～林枫 on 2017/8/29.
//  Copyright © 2017年 Lin_Crazy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let screen_w = UIScreen.main.bounds.width
    let screen_h = UIScreen.main.bounds.height
    let space : CGFloat = 20.0
    let btn_h : CGFloat = 44
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.addSublayer(centerLayer)
        setBtn()
    }

/// lazy
    lazy var centerLayer : CALayer = {
    
        let layer = CALayer()
        layer.bounds = .init(x: 0, y: 0, width: 230, height: 150)
        layer.position = self.view.center
        layer.backgroundColor = UIColor.orange.cgColor
        return layer
    }()

    
/// btn
    func setBtn() {
        
        let btn_w = (screen_w - space * 5) * 0.25
        
        let titleArr = ["rotation","rotation.x","rotation.y","rotation.z","scale","translation","size"]
        for (index,value) in titleArr.enumerated() {
            let i = CGFloat(index % 4)
            let frame = CGRect.init(x: space + space * i + btn_w * i, y: screen_h - btn_h * CGFloat(index / 4 + 1) - space * CGFloat(index / 4 + 1), width: btn_w, height: btn_h)
            createBtn(title: value, frame: frame)
        }
    }
    
    func createBtn(title : String,frame : CGRect) {
        
        let btn = UIButton.init(frame: frame)
        btn.setTitle(title, for: .normal)
        btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
        view.addSubview(btn)
        btn.backgroundColor = UIColor.randomColor
    }
    
    func btnClick(sender : UIButton) {

        if (sender.titleLabel?.text?.range(of: "rotation")) != nil {
            /// rotation
            centerLayer.add(layerAnimation(keyPath: "transform." + sender.titleLabel!.text!, toValue: CGFloat.pi * 2), forKey: "")
        } else if ((sender.titleLabel?.text?.range(of: "translation")) != nil) {
                /// translation
                centerLayer.add(layerAnimation(keyPath: "transform." + sender.titleLabel!.text!, toValue: 50.0), forKey: "")
        } else {
            if ((sender.titleLabel?.text?.range(of: "size")) != nil) {
                /// size
                centerLayer.add(layerAnimation(keyPath: "bounds.size", toValue: CGSize.init(width: 80, height: 50)), forKey: "")
            } else {
                /// scale
                centerLayer.add(layerAnimation(keyPath: "transform." + sender.titleLabel!.text!, toValue: 0.5), forKey: "")
            }
        }

    }

    func layerAnimation(keyPath : String,toValue : Any) -> CABasicAnimation {
        
        let basecAni = CABasicAnimation.init(keyPath: keyPath)
        basecAni.toValue = toValue
        basecAni.duration = 1
        basecAni.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        return basecAni
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension UIColor {
    /// 随机色
    class var randomColor: UIColor {
        get {
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}
