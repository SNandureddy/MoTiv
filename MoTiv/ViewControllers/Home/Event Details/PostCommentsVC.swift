//
//  PostCommentsVC.swift
//  MoTiv
//
//  Created by Apple on 06/02/19.
//  Copyright © 2019 MoTiv. All rights reserved.
//

import UIKit
import SDWebImage

class PostCommentsVC: BaseVC {
    
//MARK: IBOutlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet var commentButton: UIButton!
    @IBOutlet var textView: UITextView!
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var textViewBackView: UIView!
    
    
//MARK: Variables
    var comment = kEnterComment
    var selectedIndex = Int()
    var postID : Int?

//MARK: Class Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customiseUI()
        getCommentList()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        EventVM.shared.commentListArray?.removeAll()
    }
    
//MARK: Private Functions
    
    private func customiseUI() {
        setTitle(title: kComments)
        setBackButton()
        iconImageView.set(radius: 14.0)
        textViewBackView.set(radius: 14.0)
        textView.delegate = self
        textView.text == kEnterComment ? textViewBackView.removeShadow(): textViewBackView.setShadow()
        iconImageView.image = textView.text == kEnterComment ? #imageLiteral(resourceName: "commentUnSelected"): #imageLiteral(resourceName: "commentSelected")
        commentButton.set(radius: 14.0)
        commentButton.setBackgroundImage(commentButton.graidentImage, for: .normal)
    }
    
    
    func setDataForComment() -> JSONDictionary {
        var dict = JSONDictionary()
        dict[APIKeys.kPostID] = self.postID
        return dict
    }
    
    func setDataToAddComment() -> JSONDictionary {
        var dict = JSONDictionary()
        dict[APIKeys.kPostID] = self.postID
        dict[APIKeys.kComment] = textView.text
        return dict
    }
    
    //MARK: IBAction
    
    @IBAction func commentButtonAction(_ sender: Any) {
        if textView.text == kEnterComment || textView.text == "" {
            return
        }
        apiToAddComment()
    }
}

//MARK: UITableView DataSource and Delegate
extension PostCommentsVC : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventVM.shared.commentListArray?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCommentCell) as! CommentCell
        cell.profileImageView.set(radius: 20.0)
        cell.profileImageView.sd_setImage(with: URL(string: EventVM.shared.commentListArray?[indexPath.row].imageURL ?? ""), placeholderImage: #imageLiteral(resourceName: "userPlaceholderWhite"), options: .cacheMemoryOnly, completed: nil)
        cell.commentLabel.text = EventVM.shared.commentListArray?[indexPath.row].comment
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostSectionCommentCell") as? PostSectionCell
        cell?.postImageView.sd_setImage(with: URL(string: EventVM.shared.postListArray?[selectedIndex].postImageURL ?? ""), placeholderImage: #imageLiteral(resourceName: "imagePlaceholder"), options: .cacheMemoryOnly, completed: nil)
        cell?.postImageView.set(radius: 16.0)
        cell?.commentLabel.text = "\(EventVM.shared.postListArray?[selectedIndex].commentCount ?? 0) COMMENTS"
        cell?.likesLabel.text = "\(EventVM.shared.postListArray?[selectedIndex].likeCount ?? 0) LIKES"
        cell?.descriptionLabel.text  = EventVM.shared.postListArray?[selectedIndex].postText
        cell?.likeButton.isSelected = EventVM.shared.postListArray?[selectedIndex].postLikeStatus == 2 ? false : true
        cell?.likeButton.addTarget(self, action: #selector(self.likeButtonAction(sender:)), for: .touchUpInside)
        cell?.likeButton.tag = selectedIndex
        return cell
    }
    
    @objc func likeButtonAction(sender: UIButton) {
        sender.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            sender.isUserInteractionEnabled = true
        }
        var likeValue = 0
        if EventVM.shared.postListArray?[sender.tag].postLikeStatus == 2 { // 2 -> disliked
            likeValue = 1
        }else {
            likeValue = -1
        }
        self.ApiToLikePost(index: sender.tag, likeValue: likeValue)
    }
}

//MARK: Textview Delegates
extension PostCommentsVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textViewBackView.removeShadow()
        iconImageView.image = #imageLiteral(resourceName: "commentUnSelected")
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.text = textView.text.isEmpty ? kEnterComment: textView.text
        textView.text == kEnterComment ? textViewBackView.removeShadow(): textViewBackView.setShadow()
        iconImageView.image = textView.text == kEnterComment ? #imageLiteral(resourceName: "commentUnSelected"): #imageLiteral(resourceName: "commentSelected")
    }
    
    func textViewDidChange(_ textView: UITextView) {
        comment = textView.text!
        textView.text!.isEmpty ? textViewBackView.removeShadow(): textViewBackView.setShadow()
        iconImageView.image = textView.text!.isEmpty ? #imageLiteral(resourceName: "commentUnSelected"): #imageLiteral(resourceName: "commentSelected")
    }
}

//MARK: API Methods

extension PostCommentsVC {
    func getCommentList(){
        EventVM.shared.getCommentList(dict: setDataForComment()){ (message, error) in
            if error != nil{
                self.showErrorMessage(error: error)
            } else{
                self.tableView.reloadData()
                self.tableView.scrollToLastCell(animated: true)
            }
        }
    }
    
    func apiToAddComment(){
        Indicator.isEnabledIndicator = false
        EventVM.shared.addComment(dict: setDataToAddComment()){ (message, error) in
            if error != nil{
                self.showErrorMessage(error: error)
            } else{
                self.textView.text = ""
                self.textViewDidEndEditing(self.textView)
                Indicator.isEnabledIndicator = false
                self.getCommentList()
            }
        }
    }
    func ApiToLikePost(index: Int, likeValue: Int = 0){
        
        var dict = JSONDictionary()
        dict[APIKeys.kPostID] = EventVM.shared.postListArray?[index].postID
        dict[APIKeys.kLikeStatus] = likeValue == 1 ? 1 : 2
        Indicator.isEnabledIndicator = false
        EventVM.shared.likePost(dict: dict){ (message, error) in
            if error != nil{
                self.showErrorMessage(error: error)
            } else{
                var likes = EventVM.shared.postListArray?[index].likeCount ?? 0
                likes += likeValue
                EventVM.shared.postListArray?[index].likeCount  = likes
                EventVM.shared.postListArray?[index].postLikeStatus = (likeValue == -1) ? 2 : 1
                self.tableView.reloadData()
                Indicator.isEnabledIndicator = true
            }
        }
    }
}

