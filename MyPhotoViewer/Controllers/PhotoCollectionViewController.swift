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
	
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
		
		do { try refresh() }
		catch { print(error.localizedDescription) }
    }
	
	func refresh() throws {
		let task = createPhotoDownloadTask()
		task.resume()
	}
	
	private func createPhotoDownloadTask() -> URLSessionDownloadTask {
		let handler = { (location: URL?, response: URLResponse?, error: Error?) in
			do {
				if let error = error { throw NetworkError.responseFailed(reason: "Received error: ↴\n\(error.localizedDescription)") }
				guard let location = location else { throw NetworkError.responseFailed(reason: "Can't find response data.") }
			
				let data = try Data(contentsOf: location)
				let photoData = try JSONDecoder().decode(PhotoData.self, from: data)
				
				self.photos.append(photoData)
				DispatchQueue.main.async {
					self.collectionView?.reloadData()
				}
			}
			catch {
				print(error.localizedDescription)
			}
		}
		
		let session = URLSession.shared
		let photoBankURL = URL(fileURLWithPath: L10n.httpJsonplaceholderTypicodeComPhotos)
		let photosRequest = URLRequest(url: photoBankURL)
		let task = session.downloadTask(with: photosRequest, completionHandler: handler)
		
		return task
	}
	

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
		
		if let photoCell = cell as? PhotoCell {
			photoCell.photo = photos[indexPath.row]
			return photoCell
		}
    
        return cell
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
		let detailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: L10n.photoDetailViewController)
		detailViewController.photo = photo
		
		present(detailViewController, animated: true, completion: nil)

	}
}
