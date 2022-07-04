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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBAction func btnCheckBox(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
