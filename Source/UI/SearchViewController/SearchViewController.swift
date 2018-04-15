//
//  SearchViewController.swift
//  GithubSearch
//
//  Created by Anton Kozlovskyi on 4/15/18.
//  Copyright © 2018 Anton. All rights reserved.
//

import UIKit

import CoreData

class SearchViewController: UIViewController, RootViewGettable {
    typealias RootViewType = SearchView
    
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<SearchRepository> = {
        let descriptor = NSSortDescriptor(key: #keyPath(SearchRepository.stars), ascending: true)
        let request = SearchRepository.createFetchRequest(sortDescriptors: [descriptor])
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: request,
                                                                  managedObjectContext: CoreDataManager.shared.viewContext,
                                                                  sectionNameKeyPath: nil,
                                                                  cacheName: nil)
        fetchedResultsController.delegate = self
        
        return fetchedResultsController as! NSFetchedResultsController<SearchRepository>
    }()
    
    var context: SearchContext? {
        didSet {
            context?.load()
        }
    }
    
    //MARK: -
    //MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
    }
    
    //MARK: -
    //MARK: Interface handling
    
    @IBAction func onSearchButton(sender: UIButton) {
        self.context = SearchContext(self.rootView?.searchField?.text ?? "")
    }
    
}

//MARK: -
//MARK: UITableView delegate

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

//MARK: -
//MARK: UITableView dataSource

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let repositories = self.fetchedResultsController.fetchedObjects else { return 0 }
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .green
        cell.textLabel?.text = "\(indexPath.row + 1)"
        
        return cell
    }
}

//MARK: -
//MARK: FetchResultsController delegate

extension SearchViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.rootView?.tableView?.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.rootView?.tableView?.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?)
    {
        let tableView = self.rootView?.tableView
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                tableView?.insertRows(at: [indexPath], with: .fade)
            }
            break;
        case .delete:
            if let indexPath = indexPath {
                tableView?.deleteRows(at: [indexPath], with: .fade)
            }
            break;
        default:
            print("")
        }
    }
}
