//
//  ChatListCollectionViewCell.swift
//  SeSAC7HW16
//
//  Created by hyunMac on 7/19/25.
//

import UIKit

class ChatListCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func configureData(index: IndexPath) {
        let chatRoom = ChatList.list[index.item]
        imageView.image = UIImage(named: chatRoom.chatroomImage)
        nameLabel.text = chatRoom.chatroomName

        if let lastChat = chatRoom.chatList.last {
            messageLabel.text = lastChat.message
            print(lastChat.date)
            dateLabel.text = lastChat.date
        }
    }
}
