//
//  FeedRefreshViewController.swift
//  EssentialFeed
//
//  Created by Vanya Mutafchieva on 27/02/2025.
//

import UIKit

public final class FeedRefreshViewController: NSObject, FeedLoadingView {
    public lazy var view = loadView()
    
    private let loadFeed: () -> Void //private let presenter: FeedPresenter
    
    init(loadFeed: @escaping () -> Void) { // init(presenter: FeedPresenter) {
        self.loadFeed = loadFeed // self.presenter = presenter
    }
    
    @objc func refresh() {
        loadFeed() // presenter.loadFeed()
    }
    
    func display(_ viewModel: FeedLoadingViewModel) { 
        if viewModel.isLoading {
            view.beginRefreshing()
        } else {
            view.endRefreshing()
        }
    }
    
    private func loadView() -> UIRefreshControl {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return view
    }
}
