//
//  MyDetailVC.swift
//  TodoList
//
//  Created by 강인혜 on 2022/07/29.
//

import UIKit

class MyDetailVC: UIViewController {
    @IBOutlet weak var lbMyPostTitle: UILabel!
    @IBOutlet weak var txtViewMyPostContent: UITextView!
    @IBOutlet weak var lbMyPostDate: UILabel!
    @IBOutlet weak var btnMyTodoState: UIButton!
    @IBOutlet weak var lbMyLikesCount: UILabel!
    
    
    var myTitle: String = ""
    var myContent: String = ""
    var myID: Int = 0
    var date: String = ""
    var state: Bool = false
    var myLikesCount: Int = 0
    var liked: Bool = false
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbMyPostTitle.text = "\(myTitle)"
        lbMyPostDate.text = "\(date)"
        txtViewMyPostContent.text = "\(myContent)"
        lbMyLikesCount.text = "\(myLikesCount)"
        
        btnMyTodoState.titleLabel?.textColor = UIColor(named: "MainColor")
        
        if (state == true) {
            let todoState = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .default)
            let successImage = UIImage(systemName: "checkmark.square.fill", withConfiguration: todoState)
            
            btnMyTodoState.setImage(successImage, for: .normal)
        }
        
    }
    
    @IBAction func btnToRevise(_ sender: UIButton) {
        guard let toRevise = self.storyboard?.instantiateViewController(withIdentifier: "ReviseVC") as? ReviseVC else { return }
        
        toRevise.reviseTitle = "\(lbMyPostTitle.text!)"
        toRevise.reviseContent = "\(txtViewMyPostContent.text!)"
        toRevise.reviseState = state
        toRevise.reviseID = myID
        
        
        navigationController?.pushViewController(toRevise, animated: true)
    }
    
    @IBAction func btnPostLike(_ sender: UIButton) {
    }
    
}
