//
//  ViewController.swift
//  GetFruitProject
//
//  Created by 嵇明新 on 16/5/6.
//  Copyright © 2016年 lanhe. All rights reserved.
//

import UIKit
import AVFoundation

let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height


class ViewController: UIViewController ,UIActionSheetDelegate ,AVAudioPlayerDelegate{

    @IBOutlet weak var markbl: UILabel!
    
    var timer: NSTimer!
    var boomTimer: NSTimer!
    var belowImg: UIImageView!
    var audioPlayer: AVAudioPlayer!
    var boomAudioPlayer: AVAudioPlayer!
    
    var leftTime: Int = 99999
    var boomLeftTime: Int = 999
    var mark: Int = 0
    var GameOn: Bool!
    
    var index: UInt32!
    var boomIndex: UInt32!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //测试
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    /**
     播放背景音乐
     */
    func playBgMusic() {
        let musicPath = NSBundle.mainBundle().pathForResource("bgMusic", ofType: "wav")
        //指定音乐路径
        let url = NSURL(fileURLWithPath: musicPath!)
        audioPlayer = try? AVAudioPlayer(contentsOfURL: url, fileTypeHint: nil)
        audioPlayer.numberOfLoops = -1
        //设置音乐播放次数，-1为循环播放
        audioPlayer.volume = 1
        //设置音乐音量，可用范围为0~1
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    func playBoomMusic() {
        let musicPath = NSBundle.mainBundle().pathForResource("boomMusic", ofType: "wav")
        //指定音乐路径
        let url = NSURL(fileURLWithPath: musicPath!)
        boomAudioPlayer = try? AVAudioPlayer(contentsOfURL: url, fileTypeHint: nil)
        boomAudioPlayer.numberOfLoops = -1
        //设置音乐音量
        boomAudioPlayer.volume = 1
        
        boomAudioPlayer.prepareToPlay()
        boomAudioPlayer.play()
        
    }
    
    /**
     返回按钮触发事件
     */
    @IBAction func backBtn(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /**
     隐藏状态栏
     
     - returns: Bool值
     */
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    /**
     拖动图片的手势事件
     
     - parameter sender: <#sender description#>
     */
    func handlePanGesture(sender: UIPanGestureRecognizer) {
        //得到拖的过程中的xy坐标
        let location :CGPoint = sender.locationInView(self.view)
        belowImg.frame = CGRectMake(location.x-35, belowImg.frame.origin.y, belowImg.frame.size.width, belowImg.frame.size.height)
    }
    
    func handleTapGesture(sender: UITapGestureRecognizer) {
        let location: CGPoint = sender.locationInView(self.view)
        belowImg.frame = CGRectMake(location.x-35, belowImg.frame.origin.y, belowImg.frame.size.width, belowImg.frame.size.height)
        
    }
    
    func show() {
        var img = UIImageView(frame: CGRectMake(CGFloat(index), 0, 50, 50)){
            willSet(frameChange){
            
            }
        }
        
        img.image = UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource(String(arc4random_uniform(5)), ofType: "png")!)
        img.tag = leftTime
        self.view.addSubview(img)
        
        UIView.animateWithDuration(5, delay: 0, options: .CurveLinear, animations: { 
            img.frame = CGRectMake(CGFloat(self.index), SCREEN_HEIGHT, 50, 50)
            }, completion: nil)
        
    }
    
    func boomShow() {
        print(boomLeftTime)
        var img = UIImageView(frame: CGRectMake(CGFloat(boomIndex), 0, 50, 80)){
            willSet(frameChange){
            
            }
        }
        
        img.image = UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource("boom", ofType:"png")!)
        img.tag = boomLeftTime
        self.view.addSubview(img)
        
        if arc4random_uniform(2) == 0 {
            UIView.animateWithDuration(2.5, delay: 0, options: .CurveLinear, animations: {
                img.frame = CGRectMake(CGFloat(self.boomIndex)-50, SCREEN_HEIGHT, 50, 80)
                }, completion: nil)
        }else {
            UIView.animateWithDuration(2.5, delay: 0, options: .CurveLinear, animations: {
                img.frame = CGRectMake(CGFloat(self.boomIndex)+50, SCREEN_HEIGHT, 50, 80)
                }, completion: nil)
        }

        
    }
    
    
    func boomDown() {
        if GameOn == true {
            
            if boomLeftTime <= 0 {
                //取消定时器
                boomTimer.invalidate()
            }
            
            if boomLeftTime <= 997 {
                let img = self.view.viewWithTag(boomLeftTime+1) as! UIImageView
                if img.frame.origin.x>belowImg.frame.origin.x-35 {
                    if img.frame.origin.x<belowImg.frame.origin.x+55 {
                        let aimg = self.view.viewWithTag(boomLeftTime+1) as! UIImageView
                        aimg.hidden = true;
                        
                        mark = mark-5
                        playBoomMusic()
                        //重新计算分数或者结束游戏
                    }
                }
            }
            
            if boomLeftTime <= 994 {
                let  img = self.view.viewWithTag(boomLeftTime+4) as! UIImageView
                img.removeFromSuperview()
            }
            
            boomLeftTime -= 1
            //修改剩余时间
            boomIndex = UInt32(SCREEN_WIDTH*0.87)
            boomIndex =  arc4random_uniform(boomIndex)
            boomShow()
        
        }else{
            boomTimer.invalidate()
            boomTimer = nil
        }
    }
    
    

}




























