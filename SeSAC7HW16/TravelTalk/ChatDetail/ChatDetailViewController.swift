//
//  ChatDetailViewController.swift
//  SeSAC7HW16
//
//  Created by hyunMac on 7/20/25.
//

import UIKit

class ChatDetailViewController: UIViewController {

    @IBOutlet var chatTableView: UITableView!
    @IBOutlet var messageTextField: UITextField!
    @IBOutlet var messageTextFieldBackground: UIView!
    @IBOutlet var messageSendButton: UIButton!
    
    var chatRoomIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

		configureUI()
        configureTableView()
    }

    @IBAction func messageSendButtonTapped(_ sender: UIButton) {
		addMessage()
    }

    func addMessage() {
        guard let text = messageTextField.text, !text.isEmpty else { return }
        guard let chatRoomIndex else { return }

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let currentDate = formatter.string(from: Date())

        let newChat = Chat(user: ChatList.me, date: currentDate, message: text)
        ChatList.list[chatRoomIndex].chatList.append(newChat)

        messageTextField.text = ""
        chatTableView.reloadData()

		scrollTableViewToBottom()
    }

    private func configureUI() {
        guard let chatRoomIndex else {
            print("chatRoomItem 반영안됨 error")
            return
        }
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()

        navigationItem.title = ChatList.list[chatRoomIndex].chatroomName
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        messageTextFieldBackground.layer.cornerRadius = 10
    }

    private func configureTableView() {
        chatTableView.delegate = self
        chatTableView.dataSource = self

        let myNib = UINib(nibName: "MyChatTableViewCell", bundle: nil)
        let otherNib = UINib(nibName: "OtherChatTableViewCell", bundle: nil)
        chatTableView.register(myNib, forCellReuseIdentifier: "MyChatTableViewCell")
        chatTableView.register(otherNib, forCellReuseIdentifier: "OtherChatTableViewCell")

        chatTableView.separatorStyle = .none
        scrollTableViewToBottom()
    }

    private func scrollTableViewToBottom() {
        guard let chatRoomIndex else { return }

        let endIndex = IndexPath(row: ChatList.list[chatRoomIndex].chatList.count - 1, section: 0)
        chatTableView.scrollToRow(at: endIndex, at: .bottom, animated: true)
    }
}

extension ChatDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let chatRoomIndex else {
            print("chatRoomItem 반영안됨 error")
            return 0
        }
        return ChatList.list[chatRoomIndex].chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let chatRoomIndex else {
            print("chatRoomItem 반영안됨 error")
            return UITableViewCell()
        }
        let chat = ChatList.list[chatRoomIndex].chatList[indexPath.row]

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
