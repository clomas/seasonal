//
//  ProduceDataSevice.swift
//  Seasonal
//
//  Created by Clint Thomas on 2/3/21.
//  Copyright © 2021 Clint Thomas. All rights reserved.
//

import Foundation

class ProduceDataService {

	func updateLike(id: Int, liked: Bool) {
		// Update in local database
		let likedProduce = LikedProduce(id: id)

		if liked == true {
			likedProduce.saveItem()
		} else {
			likedProduce.deleteItem()
		}
	}
}
