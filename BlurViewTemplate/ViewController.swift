//
//  ViewController.swift
//  BlurViewTemplate
//
//  Created by Joe E. on 2/25/16.
//  Copyright © 2016 Joe Edwards. All rights reserved.
//

import UIKit

//these are settings that will let you customize UI elements such as background and button color and font settings. change one here and it will (for the most part) change the settings across the entire view
private let YELLOW = UIColor(red: 1, green: 0.97, blue: 0.57, alpha: 1)
private let HEADER_BLUE = UIColor(red: 0.09, green: 0.35, blue: 0.67, alpha: 1)
private let HEADER_FONT = UIFont.systemFontOfSize(17, weight: UIFontWeightLight)
private let BLUR_VIEW_TEXT = UIFont.systemFontOfSize(17, weight: UIFontWeightLight)
private let INCREASE_FONT = UIFont.systemFontOfSize(60, weight : UIFontWeightLight)

class ViewController: UIViewController {
    
     override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting up the default view
        
        view.backgroundColor = YELLOW
        
        let blurButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        blurButton.setTitle("Press Me", forState: .Normal)
        blurButton.setTitleColor(UIColor(white: 0, alpha: 0.66), forState: .Normal)
        blurButton.layer.masksToBounds = true ; blurButton.layer.cornerRadius = blurButton.bounds.height / 2
        blurButton.addTarget(self, action: "blurButtonAction", forControlEvents: .TouchUpInside)
        
        blurButton.center = view.center
        view.addSubview(blurButton)

        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 60))
        headerView.backgroundColor = UIColor.whiteColor()
        
        let headerLabel = UILabel(frame: CGRect(x: headerView.bounds.origin.x, y: headerView.bounds.midY, width: headerView.bounds.width, height: 30))
        headerLabel.text = "Header" ; headerLabel.textAlignment = .Center
        headerLabel.font = HEADER_FONT
        
        headerView.addSubview(headerLabel) ; view.addSubview(headerView)

    }
    
    func blurButtonAction() {
        
        //adds the blur view plus any other views that you want to add
        let cancel = UITapGestureRecognizer(target: self, action: "cancelGesture:") ; cancel.delegate = self
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurView = UIVisualEffectView(effect: blurEffect); blurView.frame = view.frame
        blurView.tag = 7 ; blurView.alpha = 0 ;
        blurView.userInteractionEnabled = true
        
        view.addSubview(blurView) ; blurView.addGestureRecognizer(cancel)
        
        //here are some views within the blurViews that you might want to add. feel free to customize them anyway that you wish
        
        guard let cancelImg = UIImage(named: "CancelTransparent") else { return }
        
        let cancelButton = UIButton(frame: CGRect(x: self.view.bounds.minX + 8, y: self.view.bounds.minY + 20, width: 25, height: 25))
        cancelButton.setImage(cancelImg, forState: .Normal)
        cancelButton.addTarget(self, action: "cancel:", forControlEvents: .TouchUpInside)
        cancelButton.alpha = 0 ; cancelButton.tag = 7
        
        view.addSubview(cancelButton)
        
        let labelTouched = UIGestureRecognizer(target: self, action: "labelTouched")
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: blurView.bounds.width, height: 30))
        label.center.y = blurView.bounds.midY + 60
        label.text = "Here's a label that you can customize" ; label.font = BLUR_VIEW_TEXT ; label.textColor = UIColor.whiteColor() ; label.textAlignment = .Center
        label.tag = 7
        
        view.addSubview(label)
        
        let increase = UIButton(frame: CGRect(x: blurView.bounds.midX - 60 , y: blurView.bounds.maxY + 60, width: 100, height: 100))
        increase.center = CGPoint(x: self.view.bounds.midX + 66, y: self.view.bounds.maxY - 150)
        increase.setTitle("+", forState: .Normal) ; increase.titleLabel?.font = INCREASE_FONT
        increase.alpha = 0 ; increase.tag = 7
        
        view.addSubview(increase)
        
        increase.addTarget(self, action: "increaseQuantity:", forControlEvents: UIControlEvents.TouchUpInside)

        let decrease = UIButton(frame: CGRect(x: blurView.bounds.midX + 60 , y: blurView.bounds.maxY + 60, width: increase.frame.width, height: increase.frame.width))
        decrease.center = CGPoint(x: self.view.bounds.midX - 66, y: self.view.bounds.maxY - 150)
        decrease.setTitle("-", forState: .Normal) ; decrease.titleLabel?.font = increase.titleLabel?.font
        decrease.alpha = 0 ; decrease.tag = 7

        view.addSubview(decrease)
        decrease.addTarget(self, action: "decreaseQuantity:", forControlEvents: UIControlEvents.TouchUpInside)
        
        let confirmButton = UIButton(frame: CGRect(x: self.view.bounds.minX, y: self.view.bounds.maxY - 60, width: self.view.bounds.width, height: 60))
        confirmButton.backgroundColor = YELLOW
        confirmButton.setTitle("Confirm", forState: .Normal) ; confirmButton.titleLabel?.font = HEADER_FONT
        confirmButton.titleLabel?.font = UIFont.systemFontOfSize(20, weight : UIFontWeightMedium) ; confirmButton.setTitleColor(UIColor(white: 0, alpha: 0.66) , forState: .Normal)
        confirmButton.alpha = 0 ; confirmButton.tag = 7

        view.addSubview(confirmButton)
        confirmButton.addTarget(self, action: "confirm:", forControlEvents: UIControlEvents.TouchUpInside)

        UIView.animateWithDuration(0.33, animations: { () -> Void in
            //slightly more complex animation. add all of the subviews that you added above to the animation below. the delay in animation makes it slightly more aesthetically pleasing to the eye
            blurView.alpha = 1
            
            }) { (Bool) -> Void in
                UIView.animateWithDuration(0.33, animations: { () -> Void in
                    //make sure that you make all of the subviews alphas one here
                    cancelButton.alpha = 1 ; label.alpha = 1 ; increase.alpha = 1 ; decrease.alpha = 1 ; confirmButton.alpha = 1
                    
                })
                
                
        }

    }
    
    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning()

    }


}

extension ViewController : UIGestureRecognizerDelegate {
    
}


extension ViewController  {
    //functions
    
    func removeTag7Views() {
        for subView in self.view.subviews {
            print("working")
            if subView.tag == 7 {
                UIView.animateWithDuration(0.33, animations: { () -> Void in
                    subView.alpha = 0
                    }, completion: { (Bool) -> Void in
                        subView.removeFromSuperview()
                })
            }
            
        }
        
        
    }
    
    func cancel(sender: UIButton) { print("cancel") ; removeTag7Views()
        
    }
    
    func cancelGesture(sender: UIGestureRecognizer) {  print("cancel") ; removeTag7Views()
        
    }
    
    func increaseQuantity(sender:UIButton) { print("increase") }
    func decreaseQuantity(sender:UIButton) { print("decrease") }
    
    func confirm(sender:UIButton) { print("tapped"); removeTag7Views() }
    
    

    
}

