//
//  FirstViewController.swift
//  MushRoomNoteApp
//
//  Created by Risa Takahashi on 2020/09/22.
//  Copyright © 2020 Risa Takahashi. All rights reserved.
//

import UIKit

var toolBar:UIToolbar!
let years = (1900...3118).map { $0 }
let months = (1...12).map { $0 }

class FirstViewController: UIViewController {

    var datePicker : UIDatePicker!
    @IBOutlet var txtDate: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // ピッカー設定
        if let unwrappedDatePicker = datePicker {
            unwrappedDatePicker.datePickerMode = UIDatePicker.Mode.date
            unwrappedDatePicker.timeZone = NSTimeZone.local
            unwrappedDatePicker.locale = Locale.current
            txtDate.inputView = unwrappedDatePicker
            
            // 決定バーの生成
            let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
            let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
            let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
            toolbar.setItems([spacelItem, doneItem], animated: true)
            
            // インプットビュー設定(紐づいているUITextfieldへ代入)
            txtDate.inputView = unwrappedDatePicker
            txtDate.inputAccessoryView = toolbar
        }
    }
    
    // UIDatePickerのDoneを押したら発火
    @objc func done() {
        txtDate.endEditing(true)
        
        // 日付のフォーマット
        let formatter = DateFormatter()
        
        //"yyyy年MM月dd日"を"yyyy/MM/dd"したりして出力の仕方を好きに変更できるよ
        formatter.dateFormat = "yyyy年MM月dd日"
        
        //(from: datePicker.date))を指定してあげることで
        //datePickerで指定した日付が表示される
        txtDate.text = "\(formatter.string(from: datePicker.date))"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


