//
//  DetailViewController.swift
//  SwiftHelloCollectionView
//
//  Created by Kent Liu on 2014/11/28.
//  Copyright (c) 2014年 Kent Liu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var theImageView: UIImageView!
    @IBOutlet weak var theScrollView: UIScrollView!
    @IBOutlet weak var theTimeIntervalSlider: UISlider!
    
    var datas = [String]()
    var targetIndex:Int = -1
    var isPlaying = false
    var timer:Timer?

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.

        if targetIndex == -1 || datas.isEmpty    // For iPad
        {
            return
        }
        
        let image = UIImage(named: datas[targetIndex])
        
        theImageView.image = image
        theScrollView.contentSize = (image?.size)!
        theScrollView.maximumZoomScale = 3.0
        theScrollView.minimumZoomScale = 1.0
        theScrollView.zoomScale = 1.0
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.automaticallyAdjustsScrollViewInsets = false
        
        theTimeIntervalSlider.isHidden = true
        
        self.configureView()
        
        // Add Gesture Recognizer
        let toLeft = UISwipeGestureRecognizer(target: self, action: #selector(DetailViewController.toLeft))
        toLeft.direction=UISwipeGestureRecognizerDirection.left
        
        theImageView.addGestureRecognizer(toLeft)
        
        let toRight = UISwipeGestureRecognizer(target: self, action: #selector(DetailViewController.toRight))
        toRight.direction=UISwipeGestureRecognizerDirection.right
        
        theImageView.addGestureRecognizer(toRight)
        
        theImageView.isUserInteractionEnabled=true
        
    }
    
    func toLeft() {
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        
        targetIndex += 1
        if(targetIndex>=datas.count)
        {
            targetIndex=0;
        }
        configureView()
        
        theImageView.layer.add(transition, forKey: nil)
        
    }
    
    func toRight() {
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        
        targetIndex -= 1
        if(targetIndex<0)
        {
            targetIndex=datas.count-1;
        }
        configureView()
        
        theImageView.layer.add(transition, forKey: nil)
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        
        // Stop Timer
        if timer != nil
        {
            timer?.invalidate()
            timer = nil
        }
        
    }
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return theImageView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playStopButtonPressed(_ sender: AnyObject) {
        
        if targetIndex == -1 || datas.isEmpty    // For iPad
        {
            return
        }
        
        
        isPlaying = !isPlaying
        
        if isPlaying
        {
            if targetIndex == -1
            {
                targetIndex = 0
                configureView()
            }
            
            theTimeIntervalSlider.isHidden = false
            let timeInterval = TimeInterval(theTimeIntervalSlider.value)
            timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(DetailViewController.toLeft), userInfo: nil, repeats: true)
            
            // Update Button
            let stopButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.stop, target: self, action: #selector(DetailViewController.playStopButtonPressed(_:)))
            self.navigationItem.rightBarButtonItem = stopButton
        }
        else
        {
            theTimeIntervalSlider.isHidden = true
//            let timeInterval = NSTimeInterval(theTimeIntervalSlider.value)
            timer?.invalidate()
            timer = nil
            
            // Update Button
            let playButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.play, target: self, action: #selector(DetailViewController.playStopButtonPressed(_:)))
            self.navigationItem.rightBarButtonItem = playButton
        }
        
        
        
    }
    @IBAction func timeIntervalValueChaged(_ sender: AnyObject) {
        
        // Cancel Timer
        timer?.invalidate()
        timer = nil
        
        // Start New Timer
        let timeInterval = TimeInterval(theTimeIntervalSlider.value)
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(DetailViewController.toLeft), userInfo: nil, repeats: true)
        
    }

    deinit {
        
        NSLog("DetailViewController dealloc.")
        
    }


}

