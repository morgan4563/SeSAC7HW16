//
//  ChatDetailViewController.swift
//  SeSAC7HW16
//
//  Created by hyunMac on 7/20/25.
//

import UIKit

class ChatDetailViewController: UIViewController {

    @IBOutlet var chatTableView: UITableView!

    @IBOutlet var messageTextView: UITextView!
    @IBOutlet var messageTextViewHeight: NSLayoutConstraint!
    @IBOutlet var messageTextViewPlaceholder: UILabel!
    @IBOutlet var messageTextFieldBackground: UIView!
    @IBOutlet var messageSendButton: UIButton!
    
    var chatRoomIndex: Int?

    var chatRoom: ChatRoom? {
        guard let index = chatRoomIndex else { return nil }
        return ChatList.list[index]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

		configureUI()
        configureTableView()
        configureMessageView()
    }

    @IBAction func messageSendButtonTapped(_ sender: UIButton) {
		addMessage()
    }

    func addMessage() {
        guard let text = messageTextView.text, !text.isEmpty else { return }
        guard let chatRoomIndex else { return }

        let currentDate = DateFormatters.inputFormatter.string(from: Date())

        let newChat = Chat(user: ChatList.me, date: currentDate, message: text)
        ChatList.list[chatRoomIndex].chatList.append(newChat)

        messageTextView.text = ""
        chatTableView.reloadData()

		scrollTableViewToBottom()
    }

    private func configureUI() {
        guard let chatRoom else {
            print("chatRoomItem 반영안됨 error")
            return
        }
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()

        navigationItem.title = chatRoom.chatroomName
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        messageTextFieldBackground.layer.cornerRadius = 10
    }

    private func configureMessageView() {
        messageTextView.delegate = self
    }

    private func configureTableView() {
        chatTableView.delegate = self
        chatTableView.dataSource = self

        let myNib = UINib(nibName: "MyChatTableViewCell", bundle: nil)
        let otherNib = UINib(nibName: "OtherChatTableViewCell", bundle: nil)
        chatTableView.register(myNib, forCellReuseIdentifier: "MyChatTableViewCell")
        chatTableView.register(otherNib, forCellReuseIdentifier: "OtherChatTableViewCell")

        chatTableView.separatorStyle = .none
        chatTableView.allowsSelection = false
        scrollTableViewToBottom()
    }

    private func scrollTableViewToBottom() {
        guard let chatRoom else { return }

        let endIndex = IndexPath(row: chatRoom.chatList.count - 1, section: 0)
        chatTableView.scrollToRow(at: endIndex, at: .bottom, animated: true)
    }
}

extension ChatDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let chatRoom else {
            print("chatRoomItem 반영안됨 error")
            return 0
        }
        return chatRoom.chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let chatRoom else {
            print("chatRoomItem 반영안됨 error")
            return UITableViewCell()
        }
        let chat = chatRoom.chatList[indexPath.row]

        if chat.user.name == ChatList.me.name {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyChatTableViewCell") as! MyChatTableViewCell
            cell.configureData(chat: chat)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OtherChatTableViewCell") as! OtherChatTableViewCell
            cell.configureData(chat: chat)
            return cell
        }
    }
}

extension ChatDetailViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        messageTextViewPlaceholder.isHidden = !textView.text.isEmpty
		messageTextViewHeight.constant = min(textView.contentSize.height, CGFloat(60))
    }
}
