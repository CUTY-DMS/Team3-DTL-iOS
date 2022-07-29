//
//  TodoListCell.swift
//  TodoList
//
//  Created by 강인혜 on 2022/07/04.
//

import UIKit

class TodoListCell: UITableViewCell {
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbUser: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var checkBoxBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
