//
//  PhotoCollectionViewController.swift
//  MyPhotoViewer
//
//  Created by Amitai Blickstein on 9/19/17.
//  Copyright © 2017 Amitai Blickstein. All rights reserved.
//

import UIKit

private let reuseIdentifier = L10n.photoCellReuseID

class PhotoCollectionViewController: UICollectionViewController {
	var photos = [PhotoData]()
	var images = [UIImage]()
	
	init() {
		super.init(collectionViewLayout: PhotoCollectionViewController.flowLayout)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		// Register cell classes
		collectionView?.register(PhotoCell.self, forCellWithReuseIdentifier: reuseIdentifier)
		
		collectionView?.backgroundColor = .white
		title = "YAPhotoViewer"
		
		do { try refresh() }
		catch { print(error.localizedDescription) }
    }
	
	@objc func refresh() throws {
		let task = createPhotoDataTask()
		task.resume()
	}
	
	private func createPhotoDataTask() -> URLSessionTask {
		let handler = { (data: Data?, response: URLResponse?, error: Error?) in
			do {
				if let error = error { throw NetworkError.responseFailed(reason: "Received error: ↴\n\(error.localizedDescription)") }
				guard let data = data else { throw NetworkError.responseFailed(reason: "Can't find response data.") }
				
				let photosData = try JSONDecoder().decode([PhotoData].self, from: data)
				self.photos = photosData
				DispatchQueue.main.async {
					self.collectionView?.reloadData()
				}
			}
			catch {
				print(error.localizedDescription)
			}
		}
		
		let session = URLSession.shared
		guard let photoBankURL = URL(string: L10n.httpJsonplaceholderTypicodeComPhotos) else { fatalError("Flawed HTTPS address given.") }
		let photosRequest = URLRequest(url: photoBankURL)
		let task = session.dataTask(with: photosRequest, completionHandler: handler)
		
		return task
	}
	

	
	// MARK: UICollectionViewDataSource
	
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
		guard let photoCell = cell as? PhotoCell else {
			return cell }
		
		photoCell.photo = photos[indexPath.row]
		return photoCell
    }

	
	 // MARK: UICollectionViewDelegate
	
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }

	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let photo = photos[indexPath.row]
		presentDetailView(for: photo)
	}
	
	fileprivate func presentDetailView(for photo: PhotoData) {
		let detailVC = PhotoDetailViewController()

			detailVC.modalPresentationStyle = .custom
			detailVC.transitioningDelegate = self
			detailVC.photo = photo
			
			present(detailVC, animated: true, completion: nil)
	}
}


// MARK: - UIViewControllerTransitioningDelegate


extension PhotoCollectionViewController: UIViewControllerTransitioningDelegate {
	func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return PresentDetailTransition()
	}
	
	func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return DismissDetailTransition()
	}
}


extension PhotoCollectionViewController {
	static var flowLayout: UICollectionViewFlowLayout {
		let layout = UICollectionViewFlowLayout()
		layout.itemSize = CGSize(width: 106.0, height: 106.0)
		layout.minimumInteritemSpacing = 1.0
		layout.minimumLineSpacing = 1.0
		
		return layout
	}
}
