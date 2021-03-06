//
//  _NetworkService.swift
//  Seasonal
//
//  Created by Clint Thomas on 16/2/21.
//  Copyright © 2021 Clint Thomas. All rights reserved.
//
// thank you - https://stackoverflow.com/questions/59245501/ios13-check-for-internet-connection-instantly

import Foundation
import Network

protocol NetworkObserver: AnyObject {
	func internetStatusDidChange(status: NWPath.Status)
}

final class NetworkService {

	class func instance() -> NetworkService {
		return sharedInstance
	}

	struct NetworkChangeObservation {
		weak var observer: NetworkObserver?
	}

	private var monitor = NWPathMonitor()
	private static let sharedInstance = NetworkService()
	private var observations = [ObjectIdentifier: NetworkChangeObservation]()

	var currentStatus: NWPath.Status {
		return monitor.currentPath.status
	}

	var networkUpdate: ((Bool) -> Void)?

	init() {
		startMonitoring()
	}

	func startMonitoring() {
		monitor.pathUpdateHandler = { [unowned self] path in
			for (id, observations) in self.observations {

				// If any observer is nil, remove it from the list of observers
				guard let observer = observations.observer else {
					self.observations.removeValue(forKey: id)
					continue
				}

				DispatchQueue.main.async(execute: {
					observer.internetStatusDidChange(status: path.status)
				})
			}
		}
		monitor.start(queue: DispatchQueue.global(qos: .background))
	}

	func internetStatusDidChange(status: NWPath.Status) {
		var internetStatus = false

		switch status {
		case .satisfied:
			internetStatus = true
		case .unsatisfied:
			internetStatus = false
		default:
			internetStatus = false
		}
		if let networkUpdateCallback = networkUpdate {
			// callback to viewModel
			networkUpdateCallback(internetStatus)
		}
	}

	func removeObserver(observer: NetworkObserver) {
		let id = ObjectIdentifier(observer)
		observations.removeValue(forKey: id)
	}
}
