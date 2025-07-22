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
		configureUI()
    }

    private func configureUI() {
        imageView.layer.cornerRadius = imageView.bounds.width / 2
        nameLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        messageLabel.font = .systemFont(ofSize: 14)
        dateLabel.font = .systemFont(ofSize: 12)

        messageLabel.textColor = .systemGray
        dateLabel.textColor = .systemGray
    }
}

extension ChatListCollectionViewCell: CollectionViewDesignProtocol {
    func configureData(index: IndexPath) {
        let chatRoom = ChatList.list[index.item]
        imageView.image = UIImage(named: chatRoom.chatroomImage)
        nameLabel.text = chatRoom.chatroomName

        if let lastChat = chatRoom.chatList.last {
            messageLabel.text = lastChat.message

            if let date = DateFormatters.inputFormatter.date(from: lastChat.date) {
                dateLabel.text = DateFormatters.outputDateTypeFormatter.string(from: date)
            } else {
                dateLabel.text = ""
            }
        }
    }
}
