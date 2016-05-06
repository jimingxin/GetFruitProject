//
//  StartViewViewController.swift
//  GetFruitProject
//
//  Created by 嵇明新 on 16/5/6.
//  Copyright © 2016年 lanhe. All rights reserved.
//

import UIKit
import AVFoundation

class StartViewViewController: UIViewController {

    var audioPlayer: AVAudioPlayer!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        
    }

    override func viewWillDisappear(animated: Bool) {
        
    }
    
    /**
     隐藏状态栏
     
     - returns: Bool类型 true -隐藏 false -不隐藏
     */
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    /**
     按钮点击触发事件
     */
    @IBAction func startGame(){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("PlayViewController") as! ViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    /**
     播放背景音乐
     */
    func playBgMusic() {
        let musicPath = NSBundle.mainBundle().pathForResource("startMusic", ofType: "wav")
    
        //指定音乐路径
        let url = NSURL(fileURLWithPath: musicPath!)
        audioPlayer = try?AVAudioPlayer(contentsOfURL: url, fileTypeHint: nil)
        //设置音乐播放次数，-1为循环播放
        audioPlayer.numberOfLoops = -1
        //设置音乐音量，可用范围为0~1
        audioPlayer.volume = 1
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


 

}
