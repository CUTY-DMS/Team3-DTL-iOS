//
//  MyDetailVC.swift
//  TodoList
//
//  Created by 강인혜 on 2022/07/29.
//

import UIKit
import Alamofire

class MyDetailVC: UIViewController {
    @IBOutlet weak var lbMyPostTitle: UILabel!
    @IBOutlet weak var txtViewMyPostContent: UITextView!
    @IBOutlet weak var lbMyPostDate: UILabel!
    @IBOutlet weak var btnMyTodoState: UIButton!
    @IBOutlet weak var lbMyLikesCount: UILabel!
    @IBOutlet weak var myLikeBtn: UIButton!
    
    var postDetail = DetailModel()
    var likeResult = LikeModel()
    
    var myTitle: String = ""
    var myContent: String = ""
    var myID: Int = 0
    var date: String = ""
    var state: Bool = false
    var myLikesCount: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getPostDetail()
        
        lbMyPostTitle.text = "\(myTitle)"
        lbMyPostDate.text = "\(date)"
        txtViewMyPostContent.text = "\(myContent)"
        lbMyLikesCount.text = "\(myLikesCount)"
        
        btnMyTodoState.titleLabel?.textColor = UIColor(named: "MainColor")
        
        if (state == true) {
           successState()
        }
    }
    
    private func getPostDetail() {
//        let url = "http://10.156.147.206:8080/post/\(myID)" //학교
        let url = "http://13.209.66.51:8080/post/\(myID)"
        var request = URLRequest(url: URL(string: url)!)
        request.method = .get
        request.setValue( "\(KeyChain.read(key: "token") ?? "")", forHTTPHeaderField: "AccessToken")

        AF.request(request).response { (response) in switch response.result {
            case .success:
                debugPrint(response)
                if let data = try? JSONDecoder().decode(DetailModel.self, from: response.data!){
                    DispatchQueue.main.async {
                        self.postDetail = data
                        
                        if (self.postDetail.liked == true) {
                            self.likedTrue()
                        }
                        else if (self.postDetail.liked == false) {
                            self.likedFalse()
                        }
                    }
                }
            
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    private func getHeartsInfo() {
//        let url = "http://10.156.147.206:8080/post/main/like/\(myID)" //학교
        let url = "http://13.209.66.51:8080/post/main/like/\(myID)"
        var request = URLRequest(url: URL(string: url)!)
        request.method = .get
        request.setValue( "\(KeyChain.read(key: "token") ?? "")", forHTTPHeaderField: "AccessToken")


        AF.request(request).response { (response) in switch response.result {
            case .success:
                debugPrint(response)
                if let data = try? JSONDecoder().decode(LikeModel.self, from: response.data!){
                    DispatchQueue.main.async {
                        self.likeResult = data
                        
                        self.myLikesCount = self.likeResult.like_count
                        self.lbMyLikesCount.text = "\(self.likeResult.like_count)"
                        if (self.likeResult.liked == true) {
                            self.likedTrue()
                        }
                        else if (self.likeResult.liked == false) {
                            self.likedFalse()
                        }
                    }
                }


            case .failure(let error):
                print(error)
                
            }
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
    
    @IBAction func btnMyPostLike(_ sender: UIButton) {
        getHeartsInfo()
        
        print(likeResult)
    }
    
    
    func successState() {
        btnMyTodoState.titleLabel?.textColor = UIColor(named: "MainColor")
        let todoState = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .default)
        let successImage = UIImage(systemName: "checkmark.square.fill", withConfiguration: todoState)
        
        btnMyTodoState.setImage(successImage, for: .normal)
    }
    
    func likedTrue() {
        myLikeBtn.titleLabel?.textColor = UIColor(named: "MainColor")
        let likeState = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .default)
        let likedImage = UIImage(systemName: "heart.fill", withConfiguration: likeState)
        myLikeBtn.setImage(likedImage, for: .normal)
    }
    
    func likedFalse() {
        myLikeBtn.titleLabel?.textColor = UIColor(named: "MainColor")
        let likeState = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .default)
        let likedImage = UIImage(systemName: "heart", withConfiguration: likeState)
        myLikeBtn.setImage(likedImage, for: .normal)
    }
    
}
