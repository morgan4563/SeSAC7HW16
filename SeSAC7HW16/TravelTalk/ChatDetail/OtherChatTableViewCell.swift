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

    func configureData(chat: Chat) {
        profileImage.image = UIImage(named: chat.user.image)
        nameLabel.text = chat.user.name
        chatLabel.text = chat.message

        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm"
        let date = df.date(from: chat.date)
        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "MM.dd a"
        dateLabel.text = df.string(from: date ?? Date())
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
