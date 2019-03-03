//
//  createTaskViewController.swift
//  playingTask
//
//  Created by 松田陽佑 on 2019/03/03.
//  Copyright © 2019 松田陽佑. All rights reserved.
//

import UIKit

class createTaskViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {

    // タスクのタイトル
    @IBOutlet weak var todoTitle: UITextField!
    // タイマー
    @IBOutlet weak var timePicker: UIDatePicker!
    // 曜日選択
    @IBOutlet weak var weekPicker: UITableView!
    // ジャンル選択
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    // Done押下
    @IBAction func tapDone(_ sender: Any) {
        // 入力チェック
        if todoTitle.text == "" || (selectedWeek[0] == false && selectedWeek[1] == false && selectedWeek[2] == false && selectedWeek[3] == false && selectedWeek[4] == false && selectedWeek[5] == false && selectedWeek[6] == false) || selectedCategory == nil {
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
            alert.title = "入力エラー"
            alert.message = "全ての項目を入力して下さい。"
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        //Navigation Controllerを取得
        let nav = self.presentingViewController  as! UINavigationController
        //呼び出し元のView Controllerを遷移履歴から取得しパラメータを渡す
        let prevVc = nav.viewControllers[nav.viewControllers.count-1] as! taskTableViewController
        
        // ToDoを作成
        let myTodo = MyTodo()
        myTodo.todoTitle = todoTitle.text!
        myTodo.willTime = Int(timePicker.countDownDuration)
        myTodo.didTime = 0
        myTodo.category = selectedCategory
        myTodo.monday = selectedWeek[0]
        myTodo.tuesday = selectedWeek[1]
        myTodo.wednesday = selectedWeek[2]
        myTodo.thursday = selectedWeek[3]
        myTodo.friday = selectedWeek[4]
        myTodo.saturday = selectedWeek[5]
        myTodo.sunday = selectedWeek[6]
        
        // 配列の先頭に挿入
        prevVc.todoList.insert(myTodo, at: 0)
        
        // テーブルに行が追加されたことをテーブルに通知
        prevVc.taskTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: UITableView.RowAnimation.right)
        
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
        
        self.dismiss(animated: true, completion: nil)
    }
    
    // 曜日選択用リスト
    let weekdays:[String] = ["月曜日","火曜日","水曜日","木曜日","金曜日","土曜日","日曜日"]
    // 選択された曜日を保持（初期値は全てfalse）
    var selectedWeek:[Bool] = [false, false, false, false, false, false, false]
    
    // ジャンル選択用リスト
    let categories:[String] = ["家事","勉強","運動","外出","その他"]
    // 選択されたジャンルを保持
    var selectedCategory:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weekPicker.allowsMultipleSelection = true
    }
    
    // MARK: - UITableViewDatasource
    // セクションの個数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    // セクションごとの行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weekdays.count
    }
    // セルを作成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        let cellData = weekdays[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = cellData
        return cell
    }
    
    // MARK: - UITableViewDelegate
    // 選択時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        // 選択内容を更新
        selectedWeek[indexPath.row] = true
        cell?.accessoryType = .checkmark
    }
    // 選択解除時
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        // 選択内容を更新
        selectedWeek[indexPath.row] = false
        cell?.accessoryType = .none
    }
    
    // MARK: - UIPickerViewDelegate
    // 選択肢を作成
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let item = categories[row]
        return item
    }
    // 選択された内容をを取得
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 現在選択されている行番号
        let row = pickerView.selectedRow(inComponent: 0)
        // 選択されている項目名を取得
        let item = self.pickerView(pickerView, titleForRow: row, forComponent: 0)
        selectedCategory = item!
        print(item!)
    }
    
    
    // MARK: - UIPickerViewDataSource
    // コンポーネント数を返却
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // コンポーネント毎の行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 入力チェック
        if todoTitle.text == "" || (selectedWeek[0] == false && selectedWeek[1] == false && selectedWeek[2] == false && selectedWeek[3] == false && selectedWeek[4] == false && selectedWeek[5] == false && selectedWeek[6] == false) {
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
            alert.title = "入力エラー"
            alert.message = "全ての項目を入力して下さい。"
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }


    }

}
