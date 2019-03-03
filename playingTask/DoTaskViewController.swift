//
//  DoTaskViewController.swift
//  playingTask
//
//  Created by 松田陽佑 on 2019/03/03.
//  Copyright © 2019 松田陽佑. All rights reserved.
//

import UIKit
import AVFoundation

class DoTaskViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var timerHour: UILabel!
    @IBOutlet weak var timerMinute: UILabel!
    @IBOutlet weak var timerSecond: UILabel!
    
    // 音楽再生用
    var audioPlayer:  AVAudioPlayer!
    
    // タイマー作成
    var timer: Timer!
    // 開始時間格納用
    var startTime = Date()
    // 作業時間
    var doTime:Int = 0
    
    // 渡ってきたtodoデータ
    var data:MyTodo = MyTodo()
    // 選ばれた行番号
    var index:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        taskTitle.text = data.todoTitle
        categoryLabel.text = data.category!
        
        startTimer()
        
        // カテゴリに合致した音楽再生
        switch data.category {
        case "家事":
            self.playSound(name: "kaji")
        case "勉強":
            self.playSound(name: "benkyou")
        case "運動":
            self.playSound(name: "undou")
        case "外出":
            self.playSound(name: "gaisyutu")
        case "その他":
            self.playSound(name: "sagyou")
        default: break
        }
    }
    
    // タイマーをスタートさせる
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerCounter), userInfo: nil, repeats: true)
        startTime = Date()
    }
    
    @objc func timerCounter() {
        // タイマー開始からのインターバル時間
        let currentTime = Date().timeIntervalSince(startTime)
        
        let hour = (Int)(fmod((currentTime/360), 60))
        let minute = (Int)(fmod((currentTime/60), 60))
        let second = (Int)(fmod(currentTime, 60))
        
        // %02d： ２桁表示、0で埋める
        let sHour = String(format:"%02d", hour)
        let sMinute = String(format:"%02d", minute)
        let sSecond = String(format:"%02d", second)
        
        timerHour.text = sHour
        timerMinute.text = sMinute
        timerSecond.text = sSecond
        
        doTime += 1
    }

    // 作業終了
    @IBAction func tapDone(_ sender: Any) {
        //Navigation Controllerを取得
        let nav = self.presentingViewController  as! UINavigationController
        //呼び出し元のView Controllerを遷移履歴から取得しパラメータを渡す
        let prevVc = nav.viewControllers[nav.viewControllers.count-1] as! taskTableViewController
        
        // 作業時間を記録したものを準備
        let didTime = data.didTime! + doTime
        data.didTime = didTime
        
        // 配列の対象indexを更新
        prevVc.todoList[index] = data
        
        // テーブルに行が更新されたことをテーブルに通知
        prevVc.taskTableView.reloadData()
        
        // ToDoの保存処理
        let userDefaults = UserDefaults.standard
        // Data型にエンコード
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: prevVc.todoList, requiringSecureCoding: true)
            userDefaults.set(data, forKey: "todoList")
            userDefaults.synchronize()
        } catch {
            // エラー処理なし
        }
        
        audioPlayer.stop()
        self.dismiss(animated: true, completion: nil)
    }
    
    // 音楽再生
    func playSound(name: String) {
        guard let path = Bundle.main.path(forResource: name, ofType: "mp3") else {
            print("音楽ファイルが見つかりません")
            return
        }
        
        do {
            // AVAudioPlayerのインスタンス化
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            // デリゲートのセット
            audioPlayer.delegate = self
            // 音声の再生
            audioPlayer.play()
        } catch {
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
