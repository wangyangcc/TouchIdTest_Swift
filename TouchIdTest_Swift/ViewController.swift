//
//  ViewController.swift
//  TouchIdTest_Swift
//
//  Created by wangyangyang on 14/12/18.
//  Copyright (c) 2014年 wang yangyang. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    //连接xib，!表示这个对象肯定有
    @IBOutlet weak var ui_checkTouchIdButton: UIButton!
    
    @IBOutlet weak var ui_beginTouchIdButton: UIButton!
    
    @IBOutlet weak var ui_textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func checkButtonTaped(sender: AnyObject) {
        
        //初始化一个 不可变 LAContext对象
        let context: LAContext! = LAContext()
        var errora: NSError?
        var msg: String?
        
        //查看设备是否支持指纹识别，只支持iOS8以上
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &errora)
        {
            self.ui_beginTouchIdButton.enabled = true
            msg = "touch id 可以使用"
        }
        else
        {
            self.ui_beginTouchIdButton.enabled = false
            msg = "touch id 不可以使用"
        }
        
        //打印提示信息
        self.printResult(msg!)
    }
    
    @IBAction func beginCheckTaped(sender: AnyObject) {
        
        let context: LAContext! = LAContext()
        var magT: String?
        
        context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: "touch id 验证") { (success, authenticationError) -> Void in
            if success
            {
                magT = "验证成功"
            }
            else
            {
                magT = "验证失败"
            }
            //打印提示信息
            self.printResult(magT!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func printResult(str: String) {
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.ui_textView.text = self.ui_textView.text.stringByAppendingString(str + "\n")
            //得到文本的总长度
            let textLength:Int = (self.ui_textView.text.utf16Count)
            self.ui_textView.scrollRectToVisible(CGRectMake(0, CGFloat(textLength), CGRectGetWidth(self.ui_textView.frame), CGRectGetHeight(self.ui_textView.frame)), animated: true)
        })

    }
}

