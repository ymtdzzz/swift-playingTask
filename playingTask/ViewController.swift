//
//  ViewController.swift
//  playingTask
//
//  Created by 松田陽佑 on 2019/03/03.
//  Copyright © 2019 松田陽佑. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

// タスクを管理するクラス
class MyTodo: NSObject,  NSSecureCoding {
    static var supportsSecureCoding: Bool {
        return true
    }
    
    // Todoのタイトル
    var todoTitle:String?
    // 目標時間（秒数）
    var willTime:Int?
    // 実施時間（秒数）
    var didTime:Int?
    
    // 曜日
    var monday:Bool = false
    var tuesday:Bool = false
    var wednesday:Bool = false
    var thursday:Bool = false
    var friday:Bool = false
    var saturday:Bool = false
    var sunday:Bool = false
    
    // コンストラクタ
    override init() {
        
    }
    
    // デコード処理の実装
    required init?(coder aDecoder: NSCoder) {
        todoTitle = aDecoder.decodeObject(forKey: "todoTitle") as? String
        willTime = aDecoder.decodeInteger(forKey: "willTime")
        didTime = aDecoder.decodeInteger(forKey: "didTime")
        monday = aDecoder.decodeBool(forKey: "monday")
        tuesday = aDecoder.decodeBool(forKey: "tuesday")
        wednesday = aDecoder.decodeBool(forKey: "wednesday")
        thursday = aDecoder.decodeBool(forKey: "thursday")
        friday = aDecoder.decodeBool(forKey: "friday")
        saturday = aDecoder.decodeBool(forKey: "saturday")
        sunday = aDecoder.decodeBool(forKey: "sunday")
    }
    // エンコード処理
    func encode(with aCoder: NSCoder) {
        aCoder.encode(todoTitle, forKey: "todoTitle")
        aCoder.encode(willTime, forKey: "willTime")
        aCoder.encode(didTime, forKey: "didTime")
        aCoder.encode(monday, forKey: "monday")
        aCoder.encode(tuesday, forKey: "tuesday")
        aCoder.encode(wednesday, forKey: "wednesday")
        aCoder.encode(thursday, forKey: "thursday")
        aCoder.encode(friday, forKey: "friday")
        aCoder.encode(saturday, forKey: "saturday")
        aCoder.encode(sunday, forKey: "sunday")
    }
}
