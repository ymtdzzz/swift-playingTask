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
                print(error)
                let domain = Bundle.main.bundleIdentifier!
                UserDefaults.standard.removePersistentDomain(forName: domain)
                UserDefaults.standard.synchronize()
                print("リセット")
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
        let cell = taskTableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as! TaskTableViewCell
        // 行番号に合ったToDoの情報を取得
        let todo = todoList[indexPath.row]
        cell.taskTitle.text = todo.todoTitle
        cell.willTime.text = String(todo.willTime!)
        cell.didTime.text = "0"
        cell.category.text = todo.category
        if todo.monday == true {
            cell.mondayLabel.alpha = 1.0
        } else {
            cell.mondayLabel.alpha = 0.2
        }
        if todo.tuesday == true {
            cell.tuesdayLabel.alpha = 1.0
        } else {
            cell.tuesdayLabel.alpha = 0.2
        }
        if todo.wednesday == true {
            cell.wednesdayLabel.alpha = 1.0
        } else {
            cell.wednesdayLabel.alpha = 0.2
        }
        if todo.thursday == true {
            cell.thursdayLabel.alpha = 1.0
        } else {
            cell.thursdayLabel.alpha = 0.2
        }
        if todo.friday == true {
            cell.fridayLabel.alpha = 1.0
        } else {
            cell.fridayLabel.alpha = 0.2
        }
        if todo.saturday == true {
            cell.saturdayLabel.alpha = 1.0
        } else {
            cell.saturdayLabel.alpha = 0.2
        }
        if todo.sunday == true {
            cell.sundayLabel.alpha = 1.0
        } else {
            cell.sundayLabel.alpha = 0.2
        }
        
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
        willTime = aDecoder.decodeObject(forKey: "willTime") as? Int
        didTime = aDecoder.decodeObject(forKey: "didTime") as? Int
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
