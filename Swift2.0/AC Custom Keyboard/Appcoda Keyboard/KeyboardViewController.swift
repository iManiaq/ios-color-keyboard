

import UIKit

class KeyboardViewController: UIInputViewController {
    
    var capsLockOn = true
    
    @IBOutlet weak var row1: UIView!
    @IBOutlet weak var row2: UIView!
    @IBOutlet weak var row3: UIView!
    @IBOutlet weak var row4: UIView!
    
    @IBOutlet weak var charSet1: UIView!
    @IBOutlet weak var charSet2: UIView!
    
    @IBOutlet weak var charSet2HeightConstaint: NSLayoutConstraint!
    @IBOutlet weak var charSet1HeightContsraint: NSLayoutConstraint!
    
    var heightConstraint: NSLayoutConstraint?
    
    var blurEffectView : UIVisualEffectView?
    
    @IBOutlet weak var elementButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "KeyboardView", bundle: nil)
        let objects = nib.instantiateWithOwner(self, options: nil)
        view = objects[0] as! UIView;
        charSet2.hidden = true
        
   
        for i in 101..<153
        {
            let view = self.view.viewWithTag(i)
           view?.layer.cornerRadius = 5.0
        }
        
        self.view.backgroundColor = UIColor.yellowColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    override func viewDidAppear(animated: Bool) {
        let desiredHeight:CGFloat = 263.0 
        let heightConstraint = NSLayoutConstraint(item: view,  attribute:NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: desiredHeight)
        
        view.addConstraint(heightConstraint)
        
        
        var button = self.view.viewWithTag(101)
        button?.layer.cornerRadius = 5.0
        
         button = self.view.viewWithTag(102)
        button?.layer.cornerRadius = 5.0
    }
    
    @IBAction func nextKeyboardPressed(button: UIButton) {
        advanceToNextInputMode()
    }
    
    @IBAction func capsLockPressed(button: UIButton) {
        capsLockOn = !capsLockOn
        
        changeCaps(row1)
        changeCaps(row2)
        changeCaps(row3)
        changeCaps(row4)
    }
    
    @IBAction func keyPressed(button: UIButton) {
        let string = button.titleLabel!.text
        (textDocumentProxy as UIKeyInput).insertText("\(string!)")
        
        UIView.animateWithDuration(0.2, animations: {
            button.transform = CGAffineTransformScale(CGAffineTransformIdentity, 2.0, 2.0)
            }, completion: {(_) -> Void in
                button.transform =
                    CGAffineTransformScale(CGAffineTransformIdentity, 1, 1)
        })
    }
    
    @IBAction func backSpacePressed(button: UIButton) {
        (textDocumentProxy as UIKeyInput).deleteBackward()
    }
    
    @IBAction func spacePressed(button: UIButton) {
        (textDocumentProxy as UIKeyInput).insertText(" ")
    }
    
    @IBAction func returnPressed(button: UIButton) {
        (textDocumentProxy as UIKeyInput).insertText("\n")
    }
    
    @IBAction func charSetPressed(button: UIButton) {
        if button.titleLabel!.text == "=+-" {
            charSet1.hidden = true
            charSet2.hidden = false
            button.setTitle("#%*", forState: .Normal)
        } else if button.titleLabel!.text == "#%*" {
            charSet1.hidden = false
            charSet2.hidden = true
            button.setTitle("=+-", forState: .Normal)
        }
    }
    
    func changeCaps(containerView: UIView) {
        for view in containerView.subviews {
            if let button = view as? UIButton {
                let buttonTitle = button.titleLabel!.text
                if capsLockOn {
                    let text = buttonTitle!.uppercaseString
                    button.setTitle("\(text)", forState: .Normal)
                } else {
                    let text = buttonTitle!.lowercaseString
                    button.setTitle("\(text)", forState: .Normal)
                }
            }
        }
    }
    
    //Tool bar
    @IBAction func morePressedAction(sender: AnyObject) {
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        
        if  self.blurEffectView == nil {
            
             self.blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView!.frame = self.view.bounds
            blurEffectView!.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            blurEffectView!.tag = 301
            
            
            let rect = CGRectMake(20, 20, self.view.frame.width - 40, self.view.frame.height - 40)
            let view:UIView = UIView(frame:rect)
            
            blurEffectView!.addSubview(view)
            
            let button1   = UIButton(type: UIButtonType.System)
            button1.frame = CGRectMake(30, 30, 70, 40)
            self.configureButtonWith(button1, color: UIColor.greenColor(), title: "Green", tagNumber: 701)
            blurEffectView!.addSubview(button1)
            
            let button2   = UIButton(type: UIButtonType.System)
            button2.frame = CGRectMake(120, 30, 70, 40)
            self.configureButtonWith(button2, color: UIColor.yellowColor(), title: "Yellow", tagNumber: 702)
            blurEffectView!.addSubview(button2)
            
            let button3   = UIButton(type: UIButtonType.System)
            button3.frame = CGRectMake(210, 30, 70, 40)
            self.configureButtonWith(button3, color: UIColor.orangeColor(), title: "Orange", tagNumber: 703)
            blurEffectView!.addSubview(button3)
            
            let button4   = UIButton(type: UIButtonType.System)
            button4.frame = CGRectMake(30, 90, 70, 40)
            self.configureButtonWith(button4, color: UIColor.redColor(), title: "Red", tagNumber: 704)
            blurEffectView!.addSubview(button4)
            
            let button5   = UIButton(type: UIButtonType.System)
            button5.frame = CGRectMake(120, 90, 70, 40)
            self.configureButtonWith(button5, color: UIColor(red: 60/255.0, green:  239/255.0, blue:  239/255.0, alpha: 1.0), title: "Blue", tagNumber: 705)
            blurEffectView!.addSubview(button5)
            
            let button6   = UIButton(type: UIButtonType.System)
            button6.frame = CGRectMake(210, 90, 70, 40)
            self.configureButtonWith(button6, color: UIColor(red: 255.0/255.0, green:  0/255.0, blue:  255.0/255.0, alpha: 0.7), title: "Pink", tagNumber: 706)
            blurEffectView!.addSubview(button6)

        }
        
        self.view.addSubview(self.blurEffectView!)

        
    }
    
    func configureButtonWith(button : UIButton ,color:UIColor , title : String, tagNumber:Int){
        
        button.backgroundColor = color
        button.setTitle(title, forState: UIControlState.Normal)
        button.addTarget(self, action: "tappedButton:", forControlEvents: UIControlEvents.TouchUpInside)
        button.layer.cornerRadius = 5.0
        button.tag = tagNumber

    }
    
    func tappedButton(sender: UIButton!){
        
        if sender.tag == 701 {
            self.view.backgroundColor = UIColor.greenColor()
        } else if sender.tag == 702 {
            self.view.backgroundColor = UIColor.yellowColor()
        }  else if sender.tag == 703 {
            self.view.backgroundColor = UIColor.orangeColor()
        }  else if sender.tag == 704 {
            self.view.backgroundColor = UIColor.redColor()
        }  else if sender.tag == 705 {
            self.view.backgroundColor = UIColor(red: 60/255.0, green:  239/255.0, blue:  239/255.0, alpha: 1.0)
        }  else {
            self.view.backgroundColor = UIColor(red: 255.0/255.0, green:  0/255.0, blue:  255.0/255.0, alpha: 0.7)
        }

       let colorView =  self.view.viewWithTag(301)
        colorView?.removeFromSuperview()
    }
    
}
