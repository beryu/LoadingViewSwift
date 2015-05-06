//
//  ViewController.swift
//  LoadingViewSwift
//
//  Created by beryu on 2015/05/07.
//  Copyright (c) 2015年 blk. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    @IBOutlet weak var rotationSwitch:UISwitch?
    @IBOutlet weak var animationSwitch:UISwitch?
    @IBOutlet weak var messageSwitch:UISwitch?
    @IBOutlet weak var backgroundSwitch:UISwitch?
    @IBOutlet weak var buttonShow:UIButton?
    var hudView:LoadingView? = nil
    var isAnimated = true
    var message:String? = nil

    override func loadView() {
        self.hudView = LoadingView.sharedView()
        self.rotationSwitch?.setOn(self.isAnimated, animated:false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func rotationChanged(sender:AnyObject) {
        self.hudView?.isRotation = self.rotationSwitch!.on
    }

    @IBAction func animationChanged(sender:AnyObject) {
        self.isAnimated = self.animationSwitch!.on
    }

    @IBAction func messageChanged(sender:AnyObject) {
        self.message = self.messageSwitch!.on ? "Loading..." : nil
    }

    @IBAction func backgroundChanged(sender:AnyObject) {
        self.hudView?.backgroundView?.backgroundColor =
                self.backgroundSwitch!.on ? UIColor(red:0, green:0, blue:0, alpha:0.8) : UIColor.clearColor()
    }

    @IBAction func buttonShowWasTouched(sender:AnyObject) {
        self.hudView?.showInView(self.view, message:self.message, animated:self.isAnimated)

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64) (1 * NSEC_PER_SEC)), dispatch_get_main_queue(), {() in
            self.hudView?.dismissWithAnimated(self.isAnimated)
        });
    }
}

