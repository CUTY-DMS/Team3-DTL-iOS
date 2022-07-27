//
//  MyPostsCell.swift
//  TodoList
//
//  Created by 강인혜 on 2022/07/27.
//

import UIKit

class MyPostsCell: UITableViewCell {
    @IBOutlet weak var lbMyPostTitle: UILabel!
    @IBOutlet weak var lbMyPostDate: UILabel!
    @IBOutlet weak var TodoStateBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
