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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func refresh() throws {
		
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
		
		task.resume()
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
