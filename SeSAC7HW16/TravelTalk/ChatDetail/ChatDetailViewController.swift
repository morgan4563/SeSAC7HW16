//
//  ChatDetailViewController.swift
//  SeSAC7HW16
//
//  Created by hyunMac on 7/20/25.
//

import UIKit

class ChatDetailViewController: UIViewController {

    @IBOutlet var chatTableView: UITableView!
    var chatRoom: ChatRoom?

    override func viewDidLoad() {
        super.viewDidLoad()

		configureUI()
        configureTableView()
    }

    private func configureUI() {
        navigationItem.title = chatRoom?.chatroomName ?? "채팅"
    }

    private func configureTableView() {
        chatTableView.delegate = self
        chatTableView.dataSource = self

        let myNib = UINib(nibName: "MyChatTableViewCell", bundle: nil)
        let otherNib = UINib(nibName: "OtherChatTableViewCell", bundle: nil)
        chatTableView.register(myNib, forCellReuseIdentifier: "MyChatTableViewCell")
        chatTableView.register(otherNib, forCellReuseIdentifier: "OtherChatTableViewCell")
    }
}

extension ChatDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatRoom?.chatList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chat = chatRoom?.chatList[indexPath.row]

        if chat?.user.name == ChatList.me.name {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyChatTableViewCell") as! MyChatTableViewCell
            cell.chatLabel.text = chat?.message
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OtherChatTableViewCell") as! OtherChatTableViewCell
            cell.chatLabel.text = chat?.message
            return cell
        }
    }
}
