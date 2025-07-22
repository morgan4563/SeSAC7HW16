//
//  OtherChatTableViewCell.swift
//  SeSAC7HW16
//
//  Created by hyunMac on 7/20/25.
//

import UIKit

class OtherChatTableViewCell: UITableViewCell {

    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var chatLabel: UILabel!
    @IBOutlet var chatBubble: UIView!
    @IBOutlet var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    private func configureUI() {
        profileImage.layer.cornerRadius = profileImage.bounds.width / 2
        profileImage.clipsToBounds = true

        chatBubble.layer.cornerRadius = 10
        chatBubble.layer.borderWidth = 1
        chatBubble.layer.borderColor = UIColor.lightGray.cgColor
    }
}

extension OtherChatTableViewCell: TableCellDesignProtocol {
    func configureData(chat: Chat) {
        profileImage.image = UIImage(named: chat.user.image)
        nameLabel.text = chat.user.name
        chatLabel.text = chat.message

        if let date = DateFormatters.inputFormatter.date(from: chat.date) {
            dateLabel.text = DateFormatters.outputTimeTypeFormatter.string(from: date)
        } else {
            dateLabel.text = ""
        }
    }
}
