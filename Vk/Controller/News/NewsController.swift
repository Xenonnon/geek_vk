//
//  NewsController.swift
//  Vk
//
//  Created by Евгений Дербенев on 28.12.2020.
//

import UIKit

class NewsController: UITableViewController {

    let myFriends = Friends.makeFriends()
    let news = NewsClass.makeNews()
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count         
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell
        else { return UITableViewCell() }
        
        cell.newsAvatar.image = myFriends[indexPath.row].userAvatar
        cell.newsName.text = myFriends[indexPath.row].userName
        cell.newsText.text = news[indexPath.row].newsText
        cell.newsImage.image = news[indexPath.row].newsImage
        let viewsCount = Int.random(in: 0...25)
        cell.newsViewsCounter.textColor = viewsCount == 0 ? .black : .systemBlue
        cell.newsViewsSignBtn.tintColor = viewsCount == 0 ? .black : .systemBlue
        cell.newsViewsCounter.text = String(viewsCount)
        return cell
    }

}
