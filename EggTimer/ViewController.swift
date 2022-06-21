//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    //プログレスバー
    @IBOutlet weak var progressBar: UIProgressView!
    //タイトルラベル
    @IBOutlet weak var titleLabel: UILabel!
    
    //定数で固さと時間(秒)を定義
    let eggTimes = ["Soft": 300,"Medium": 420,"Hard": 720]
    
    //AVAudioPlayerをインスタンス化
    var player: AVAudioPlayer!
    //Timerクラスを使えるようにtimerとして宣言
    var timer = Timer()
    
    var totalTime = 0
    var secondsPassed = 0
    
    //エディタからドラッグして3つのボタンを1つのコードにまとめる
    //押したボタンの情報がsenderに入る
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        //ボタンがタップされたらタイマーを止める
        timer.invalidate()
      
        //タップされたボタンの値をhardnessとして宣言
        let hardness = sender.currentTitle!
        
        //totleTimeはInt型なのでcurrentTitleの整数が入る
        totalTime = eggTimes[hardness]!
        
        //progressBarを0に戻す
        progressBar.progress = 0.0
        //秒数を０にリセット
        secondsPassed = 0
        //titleLabelにhardnessに入っている値を表示
        titleLabel.text = hardness
        
        //タイマー設定
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
      
    }
    
    @objc func updateTimer() {
        //secondsPassedの値がtotalTimeより小さかったら
        if secondsPassed < totalTime {
            //毎秒インクリメントする
            secondsPassed += 1
            //secondsPassed÷totalTimeの結果をprogressに表示
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            
            
        //secondsPassedの値がtotalTimeより大きかったら(タイマーが0になったら)
        } else {
            //タイマーを止める
            timer.invalidate()
            //titleLabelのtextにDONE!と表示
            titleLabel.text = "DONE!"
            
            //アラームを再生する
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
    
}
