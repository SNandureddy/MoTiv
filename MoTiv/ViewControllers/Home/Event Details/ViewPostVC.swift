//
//  ViewPostVC.swift
//  MoTiv
//
//  Created by IOS on 30/11/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class ViewPostVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    
    
    //MARK: Variables
    var selectedSection = -1
    var section : Int?
    var comment = kEnterComment
    var selectedIndex = Int()
    var postList : [PostList]?
    var commentList : [CommentList]?
    var indexofPage:Int = 1
    var type: PreviousScreen = .main
    var categoryEventDetailArray = [SearchEventDetail]()

    //MARK: Class Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customiseUI()
        getPostList()
    }
    
    override func addButtonAction(sender: UIButton) {
        let addpostvc = self.storyboard?.instantiateViewController(withIdentifier: kAddPostVC) as! AddPostVC
        addpostvc.selectedIndex = self.selectedIndex
        if type == .search {
            addpostvc.categoryEventDetailArray = self.categoryEventDetailArray
            addpostvc.type = .search
        }
        self.navigationController?.show(addpostvc, sender: self)
    }
    
    //MARK: Private Methods
    private func customiseUI() {
        indexofPage = 1
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.rowHeight = UITableViewAutomaticDimension
        setTitle(title: kPosts)
        setAddButton()
        tableHeightConstraint.constant = tableView.contentSize.height
    }
    
    func setDataForPost() -> JSONDictionary {
        var dict = JSONDictionary()
        dict[APIKeys.kEventID] = type == .search ? categoryEventDetailArray[selectedIndex].eventID : EventVM.shared.eventDetailArray?[selectedIndex].eventID
        dict[APIKeys.kPage] = indexofPage
        return dict
    }
}

//MARK: Tableview Datasource
extension ViewPostVC: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (postList?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kPostSectionCell) as! PostSectionCell
        cell.postImageView.set(radius: 14.0)
        cell.postImageView.sd_setImage(with: URL(string: postList?[indexPath.row].postImageURL ?? ""), placeholderImage: #imageLiteral(resourceName: "imagePlaceholder"), options: .cacheMemoryOnly, completed: nil)
        cell.commentLabel.text = "\(postList?[indexPath.row].commentCount ?? 0) COMMENTS"
        cell.likesLabel.text = "\(postList?[indexPath.row].likeCount ?? 0) LIKES"
        cell.descriptionLabel.text  = postList?[indexPath.row].postText
        cell.commentsButton.addTarget(self, action: #selector(self.commentsButtonAction(sender:)), for: .touchUpInside)
        cell.commentsButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(self.likeButtonAction(sender:)), for: .touchUpInside)
        cell.likeButton.tag = indexPath.row
        cell.likeButton.isSelected = postList?[indexPath.row].postLikeStatus == 2 ? false : true
        return cell
    }
    
    @objc func likeButtonAction(sender: UIButton) {
        sender.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            sender.isUserInteractionEnabled = true
        }
        self.ApiToLikePost(index: sender.tag)
        }
    
    @objc func commentsButtonAction(sender: UIButton) {
        let commentsVC =
            self.storyboard?.instantiateViewController(withIdentifier: kPostCommentsVC) as! PostCommentsVC
        commentsVC.postID = EventVM.shared.postListArray?[sender.tag].postID
        commentsVC.selectedIndex = sender.tag
        self.navigationController?.show(commentsVC, sender: self)
    }
}

//MARK: Textview Delegates
extension ViewPostVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        selectedSection = textView.tag
        let cell = tableView.cellForRow(at: IndexPath(row: 4, section: textView.tag)) as! AddCommentCell
        cell.backView.removeShadow()
        cell.iconImageView.image = #imageLiteral(resourceName: "commentUnSelected")
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.text = textView.text.isEmpty ? kEnterComment: textView.text
        let cell = tableView.cellForRow(at: IndexPath(row: 4, section: textView.tag)) as! AddCommentCell
        textView.text == kEnterComment ? cell.backView.removeShadow(): cell.backView.setShadow()
        cell.iconImageView.image = textView.text == kEnterComment ? #imageLiteral(resourceName: "commentUnSelected"): #imageLiteral(resourceName: "commentSelected")
    }
    
    func textViewDidChange(_ textView: UITextView) {
        comment = textView.text!
        let cell = tableView.cellForRow(at: IndexPath(row: 4, section: textView.tag)) as! AddCommentCell
        textView.text!.isEmpty ? cell.backView.removeShadow(): cell.backView.setShadow()
        cell.iconImageView.image = textView.text!.isEmpty ? #imageLiteral(resourceName: "commentUnSelected"): #imageLiteral(resourceName: "commentSelected")
    }
}

//MARK: UIScrollViewDelegate
extension ViewPostVC {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        if EventVM.shared.total == EventVM.shared.to ?? 0 {
            return
        }
        if (tableView!.contentOffset.y + tableView!.frame.height) >= (tableView!.contentSize.height - 50) {
            if (postList?.count ?? 0) > 0 {
                indexofPage = indexofPage + 1
                getPostList()
            }
        }
    }
}

//MARK: API Methods

extension ViewPostVC {
    
    func getPostList(){
        if indexofPage == 1 {
            EventVM.shared.postListArray?.removeAll()
            self.postList?.removeAll()
            self.tableView.reloadData()
        }
        EventVM.shared.getPostList(dict: setDataForPost()){ (message, error) in
            if error != nil{
                self.indexofPage = self.indexofPage - 1
                self.showErrorMessage(error: error)
            } else{
                if self.indexofPage == (EventVM.shared.postLastPage ?? 0) {
                    self.indexofPage = self.indexofPage - 1
                }
                self.postList?.removeAll()
                self.postList = EventVM.shared.postListArray
                self.tableView.reloadData()
            }
        }
    }
    func ApiToLikePost(index: Int){
        
        var dict = JSONDictionary()
        dict[APIKeys.kPostID] = EventVM.shared.postListArray?[index].postID
        dict[APIKeys.kLikeStatus] = EventVM.shared.postListArray?[index].postLikeStatus
        Indicator.isEnabledIndicator = false
        EventVM.shared.likePost(dict: dict){ (message, error) in
            if error != nil{
                self.showErrorMessage(error: error)
            } else{
                self.getPostList()
                self.tableView.reloadData()
                Indicator.isEnabledIndicator = true
            }
        }
    }
}
