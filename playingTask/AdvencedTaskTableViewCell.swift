//
//  AdvencedTaskTableViewCell.swift
//  playingTask
//
//  Created by 松田陽佑 on 2019/03/05.
//  Copyright © 2019 松田陽佑. All rights reserved.
//

import UIKit

class AdvencedTaskTableViewCell: UITableViewCell {
    
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // ラベルへの値設定
    func dataOutputToLabel(indexPath: IndexPath) {
        self.testLabel.text = String(indexPath.section + 1)
    }
    // アイコンへの画像設定
    func setIcon(name: String) {
        let image = UIImage(named: name)
        self.iconImage.image = image
    }
    
}
