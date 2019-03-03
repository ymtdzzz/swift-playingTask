//
//  taskTableViewController.swift
//  playingTask
//
//  Created by 松田陽佑 on 2019/03/03.
//  Copyright © 2019 松田陽佑. All rights reserved.
//

import UIKit

class taskTableViewController: UITableViewController {

    // ToDoを格納する配列
    var todoList = [MyTodo]()
    
    @IBOutlet var taskTableView: UITableView!
    
    // 追加ボタン
    @IBAction func tapAdd(_ sender: Any) {
        // 移動先のビューコントローラを参照
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "createTask")
        // トランジションの映像効果
        nextVC?.modalTransitionStyle = .coverVertical
        // シーンを移動
        present(nextVC!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 保存しているToDoを読み込む
        let userDefaults = UserDefaults.standard
        if let storedTodoList = userDefaults.object(forKey: "todoList") as? Data {
            do {
                if let unarchiveTodoList = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, MyTodo.self], from: storedTodoList) as? [MyTodo] {
                    todoList.append(contentsOf: unarchiveTodoList)
                }
            } catch {
                // エラー処理なし
            }
        }
    }

    // MARK: - Table view data source

    // テーブルの行数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = taskTableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        // 行番号に合ったToDoのタイトルを取得
        let todoTitle = todoList[indexPath.row].todoTitle
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
    // ジャンル
    var category:String?
    
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
        category = aDecoder.decodeObject(forKey: "category") as? String
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
        aCoder.encode(category, forKey: "category")
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
