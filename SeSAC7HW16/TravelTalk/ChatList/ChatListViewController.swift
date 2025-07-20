//
//  ChatListViewController.swift
//  SeSAC7HW16
//
//  Created by hyunMac on 7/18/25.
//

import UIKit

class ChatListViewController: UIViewController {

    @IBOutlet var chatListCollectionView: UICollectionView!
    private var filtedIndexes: [Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureSearchController()
		configureCollectionView()
    }

    override func viewDidAppear(_ animated: Bool) {
        chatListCollectionView.reloadData()
    }

    private func configureUI() {
        navigationItem.title = "TRAVEL TALK"
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        navigationItem.backBarButtonItem = backBarButtonItem
    }

    private func configureSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "친구 이름을 검색해보세요"
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    private func configureCollectionView() {
        let xib = UINib(nibName: "ChatListCollectionViewCell", bundle: nil)
        chatListCollectionView.register(xib, forCellWithReuseIdentifier: "ChatListCollectionViewCell")
        chatListCollectionView.delegate = self
        chatListCollectionView.dataSource = self

        let layout = UICollectionViewFlowLayout()
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = deviceWidth - (16 * 2)

        layout.itemSize = CGSize(width: cellWidth, height: 60)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.scrollDirection = .vertical

        chatListCollectionView.collectionViewLayout = layout
    }
}

extension ChatListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {

        let keyword = searchController.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() ?? ""

        if keyword.isEmpty {
            filtedIndexes.removeAll()
        } else {
            filtedIndexes = ChatList.list.enumerated().filter {
                $0.element.chatroomName.lowercased().contains(keyword)
            }.map {
                $0.offset
            }
        }
        chatListCollectionView.reloadData()
    }
}

extension ChatListViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filtedIndexes.count != 0 ? filtedIndexes.count : ChatList.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChatListCollectionViewCell", for: indexPath) as! ChatListCollectionViewCell

        let availableIndex = filtedIndexes.count != 0 ? filtedIndexes[indexPath.item] : indexPath.item
        cell.configureData(index: IndexPath(row: availableIndex, section: 0))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ChatDetailViewController") as! ChatDetailViewController
        let availableIndex = filtedIndexes.count != 0 ? filtedIndexes[indexPath.item] : indexPath.item
        vc.chatRoomIndex = ChatList.list[availableIndex].chatroomId - 1

        navigationController?.pushViewController(vc, animated: true)
    }
}
