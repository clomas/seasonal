//
//  Produce.swift
//  Seasonal
//
//  Created by Clint Thomas on 21/11/20.
//  Copyright © 2020 Clint Thomas. All rights reserved.
//

import Foundation

struct ProduceModel {

	var produce: Produce!

	init(produce: Produce) {
		self.produce = produce
	}
	var id: Int {
		return self.produce.id
	}
	var produceName: String {
		return self.produce.name
	}
	var imageName: String {
		return self.produce.imageName
	}
	var category: ViewDisplayed.ProduceCategory? {
		return self.produce.category
	}
	var months: [Month] {
		return self.produce.months
	}
	var seasons: [Season] {
		return self.produce.seasons
	}
	var liked: Bool {
		get {
			return self.produce.liked
		} set(liked) {
			self.produce.liked = liked
		}
	}
}

struct Produce {
    let id: Int
    let name: String
    let category: ViewDisplayed.ProduceCategory
    let imageName: String
    let description: String // Not implemented yet
    let months: [Month]
    let seasons: [Season]
    var liked: Bool
}

extension Produce {
	var produceId: Int {
		return id
	}
}
